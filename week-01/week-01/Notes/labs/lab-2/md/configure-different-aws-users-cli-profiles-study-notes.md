# Configure Different AWS Users – Study Notes

## Overview

Yes, we can configure different AWS users.

There are two common meanings:

```text
1. Different IAM users for AWS Console login
2. Different AWS CLI users on the same laptop using profiles
```

This is useful for learning IAM permissions and testing allowed/denied actions.

---

# Why Configure Different Users?

Different users can have different permissions.

Example:

```text
learner-s3      → Only S3 read-only access
learner-ec2     → Only EC2 read-only access
learner-billing → Only billing view access
```

This helps understand:

```text
IAM users
IAM groups
IAM policies
Least privilege
Access denied testing
AWS CLI profiles
```

---

# Part 1 – Different IAM Users for AWS Console

## Example Users

| IAM User | Group | Permission |
|---|---|---|
| learner-s3 | S3ReadOnlyGroup | AmazonS3ReadOnlyAccess |
| learner-ec2 | EC2ReadOnlyGroup | AmazonEC2ReadOnlyAccess |
| learner-billing | BillingViewGroup | Billing view-only access |

---

## Recommended IAM Flow

```text
Policy → Group → User
```

Example:

```text
AmazonS3ReadOnlyAccess
        ↓
S3ReadOnlyGroup
        ↓
learner-s3
```

This is better than attaching policies directly to each user.

---

# Why Use Groups?

IAM groups make permission management easier.

If multiple users need the same permissions, we attach the policy to the group and add users to that group.

Example:

```text
S3ReadOnlyGroup has AmazonS3ReadOnlyAccess
All users inside this group get S3 read-only access
```

---

# Part 2 – Configure Different AWS CLI Users

AWS CLI supports multiple profiles.

A profile is like a saved login configuration for a specific IAM user.

Example profiles:

```text
learner-s3
learner-ec2
learner-billing
```

---

# Configure First AWS CLI Profile

Run:

```bash
aws configure --profile learner-s3
```

It will ask:

```text
AWS Access Key ID
AWS Secret Access Key
Default region name
Default output format
```

Example region/output:

```text
Default region name: us-east-1
Default output format: json
```

---

# Configure Second AWS CLI Profile

Run:

```bash
aws configure --profile learner-ec2
```

Again enter:

```text
Access key
Secret key
Region
Output format
```

---

# Check Configured Profiles

Run:

```bash
aws configure list-profiles
```

Expected output example:

```text
default
learner-s3
learner-ec2
learner-billing
```

---

# Use a Specific Profile

## Use learner-s3 profile

```bash
aws s3 ls --profile learner-s3
```

## Use learner-ec2 profile

```bash
aws ec2 describe-instances --profile learner-ec2
```

## Check identity

```bash
aws sts get-caller-identity --profile learner-s3
```

---

# Where AWS CLI Stores Profiles

AWS CLI stores credentials here:

```bash
~/.aws/credentials
```

AWS CLI stores region/output config here:

```bash
~/.aws/config
```

---

## Example credentials file

```ini
[learner-s3]
aws_access_key_id = YOUR_ACCESS_KEY
aws_secret_access_key = YOUR_SECRET_KEY

[learner-ec2]
aws_access_key_id = YOUR_ACCESS_KEY
aws_secret_access_key = YOUR_SECRET_KEY
```

---

## Example config file

```ini
[profile learner-s3]
region = us-east-1
output = json

[profile learner-ec2]
region = us-east-1
output = json
```

---

# Important Security Note

Never share:

```text
Access key
Secret access key
AWS account ID
MFA QR code
Root email
Payment details
Screenshots showing credentials
```

If access keys are exposed, delete or rotate them immediately.

---

# Lab 2 Example – learner-s3

For Lab 2, if the user `learner-s3` has only:

```text
AmazonS3ReadOnlyAccess
```

Then this command should work:

```bash
aws s3 ls --profile learner-s3
```

This command should fail:

```bash
aws s3 mb s3://my-test-bucket-name --profile learner-s3
```

Expected error:

```text
AccessDenied
```

This is good because it proves least privilege is working.

---

# Temporary Profile Switching

Instead of writing `--profile` every time, we can set the profile temporarily.

## Git Bash / Linux / WSL

```bash
export AWS_PROFILE=learner-s3
```

Now run:

```bash
aws s3 ls
```

To remove:

```bash
unset AWS_PROFILE
```

## Windows PowerShell

```powershell
$env:AWS_PROFILE="learner-s3"
```

Now run:

```powershell
aws s3 ls
```

To remove:

```powershell
Remove-Item Env:AWS_PROFILE
```

---

# Default Profile vs Named Profile

## Default Profile

If we run:

```bash
aws configure
```

It creates the default profile.

Then commands can run without `--profile`:

```bash
aws s3 ls
```

## Named Profile

If we run:

```bash
aws configure --profile learner-s3
```

Then we must use:

```bash
aws s3 ls --profile learner-s3
```

or set:

```bash
export AWS_PROFILE=learner-s3
```

---

# Best Practice

For learning, use named profiles.

Example:

```text
default       → personal/admin practice user
learner-s3    → S3 read-only test user
learner-ec2   → EC2 read-only test user
```

This helps avoid confusion.

---

# Common Mistakes

| Mistake | Problem | Fix |
|---|---|---|
| Using root user access keys | Very dangerous | Do not create root access keys |
| Sharing access keys in screenshots | Security risk | Crop/blur or never show keys |
| Forgetting `--profile` | Command may use wrong user | Always specify profile |
| Giving AdministratorAccess | Too much permission | Use least privilege |
| Expecting read-only user to upload | Not allowed | Upload should show AccessDenied |
| Not checking identity | May test wrong user | Use `aws sts get-caller-identity` |

---

# Quick Commands Summary

```bash
aws configure --profile learner-s3
aws configure --profile learner-ec2
aws configure list-profiles
aws sts get-caller-identity --profile learner-s3
aws s3 ls --profile learner-s3
aws ec2 describe-instances --profile learner-ec2
```

---

# Final Summary

```text
Different IAM users can be configured in AWS Console and AWS CLI.
For CLI, each user can have a separate named profile.
Use --profile to run commands as a specific IAM user.
This helps test IAM permissions and least privilege safely.
```

Alhamdulillah, this helped me understand how to configure and test different AWS users.
