# Week 2 – Day 3  
# Check Your Understanding – IAM Roles, Trust Policy, Permission Policy, STS, and EC2 Instance Roles

## Main Topic

```text
IAM Roles, STS, Temporary Credentials, Instance Profiles, and Cross-Service Role Assumption
```

## Goal

Review important understanding-check questions about how AWS services assume IAM roles and use temporary credentials securely.

---

# Question 1  
## Does an EC2 trust policy grant permission to read an S3 object?

## Answer

```text
No.
```

An **EC2 trust policy does not grant S3 access**.

A trust policy only answers:

```text
WHO can assume the role?
```

For example, this trust policy allows EC2 to assume a role:

```json
{
  "Effect": "Allow",
  "Principal": {
    "Service": "ec2.amazonaws.com"
  },
  "Action": "sts:AssumeRole"
}
```

This means:

```text
EC2 is allowed to assume this role.
```

But this does **not** mean EC2 can read from S3.

---

## What Grants S3 Read Permission?

To read an S3 object, the IAM role needs a **permission policy** with:

```text
s3:GetObject
```

Example permission policy:

```json
{
  "Effect": "Allow",
  "Action": [
    "s3:GetObject"
  ],
  "Resource": "arn:aws:s3:::example-bucket/*"
}
```

This means:

```text
After the role is assumed, it can read objects from the S3 bucket.
```

---

## Key Point

```text
Trust Policy = WHO can assume the role

Permission Policy = WHAT the role can do
```

---

# Question 2  
## What must change if Lambda, rather than EC2, needs to assume the role?

## Answer

The **trust policy service principal** must change.

For EC2, the trust policy uses:

```text
ec2.amazonaws.com
```

For Lambda, the trust policy should use:

```text
lambda.amazonaws.com
```

---

## EC2 Trust Policy Example

```json
{
  "Effect": "Allow",
  "Principal": {
    "Service": "ec2.amazonaws.com"
  },
  "Action": "sts:AssumeRole"
}
```

Meaning:

```text
EC2 can assume this role.
```

---

## Lambda Trust Policy Example

```json
{
  "Effect": "Allow",
  "Principal": {
    "Service": "lambda.amazonaws.com"
  },
  "Action": "sts:AssumeRole"
}
```

Meaning:

```text
Lambda can assume this role.
```

---

## Important Note

Only changing the trust policy tells AWS **who can assume the role**.

The **permission policy** should still grant only the actions that Lambda needs.

Example:

If Lambda needs to write logs to CloudWatch Logs, the permission policy may include:

```text
logs:CreateLogGroup
logs:CreateLogStream
logs:PutLogEvents
```

If Lambda needs to read from S3, the permission policy may include:

```text
s3:GetObject
```

---

# Question 3  
## Why is an instance role safer than storing an IAM user's keys on EC2?

## Answer

An instance role is safer because EC2 uses **temporary credentials** instead of permanent IAM user access keys.

Temporary credentials are created by AWS STS and are automatically refreshed by AWS CLI and SDKs.

---

## Temporary Credentials Are Safer Because They

```text
Expire automatically
Are refreshed automatically
Reduce damage if leaked
Do not need to be stored in files
Do not need to be hardcoded
Do not need manual rotation on the server
```

---

## Permanent IAM User Keys Are Risky

Permanent IAM user access keys are dangerous if stored on EC2 because they can be leaked from many places.

Do not store permanent access keys in:

```text
User data
Environment files
Application source code
AMIs
Shell history
```

---

## Bad Practice Example

```bash
export AWS_ACCESS_KEY_ID=AKIA...
export AWS_SECRET_ACCESS_KEY=...
```

This is risky because these commands may remain in shell history.

---

## Better Practice

Attach an IAM role to EC2 through an instance profile.

```text
EC2 Instance
   ↓
Instance Profile
   ↓
IAM Role
   ↓
STS Temporary Credentials
   ↓
AWS CLI / SDK uses credentials automatically
```

---

# Question 4  
## What should happen when temporary credentials expire?

## Answer

Temporary credentials should be **refreshed automatically**.

For EC2, the AWS CLI and SDKs use the credential provider chain and the EC2 instance metadata service to get fresh temporary credentials.

---

## Normal Flow

```text
Old temporary credentials expire
        ↓
AWS CLI / SDK requests fresh credentials
        ↓
New temporary credentials are provided
        ↓
Application continues working
```

---

## Important Point

You should not manually store, rotate, or hardcode credentials on the EC2 instance.

AWS handles the refresh process automatically when the role is attached correctly.

---

# How EC2 Gets Credentials Automatically

When an IAM role is attached to EC2:

```text
IAM Role
   ↓
Instance Profile
   ↓
Attached to EC2
   ↓
EC2 Metadata Service provides temporary credentials
   ↓
AWS CLI / SDK automatically reads those credentials
   ↓
Credentials are refreshed automatically
```

---

# Check Role from EC2

Run this command on EC2:

```bash
aws sts get-caller-identity
```

Expected ARN pattern:

```text
arn:aws:sts::123456789012:assumed-role/ROLE-NAME/i-xxxxxxxx
```

If you see:

```text
assumed-role
```

then EC2 is using IAM role credentials correctly.

---

# Quick Revision Table

| Question | Short Answer |
|---|---|
| Does EC2 trust policy grant S3 read access? | No |
| What does trust policy answer? | WHO can assume the role |
| What grants S3 read access? | Permission policy with `s3:GetObject` |
| What changes for Lambda instead of EC2? | Service principal changes to `lambda.amazonaws.com` |
| Why is instance role safer? | It uses temporary credentials instead of permanent keys |
| Where should access keys not be stored? | User data, env files, source code, AMIs, shell history |
| What happens when temporary credentials expire? | They refresh automatically |
| What delivers a role to EC2? | Instance profile |
| What supplies temporary credentials? | STS |
| What confirms EC2 is using the role? | `aws sts get-caller-identity` shows `assumed-role` |

---

# Common Mistakes

## Mistake 1

```text
Thinking trust policy gives S3 access.
```

### Correction

```text
Trust policy only controls who can assume the role.
Permission policy controls what the role can do.
```

---

## Mistake 2

```text
Using EC2 service principal for Lambda.
```

### Correction

```text
Use lambda.amazonaws.com when Lambda needs to assume the role.
```

---

## Mistake 3

```text
Storing IAM user access keys on EC2.
```

### Correction

```text
Attach an IAM role to EC2 and use temporary credentials.
```

---

## Mistake 4

```text
Thinking expired temporary credentials must be manually replaced.
```

### Correction

```text
AWS CLI and SDKs refresh temporary credentials automatically.
```

---

# Best Practices

```text
Use IAM roles instead of permanent access keys.
Use correct service principal in the trust policy.
Use least privilege in the permission policy.
Grant only required actions.
Avoid wildcard permissions when possible.
Do not store credentials in user data.
Do not store credentials in source code.
Do not bake credentials into AMIs.
Do not type credentials into shell history.
Verify role usage with aws sts get-caller-identity.
```

---

# Final Memory Line

```text
Trust Policy = WHO

Permission Policy = WHAT

STS = Temporary credentials

Instance Profile = Delivers role to EC2

Temporary Credentials = Expire and refresh automatically
```

---

# One-Line Summary

```text
An EC2 trust policy only allows EC2 to assume a role; S3 access comes from the permission policy, and temporary credentials from STS are automatically refreshed instead of storing permanent keys.
```
