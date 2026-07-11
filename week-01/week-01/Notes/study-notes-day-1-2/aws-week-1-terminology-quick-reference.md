# AWS Week 1 Terminology Quick Reference

## Overview

This quick reference summarizes the important AWS and DevOps terms used during Week 1.

Week 1 covered AWS account security, IAM users/groups/roles, policies, S3, EC2, Billing, STS temporary credentials, GitHub OIDC, and GitHub Actions authentication.

---

# AWS Account & Security

| Term | Stands For | Simple Meaning | Example / Where Used |
|---|---|---|---|
| `AWS` | Amazon Web Services | Cloud platform used to create and manage cloud resources | EC2, S3, IAM, Billing |
| `Root User` | Main AWS account owner | Full access to everything in the AWS account | Used for account setup, MFA, billing access |
| `MFA` | Multi-Factor Authentication | Extra security step after password | Enabled MFA for root account |
| `Billing` | AWS Billing and Cost Management | Shows AWS usage, charges, budgets, and cost alerts | Created budget alert and billing view lab |
| `Budget` | AWS Budget | Helps monitor AWS spending | Created budget alert to avoid unexpected charges |

---

# IAM Basics

| Term | Stands For | Simple Meaning | Example / Where Used |
|---|---|---|---|
| `IAM` | Identity and Access Management | AWS service for managing users, groups, roles, and permissions | Used in all Week 1 labs |
| `IAM User` | Identity and Access Management User | Identity for login or programmatic access | learner-s3, learner-ec2, learner-billing |
| `IAM Group` | Identity and Access Management Group | Collection of IAM users | S3ReadOnlyGroup, BillingViewGroup |
| `IAM Role` | Identity and Access Management Role | Temporary permission identity | TrainingReadOnlyRole, GitHub OIDC role |
| `Principal` | Principal | Who is requesting access | User, role, service, or federated identity |

---

# IAM Policies

| Term | Stands For | Simple Meaning | Example / Where Used |
|---|---|---|---|
| `Policy` | Policy document | Permission document that defines allowed or denied actions | S3, EC2, Billing, role policies |
| `AWS Managed Policy` | AWS managed policy | Policy created and managed by AWS | ReadOnlyAccess, AmazonS3ReadOnlyAccess |
| `Customer Managed Policy` | Customer managed policy | Policy created by you | CustomS3ReadOnlyTrainingPolicy |
| `JSON` | JavaScript Object Notation | Format used for IAM policies | Version, Statement, Action, Resource |
| `Statement` | Statement block | IAM policy rule block | Used inside JSON policies |
| `Effect` | Effect | Allow or Deny decision | Effect: Allow |
| `Action` | Action | AWS API operation | s3:GetObject, sts:AssumeRole |
| `Resource` | Resource | AWS resource where permission applies | arn:aws:s3:::bucket-name |
| `Least Privilege` | Least privilege | Give only required permissions | Read-only policies instead of admin access |

---

# S3 Terms

| Term | Stands For | Simple Meaning | Example / Where Used |
|---|---|---|---|
| `S3` | Simple Storage Service | AWS object storage service | S3 read-only labs |
| `Bucket` | Bucket | S3 container that holds objects/files | ali-s3-t1, user-s3-t-d |
| `Object` | Object | File/data stored in a bucket | notes.pdf, image.png, folder/file.txt |
| `Object Key` | Object key | Object name/path inside S3 | folder1/file1.txt |
| `Prefix` | Prefix | Folder-like part of an object key | folder1/ in folder1/file1.txt |
| `Bucket ARN` | Amazon Resource Name for bucket | ARN for bucket itself | arn:aws:s3:::bucket-name |
| `Object ARN` | Amazon Resource Name for objects | ARN for objects inside bucket | arn:aws:s3:::bucket-name/* |

---

# EC2 & Billing

| Term | Stands For | Simple Meaning | Example / Where Used |
|---|---|---|---|
| `EC2` | Elastic Compute Cloud | Virtual server in AWS | EC2 read-only lab |
| `Instance` | EC2 instance | A running or stopped virtual server | View EC2 instances |
| `AmazonEC2ReadOnlyAccess` | AWS managed policy | Allows viewing EC2 resources | EC2 read-only lab |
| `AWSBillingReadOnlyAccess` | AWS managed policy | Allows viewing billing information | BillingViewGroup lab |
| `Billing Dashboard` | Billing Dashboard | AWS page for cost and usage information | Billing view access lab |

---

# Role, STS & Temporary Access

| Term | Stands For | Simple Meaning | Example / Where Used |
|---|---|---|---|
| `STS` | Security Token Service | AWS service that provides temporary credentials | Switch Role and GitHub OIDC |
| `Temporary Credentials` | Temporary credentials | Short-lived AWS credentials | Created by STS |
| `AssumeRole` | Assume Role | Allows a user or service to assume an IAM role | sts:AssumeRole |
| `Switch Role` | Switch Role | IAM user temporarily uses role permissions | TrainingReadOnlyRole |
| `Trust Policy` | Trust policy | Defines who can assume a role | Role trust relationship |
| `Permissions Policy` | Permissions policy | Defines what can be done after access is granted | ReadOnlyAccess attached to role |
| `ReadOnlyAccess` | ReadOnlyAccess | AWS managed read-only policy | TrainingReadOnlyRole |

---

# GitHub OIDC

| Term | Stands For | Simple Meaning | Example / Where Used |
|---|---|---|---|
| `OIDC` | OpenID Connect | Identity system used to prove identity | GitHub Actions to AWS authentication |
| `OIDC Token` | OpenID Connect Token | Short-lived identity token | GitHub Actions proves identity to AWS |
| `IAM OIDC Provider` | IAM OpenID Connect Provider | Allows AWS to trust GitHub OIDC tokens | token.actions.githubusercontent.com |
| `Audience` | Audience | Token target | sts.amazonaws.com |
| `Subject` | Subject | Repo or branch identity inside token | repo:username/repo:* |
| `AssumeRoleWithWebIdentity` | Assume Role With Web Identity | STS action used with OIDC token | GitHub Actions assumed AWS role |
| `Federated Principal` | Federated principal | External identity provider trusted by AWS | GitHub OIDC provider in trust policy |

---

# GitHub Actions

| Term | Stands For | Simple Meaning | Example / Where Used |
|---|---|---|---|
| `GitHub Actions` | GitHub Actions | GitHub CI/CD service | AWS OIDC workflow |
| `Workflow` | Workflow | Automation YAML file | aws-oidc-challenge.yml |
| `Job` | Job | Group of workflow steps | aws-oidc-challenge job |
| `Step` | Step | Single workflow task | Checkout, configure credentials, AWS CLI |
| `Runner` | Runner | Machine running workflow | ubuntu-latest |
| `workflow_dispatch` | workflow dispatch | Manual workflow trigger | Run workflow button |
| `id-token: write` | id-token permission | Allows workflow to request OIDC token | Required for OIDC |
| `contents: read` | contents permission | Allows workflow to read repo contents | Required for checkout |
| `configure-aws-credentials` | AWS credentials GitHub Action | Configures AWS temporary credentials | aws-actions/configure-aws-credentials@v4 |

---

# Errors & Security

| Term | Stands For | Simple Meaning | Example / Where Used |
|---|---|---|---|
| `AccessDenied` | Access denied | AWS permission error | User or role does not have permission |
| `Not Authorized` | Not authorized | Permission denied message | Denied action testing |
| `Long-Lived Access Keys` | Long-lived access keys | Permanent AWS access keys | Avoid storing in GitHub Secrets |
| `Temporary Access` | Temporary access | Short-term access | Safer than permanent credentials |
| `Denied Action` | Denied action | Action intentionally blocked | Upload/delete denied in read-only labs |
| `Allowed Action` | Allowed action | Action permitted by policy | Read/list actions allowed |
| `Public Screenshot Risk` | Screenshot security risk | Sensitive info exposed in screenshots | Crop account ID, root email, keys |
| `Least Privilege Testing` | Least privilege testing | Test allowed and denied actions | Confirms policy is working correctly |

---

# Quick Review

| Question | Quick Answer |
|---|---|
| What is IAM? | AWS service for identity and permissions |
| What is STS? | Security Token Service; gives temporary credentials |
| What is ARN? | Amazon Resource Name; unique AWS resource address |
| What is OIDC? | OpenID Connect; identity system used by GitHub Actions |
| What is a role? | Temporary access identity |
| What is a policy? | JSON permission document |
| What is S3 object? | File/data stored inside an S3 bucket |
| What is `sts:AssumeRole`? | Permission to switch into an IAM role |
| What is `AssumeRoleWithWebIdentity`? | STS action used with OIDC tokens |
| Why use GitHub OIDC? | To access AWS without long-lived access keys |

# Week 1 One-Line Summary

```text
Week 1 taught AWS account security, IAM users/groups/roles, policies, S3/EC2/Billing read-only access, STS temporary credentials, and GitHub OIDC secure access without long-lived keys.
```

Alhamdulillah, Week 1 is completed.