# Week 1 LinkedIn Plan – AWS Learning Posts

## Purpose

This file contains simple 5-day LinkedIn posts for AWS Week 1 learning progress.

The goal is to post daily progress in your own words, keep it simple, and share what you understood from each topic.

---

## Posting Guidelines

```text
Post daily progress in your own words.
Do not copy-paste the same post as everyone else.
Keep it simple.
Write 3–5 lines.
Share what you understood.
Mention one thing you found easy or confusing.
Add one safe screenshot if useful.
Tag @gangadhar ure and @TrainWithShubham.
Add hashtags at the end.
```

---

# Day 1 – Cloud Foundations

## LinkedIn Post

```text
Day 1 – Cloud Foundations

Today I learned about AWS Regions and Availability Zones. A Region is a geographic area, and an Availability Zone is an isolated data center area inside that Region.

One thing I understood clearly is that AWS is responsible for the security of the cloud, such as data centers and physical infrastructure. My responsibility is to secure what I create in the cloud, such as IAM users, MFA, permissions, and data.

This helped me understand that cloud security is shared between AWS and the customer.

@gangadhar ure @TrainWithShubham

#AWS #AWSCloud #CloudComputing #DevOps #7DaysOfAWS #TrainWithShubham #LearningInPublic
```

## Topic Covered

```text
Region
Availability Zone
Shared Responsibility Model
AWS responsibility
Customer responsibility
```

## Screenshot Idea

```text
AWS Region and Availability Zone diagram
or
AWS Shared Responsibility Model screenshot
```

---

# Day 2 – IAM Basics

## LinkedIn Post

```text
Day 2 – IAM Basics

Today I learned that IAM means Identity and Access Management. In simple words, IAM controls who can access AWS and what they are allowed to do.

I understood that an IAM user is a login identity, a group is used to manage multiple users, a role gives temporary access, and a policy defines permissions.

One thing that confused me at first was the difference between role and policy, but now I understand: role is the identity/access method, and policy is the permission document attached to it.

@gangadhar ure @TrainWithShubham

#AWS #IAM #CloudSecurity #DevOps #AWSCloud #7DaysOfAWS #TrainWithShubham #LearningInPublic
```

## Topic Covered

```text
IAM
IAM user
IAM group
IAM role
IAM policy
Permissions
```

## Screenshot Idea

```text
IAM dashboard screenshot
or
IAM users/groups/roles page without sensitive account details
```

---

# Day 3 – Account Security

## LinkedIn Post

```text
Day 3 – Account Security

Today I worked on securing my AWS account by enabling MFA for the root user. This is important because the root user has full access to the AWS account.

I also created a billing alert because it helps monitor AWS cost and avoid unexpected charges during practice labs.

One thing I will avoid sharing publicly is sensitive information such as account ID, root email, access keys, MFA QR code, billing details, and personal payment information.

@gangadhar ure @TrainWithShubham

#AWS #CloudSecurity #IAM #MFA #BillingAlert #DevOps #AWSCloud #7DaysOfAWS #TrainWithShubham #LearningInPublic
```

## Topic Covered

```text
Root user security
MFA
Billing alert
Safe screenshots
Sensitive information protection
```

## Screenshot Idea

```text
MFA enabled confirmation screenshot
or
Budget alert screenshot
```

## Do Not Share Publicly

```text
Root email
AWS account ID
Access key
Secret access key
MFA QR code
Billing details
Payment information
Personal address
Phone number
```

---

# Day 4 – IAM Hands-On

## LinkedIn Post

```text
Day 4 – IAM Hands-On

Today I practiced IAM hands-on by creating IAM users and groups such as learner-s3, learner-ec2, and read-only access groups.

The access that worked was read-only access. For example, the user could view S3 buckets or EC2 resources based on the assigned policy.

The access that was denied was write access, such as creating, deleting, uploading, or modifying resources. This helped me understand least privilege in a practical way.

@gangadhar ure @TrainWithShubham

#AWS #IAM #CloudSecurity #DevOps #AWSCloud #LeastPrivilege #7DaysOfAWS #TrainWithShubham #LearningInPublic
```

## Alternative Specific Version

```text
Day 4 – IAM Hands-On

Today I created an IAM group named S3ReadOnlyGroup and added the user learner-s3 to it.

The user was able to view and list S3 resources, but actions like upload, delete, and create bucket were denied.

This lab helped me understand how IAM groups and policies work together, and why least privilege is important in AWS.

@gangadhar ure @TrainWithShubham

#AWS #IAM #S3 #CloudSecurity #DevOps #LeastPrivilege #7DaysOfAWS #TrainWithShubham #LearningInPublic
```

## Topic Covered

```text
IAM user
IAM group
Read-only access
Allowed action
Denied action
Least privilege
```

## Screenshot Idea

```text
IAM group screenshot
S3 read-only test screenshot
Access denied screenshot
```

---

# Day 5 – Weekly Wrap-Up

## LinkedIn Post

```text
Day 5 – Weekly Wrap-Up

Alhamdulillah, this week I completed AWS Week 1 basics, including cloud foundations, IAM, account security, S3/EC2/Billing read-only access, Switch Role, and GitHub OIDC with AWS.

One concept that finally clicked for me is the difference between IAM user, IAM role, and policy. User is for login, role is for temporary access, and policy defines what is allowed or denied.

Before next week, I want to revise IAM JSON policy structure, ARN formats, STS, and OIDC flow one more time.

@gangadhar ure @TrainWithShubham

#AWS #DevOps #CloudComputing #IAM #STS #OIDC #GitHubActions #CloudSecurity #LeastPrivilege #7DaysOfAWS #TrainWithShubham #LearningInPublic
```

## Topic Covered

```text
Weekly progress
IAM review
S3 and EC2 read-only access
Billing access
Switch Role
GitHub OIDC
STS
ARN
Next week preparation
```

## Screenshot Idea

```text
Week 1 folder screenshot
Study notes screenshot
MCQ quiz screenshot
AWS terminology poster
```

---

# Quick Revision Table

| Day | Topic | Main Learning |
|---|---|---|
| Day 1 | Cloud Foundations | Region, Availability Zone, Shared Responsibility |
| Day 2 | IAM Basics | User, Group, Role, Policy |
| Day 3 | Account Security | Root MFA, Billing Alert, Safe Screenshots |
| Day 4 | IAM Hands-On | Read-only access, Denied write access, Least Privilege |
| Day 5 | Weekly Wrap-Up | IAM, STS, OIDC, ARN, Week 1 review |

---

# Final Reminder

```text
Keep every LinkedIn post simple.
Write in your own words.
Use safe screenshots only.
Do not expose sensitive AWS information.
Focus on what you learned, not just what you clicked.
```
