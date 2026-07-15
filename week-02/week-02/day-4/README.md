# LinkedIn Post – Week 2 Day 4

## AWS Organizations, SCPs, IAM Identity Center, and Multi-Account Governance

Alhamdulillah, I completed Week 2 Day 4 of my AWS learning journey.

Topic: AWS Organizations, Service Control Policies, IAM Identity Center, and multi-account architecture.

This lesson helped me understand why companies should not run all environments inside one shared AWS account.

When development, testing, production, security, and finance teams share one account, it creates major risks:

- Shared permissions
- Large blast radius
- Mixed billing
- Difficult governance
- Weak environment isolation

The key lesson is that this is not only an IAM problem. It is an account-boundary, governance, security, operations, and billing problem.

## What I Learned

AWS Organizations helps companies centrally manage multiple AWS accounts.

Main concepts I practiced:

- AWS Organization
- Organization Root
- Management Account
- Member Account
- Organizational Unit
- Service Control Policy
- IAM Identity Center
- Permission Set
- Temporary STS Session
- Consolidated Billing

## Practical Lab

In this lab, I created a small multi-account environment and tested this important rule:

```text
IAM Identity Center permission set allows s3:CreateBucket
+
OU Service Control Policy explicitly denies s3:CreateBucket
=
Final result: AccessDenied
```

The important result:

Before moving the member account into the OU, S3 bucket creation worked.

After moving the same member account into the OU with the SCP attached, S3 bucket creation failed with AccessDenied.

This proves that an SCP is a guardrail, not a permission grant.

## Important Memory Line

```text
IAM gives access.
Permission Set grants workforce access.
SCP limits access.
STS provides temporary sessions.
```

## Final Takeaway

AWS Organizations provides centralized multi-account management.

OUs group accounts.

SCPs enforce guardrails.

IAM Identity Center manages workforce access.

Permission Sets define user access.

STS creates temporary sessions.

Consolidated Billing gives one billing view across accounts.

This was a very practical lesson for understanding real-world AWS governance and cloud security design.

## Hashtags

#AWS #AWSOrganizations #SCP #IAMIdentityCenter #IAM #STS #CloudSecurity #DevOps #MultiAccountArchitecture #Governance #ConsolidatedBilling #LearningInPublic #AWSCommunity
