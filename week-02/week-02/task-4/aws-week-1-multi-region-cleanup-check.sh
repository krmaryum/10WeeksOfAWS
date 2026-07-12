#!/bin/bash

echo "============================================"
echo " AWS Week 1 Multi-Region Cleanup Check"
echo "============================================"
echo

# Regions to check
REGIONS=(
  "us-east-1"   # N. Virginia
  "us-east-2"   # Ohio
  "us-west-1"   # N. California
  "us-west-2"   # Oregon
)

echo "This script checks resources only."
echo "It does NOT delete, terminate, detach, or release anything."
echo

echo "Checking AWS identity..."
aws sts get-caller-identity --output table
echo

for REGION in "${REGIONS[@]}"
do
  echo "=================================================="
  echo " Region: $REGION"
  echo "=================================================="
  echo

  echo "1. Checking EC2 instances in $REGION..."
  aws ec2 describe-instances \
    --region "$REGION" \
    --query "Reservations[*].Instances[*].[InstanceId,State.Name,InstanceType,PublicIpAddress,Tags]" \
    --output table

  echo
  echo "2. Checking EBS volumes in $REGION..."
  aws ec2 describe-volumes \
    --region "$REGION" \
    --query "Volumes[*].[VolumeId,State,Size,VolumeType,Attachments[0].InstanceId]" \
    --output table

  echo
  echo "3. Checking unattached EBS volumes in $REGION..."
  aws ec2 describe-volumes \
    --region "$REGION" \
    --filters Name=status,Values=available \
    --query "Volumes[*].[VolumeId,State,Size,VolumeType,CreateTime]" \
    --output table

  echo
  echo "4. Checking Elastic IPs in $REGION..."
  aws ec2 describe-addresses \
    --region "$REGION" \
    --query "Addresses[*].[PublicIp,AllocationId,InstanceId,AssociationId]" \
    --output table

  echo
  echo "5. Checking NAT Gateways in $REGION..."
  aws ec2 describe-nat-gateways \
    --region "$REGION" \
    --query "NatGateways[*].[NatGatewayId,State,VpcId,SubnetId]" \
    --output table

  echo
  echo "6. Checking Load Balancers in $REGION..."
  aws elbv2 describe-load-balancers \
    --region "$REGION" \
    --query "LoadBalancers[*].[LoadBalancerName,Type,State.Code,DNSName]" \
    --output table 2>/dev/null || echo "No ELBv2 load balancers found or no permission."

  echo
  echo "7. Checking RDS DB instances in $REGION..."
  aws rds describe-db-instances \
    --region "$REGION" \
    --query "DBInstances[*].[DBInstanceIdentifier,DBInstanceStatus,DBInstanceClass,Engine]" \
    --output table 2>/dev/null || echo "No RDS DB instances found or no permission."

  echo
done

echo "=================================================="
echo " Global Services Check"
echo "=================================================="
echo

echo "8. Checking S3 buckets..."
aws s3 ls

echo
echo "9. Checking IAM users..."
aws iam list-users \
  --query "Users[*].[UserName,CreateDate]" \
  --output table

echo
echo "10. Checking IAM roles related to training/github..."
aws iam list-roles \
  --query "Roles[?contains(RoleName, 'Training') || contains(RoleName, 'training') || contains(RoleName, 'github') || contains(RoleName, 'GitHub')].[RoleName,CreateDate]" \
  --output table

echo
echo "11. Checking customer managed IAM policies..."
aws iam list-policies \
  --scope Local \
  --query "Policies[*].[PolicyName,Arn,CreateDate]" \
  --output table

echo
echo "12. Checking IAM OIDC providers..."
aws iam list-open-id-connect-providers \
  --query "OpenIDConnectProviderList[*].Arn" \
  --output table

echo
echo "============================================"
echo " Cleanup check completed."
echo " Review carefully before deleting anything."
echo "============================================"
