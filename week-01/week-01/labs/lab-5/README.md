# README – Lab 5: Custom S3 Read-Only JSON Policy

## Overview

This lab focuses on creating a **customer managed IAM JSON policy** for Amazon S3.

Instead of using the AWS managed policy `AmazonS3ReadOnlyAccess`, this lab creates a custom policy that allows read-only access to **one specific S3 bucket**.

---

## Lab Goal

```text
Read and create a basic JSON policy.
```

---

## What You Will Learn

In this lab, you will learn:

- What a customer managed policy is
- Basic IAM JSON policy structure
- How `Effect`, `Action`, and `Resource` work
- Difference between bucket-level and object-level permissions
- How to allow read-only access to one S3 bucket
- How to test allowed and denied actions
- How least privilege works in S3

---

## Policy Name

```text
CustomS3ReadOnlyTrainingPolicy
```

---

## Recommended File Name

Save the policy in your repo as:

```text
custom-s3-read-only-training-policy.json
```

---

## Suggested Folder Structure

```text
lab-5-custom-s3-read-only-json-policy/
├── README.md
├── lab-5-custom-s3-read-only-json-policy-study-notes.md
├── custom-s3-read-only-training-policy.json
└── images/
    ├── custom-policy-created.png
    ├── allowed-s3-action.png
    └── denied-s3-action.png
```

---

## Policy Summary

This policy allows:

```text
List all S3 buckets
Get bucket location
List objects inside one selected bucket
Read/download objects from one selected bucket
```

This policy does **not** allow:

```text
Create bucket
Upload object
Delete object
Delete bucket
Modify bucket policy
Modify bucket permissions
```

---

## Important ARN Difference

For the bucket itself:

```text
arn:aws:s3:::YOUR-BUCKET-NAME
```

For objects inside the bucket:

```text
arn:aws:s3:::YOUR-BUCKET-NAME/*
```

---

## Sample Policy

Replace `YOUR-BUCKET-NAME` with your real bucket name.

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListAllMyBuckets",
        "s3:GetBucketLocation"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket"
      ],
      "Resource": "arn:aws:s3:::YOUR-BUCKET-NAME"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject"
      ],
      "Resource": "arn:aws:s3:::YOUR-BUCKET-NAME/*"
    }
  ]
}
```

---

## Deliverables

| Deliverable | Description |
|---|---|
| Policy JSON in repo | Add the custom JSON policy file |
| Screenshot of custom policy created | Show `CustomS3ReadOnlyTrainingPolicy` |
| Screenshot of allowed action | Show list/read access to selected bucket |
| Screenshot or note for denied action | Show upload/delete/create action denied |

---

## Test Commands

Allowed test:

```bash
aws s3 ls --profile learner-s3
```

List selected bucket:

```bash
aws s3 ls s3://YOUR-BUCKET-NAME --profile learner-s3
```

Denied upload test:

```bash
echo "test" > test.txt
aws s3 cp test.txt s3://YOUR-BUCKET-NAME/ --profile learner-s3
```

Expected result:

```text
AccessDenied
```

---

## Short Lab Summary

```text
In this lab, I created a customer managed IAM policy named CustomS3ReadOnlyTrainingPolicy. This policy allows read-only access to one selected S3 bucket. The user can list buckets, view the selected bucket, and read objects inside that bucket, but cannot upload, delete, create buckets, or modify S3 resources.
```

---

## Screenshot Security Note

Do not share:

```text
AWS account ID
Root email
IAM sign-in URL if sensitive
Access keys
Secret access keys
MFA QR code
Payment details
Private bucket data if sensitive
```

---

## Common Mistakes

| Mistake | Fix |
|---|---|
| Forgetting to replace `YOUR-BUCKET-NAME` | Use your real bucket name |
| Using bucket ARN for `GetObject` | Use `arn:aws:s3:::bucket-name/*` |
| Using object ARN for `ListBucket` | Use `arn:aws:s3:::bucket-name` |
| Expecting upload to work | Upload should be denied |
| Giving `s3:*` on all buckets | Use least privilege |

---

## Final One-Line Summary

```text
This lab teaches how to create a custom S3 read-only JSON policy with least privilege for one specific bucket.
```

Alhamdulillah, Lab 5 is completed.
