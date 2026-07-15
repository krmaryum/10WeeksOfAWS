# AWS Organizations, SCPs & IAM Identity Center MCQ Quiz

## Overview

This MCQ quiz is based on **Week 2 – Day 4** of the AWS learning journey.

Topic:

```text
AWS Organizations, SCPs, IAM Identity Center, Permission Sets, STS Sessions, and Consolidated Billing
```

The quiz is designed to help learners review the Day 4 practical lab and understand how AWS manages multi-account environments with security guardrails.

---

## Quiz File

```text
aws-organizations-scp-iam-identity-center-mcq-quiz.html
```

---

## What This Quiz Covers

- AWS Organizations
- Management account
- Member account
- Organizational Units
- Service Control Policies
- IAM Identity Center
- Permission Sets
- STS assumed-role sessions
- Before-SCP and after-SCP behavior
- Explicit deny behavior
- Consolidated billing
- Screenshot masking and security safety rules

---

## Key Learning Point

```text
IAM or Permission Set can allow an action,
but an applicable SCP explicit deny can still block it.
```

Example:

```text
Permission Set allows s3:CreateBucket
+
SCP denies s3:CreateBucket
=
AccessDenied
```

---

## Quiz Features

```text
25 questions
Answer checking
Score calculation
15-minute timer
Live progress tracking
Short explanations
Reattempt option
Questions shuffled
Answer choices shuffled on every attempt
Responsive design
```

---

## Recommended Use

Use this quiz after completing the Day 4 lab:

```text
AWS Organizations
IAM Identity Center
SCP Deny S3 Bucket Creation
Before and After OU Move Test
```

This helps confirm that the learner understands the difference between:

```text
Permission Set = grants workforce access
SCP = sets maximum permission guardrail
```

---

## Author

```text
Muhammad Khalid Khan
Linux System Administrator | DevOps Engineer
Website: khalidkhan.me
GitHub: github.com/krmaryum
Email: kkhalid7631@gmail.com
```
