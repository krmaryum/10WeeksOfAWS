# Week 2 – Day 3 Study Notes  
# IAM Roles, STS, and Temporary Credentials

## Goal

Understand how an AWS service or workload gets temporary access to another AWS service **without storing permanent credentials**.

---

## Before You Start – Short Answers

### 1. Why should an application avoid storing access keys?

An application should avoid storing access keys because if those keys are exposed, someone can misuse them to access AWS resources.

It is safer to use IAM roles and temporary credentials instead of hardcoding access keys inside an application, server, script, or GitHub repository.

---

### 2. Who is allowed to assume a role?

Only a trusted identity is allowed to assume a role.

This trusted identity can be:

```text
AWS service, such as EC2 or Lambda
IAM user
IAM role
Another AWS account
External identity, such as GitHub OIDC
```

The trusted identity is defined in the **trust policy** of the IAM role.

---

### 3. What is the role allowed to do after it is assumed?

After a role is assumed, it can only perform the actions allowed by the permissions attached to that role.

For example:

```text
If the role has S3 read-only permission:
It can read or list S3 objects.

If the role does not have delete permission:
It cannot delete S3 objects.
```

The role does not automatically get full access. It only gets the permissions defined in its permission policy.

---

### 4. Why do temporary credentials expire?

Temporary credentials expire to reduce security risk.

If temporary credentials are leaked, they only work for a limited time. After expiration, they become useless.

This is safer than permanent access keys, which can remain active until someone manually disables or deletes them.

---

## Simple Summary

```text
Access keys = permanent risk

IAM role = temporary permission identity

STS = service that creates temporary credentials

Temporary credentials = short-life access keys

Expiration = extra security protection
```

---

## Key Concept

An application should not store permanent AWS access keys.

Instead, the application should use an IAM role. AWS STS provides temporary credentials automatically, and those credentials expire after a short time.

---

## Real-Life Example

### Scenario

An EC2 instance needs to read files from an S3 bucket.

### Bad Practice

```text
Store AWS access key and secret key inside the EC2 instance.
```

This is risky because if someone gets access to the EC2 instance or code, they may steal the keys.

### Best Practice

```text
Attach an IAM role to the EC2 instance.
Give that role only the required S3 permissions.
EC2 gets temporary credentials automatically through AWS STS.
```

Now the EC2 instance can access S3 securely without storing permanent credentials.

---

## Trust Policy vs Permission Policy

| Policy Type | Purpose |
|---|---|
| Trust Policy | Defines who can assume the role |
| Permission Policy | Defines what the role can do after it is assumed |

---

## Easy Analogy

Think about a visitor pass in a building.

```text
Permanent access key = master key that stays valid
Temporary credentials = visitor pass that expires
IAM role = job permission badge
STS = security desk that issues the temporary pass
Trust policy = who is allowed to get the pass
Permission policy = which rooms the pass can open
```

---

## Important Reminder

```text
Do not hardcode AWS access keys.
Do not upload access keys to GitHub.
Do not share secret access keys.
Use IAM roles whenever possible.
Use least privilege permissions.
Use temporary credentials for workloads.
```

---

## Quick Revision Table

| Question | Short Answer |
|---|---|
| Why avoid access keys? | They can be stolen and misused |
| Who can assume a role? | Only trusted identities |
| What can the role do? | Only actions allowed by its permissions |
| Why do credentials expire? | To reduce risk if credentials are leaked |
| What service gives temporary credentials? | AWS STS |
| What should workloads use? | IAM roles instead of permanent keys |

---

## One-Line Takeaway

```text
IAM roles and STS allow AWS workloads to access services securely using temporary credentials instead of permanent access keys.
```
