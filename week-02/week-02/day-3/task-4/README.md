# README – Week 2 Day 3 Task 4 + Project + MCQ Quiz

## Title

```text
Week 2 – Day 3: Instance Profiles, EC2 Roles, and EC2 Access to S3 Using IAM Role
```

## Main Topic

```text
IAM Roles
Instance Profiles
EC2 Role Credentials
STS Temporary Credentials
S3 Read / Upload / Download Access
Least Privilege Security
```

---

## Overview

This folder covers **Task 4** and the hands-on project for **EC2 accessing an S3 bucket using an IAM Role**.

The main idea is:

```text
Do not store permanent AWS access keys on EC2.
Attach an IAM role to EC2 through an instance profile.
Let AWS CLI and SDKs automatically use temporary credentials.
```

---

## Learning Goals

By completing this task and project, you will understand:

```text
What an IAM role is
What an instance profile is
How EC2 receives IAM role credentials
How STS temporary credentials work with EC2
How AWS CLI and SDKs use the credential provider chain
How EC2 can list, upload, and download S3 objects
Why permanent access keys should not be stored on servers
How least privilege works in a real S3 access project
```

---

## Files Included

| File | Description |
|---|---|
| `week-2-day-3-task-4-instance-profiles-and-ec2-roles-study-notes.md` | Study notes for Task 4: Instance Profiles and EC2 Roles |
| `week-2-day-3-project-ec2-access-s3-using-iam-role.md` | Step-by-step project notes for EC2 accessing S3 |
| `week-2-day-3-project-ec2-access-s3-iam-role-25-mcqs.html` | Interactive 25-question MCQ quiz |
| `ec2_access_to_s3_using_iam.png` | Poster / visual summary for the project |
| `README.md` | This overview file |

---

## Task 4 Summary

Task 4 explains the difference between an **IAM Role** and an **Instance Profile**.

### IAM Role

An IAM role contains:

```text
Trust relationship
Permissions
```

The role answers:

```text
Who can assume this role?
What can this role do after it is assumed?
```

For EC2, the trust policy usually trusts:

```text
ec2.amazonaws.com
```

---

### Instance Profile

An instance profile is the container that makes an IAM role available to an EC2 instance.

Simple formula:

```text
IAM Role = Trust relationship and permissions

Instance Profile = Container that attaches the role to EC2

EC2 Instance = Uses temporary credentials from the role
```

---

## How EC2 Uses IAM Role Credentials Automatically

When an IAM role is attached to EC2:

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

The AWS CLI and SDKs use the **AWS credential provider chain**.

That means they automatically look for credentials in supported places, including the EC2 instance role credentials.

For this lab:

```text
Do not run aws configure on EC2.
Do not paste access keys into EC2.
Do not store permanent credentials.
```

Verify the role:

```bash
aws sts get-caller-identity
```

Expected ARN pattern:

```text
arn:aws:sts::123456789012:assumed-role/EC2-S3-Read-Upload-Download-Role/i-xxxxxxxx
```

If you see:

```text
assumed-role
```

then EC2 is using the IAM role correctly.

---

## Project Summary

The project shows how an EC2 instance can securely access S3 to:

```text
List files
Upload files
Download files
```

without using permanent access keys.

---

## Project Architecture

```text
EC2 Instance
   ↓
Instance Profile
   ↓
IAM Role
   ↓
STS Temporary Credentials
   ↓
S3 Bucket
   ↓
Read / Upload / Download
```

---

## Project Steps

```text
1. Create an S3 bucket
2. Create an IAM policy for S3 read/upload/download access
3. Create an IAM role for EC2
4. Check the role trust policy
5. Launch an EC2 instance
6. Attach the IAM role through the instance profile
7. SSH into EC2
8. Verify AWS CLI
9. Verify role credentials
10. List the S3 bucket
11. Upload a file from EC2 to S3
12. Download the file from S3 to EC2
13. Test delete denial
14. Confirm no permanent access keys are stored
15. Clean up resources
```

---

## IAM Policy Used in the Project

This policy allows EC2 to list, upload, and download objects from one S3 bucket.

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "ListBucketAccess",
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket"
      ],
      "Resource": "arn:aws:s3:::khalid-week2-day3-ec2-s3-lab"
    },
    {
      "Sid": "ObjectReadUploadDownloadAccess",
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Resource": "arn:aws:s3:::khalid-week2-day3-ec2-s3-lab/*"
    }
  ]
}
```

---

## Permission Explanation

| Permission | Purpose |
|---|---|
| `s3:ListBucket` | Allows EC2 to list objects in the bucket |
| `s3:GetObject` | Allows EC2 to read/download objects |
| `s3:PutObject` | Allows EC2 to upload objects |
| No `s3:DeleteObject` | Delete is denied to prove least privilege |

---

## Important Commands

### Verify Role

```bash
aws sts get-caller-identity
```

### List S3 Bucket

```bash
aws s3 ls s3://khalid-week2-day3-ec2-s3-lab
```

### Create Test File

```bash
echo "Alhamdulillah EC2 uploaded this file to S3 using IAM Role" > test-from-ec2.txt
```

### Upload File to S3

```bash
aws s3 cp test-from-ec2.txt s3://khalid-week2-day3-ec2-s3-lab/
```

### Download File from S3

```bash
aws s3 cp s3://khalid-week2-day3-ec2-s3-lab/test-from-ec2.txt .
```

### Read Downloaded File

```bash
cat test-from-ec2.txt
```

### Test Delete Denial

```bash
aws s3 rm s3://khalid-week2-day3-ec2-s3-lab/test-from-ec2.txt
```

Expected result:

```text
AccessDenied
```

---

## Security Warnings

Never place permanent AWS access keys in:

```text
User data
Environment files
Application source code
AMIs
Shell history
```

These locations can expose secrets through logs, backups, GitHub commits, shared images, or command history.

---

## Least Privilege Lesson

This project intentionally does not include:

```text
s3:DeleteObject
```

So this command should fail:

```bash
aws s3 rm s3://khalid-week2-day3-ec2-s3-lab/test-from-ec2.txt
```

This proves the role only has the permissions required for the project.

```text
Allowed: List, Upload, Download
Denied: Delete
```

---

## MCQ Quiz Features

The HTML quiz includes:

```text
25 questions
15-minute timer
Live progress tracking
Score calculation
Answer checking
Correct/wrong answer highlighting
Short explanations
Clear answers option
Reattempt option
Questions shuffled on reattempt
Answer choices shuffled on reattempt
Responsive design
```

---

## How to Use the MCQ Quiz

Open this file in a browser:

```text
week-2-day-3-project-ec2-access-s3-iam-role-25-mcqs.html
```

Then:

```text
1. Read each question carefully.
2. Select your answer.
3. Complete all 25 questions.
4. Click Submit Quiz.
5. Review your score and explanations.
6. Click Reattempt & Shuffle to practice again.
```

---

## Recommended Study Flow

```text
Step 1: Read Task 4 study notes
Step 2: Review the poster
Step 3: Complete the EC2 to S3 project
Step 4: Verify the role using aws sts get-caller-identity
Step 5: Test S3 list, upload, and download commands
Step 6: Confirm delete is denied
Step 7: Attempt the MCQ quiz
Step 8: Reattempt until you can score 90%+
```

---

## Troubleshooting Quick Guide

| Problem | Possible Cause | Fix |
|---|---|---|
| `AccessDenied` on list | Wrong bucket ARN or missing `s3:ListBucket` | Check bucket ARN and policy |
| Upload fails | Missing `s3:PutObject` or wrong object ARN | Use bucket ARN with `/*` |
| Download fails | Missing `s3:GetObject` or wrong file name | Check object name and policy |
| `aws sts get-caller-identity` does not show role | Role not attached to EC2 | Attach IAM role through instance profile |
| `aws s3 ls` fails without bucket path | No `s3:ListAllMyBuckets` permission | Use exact bucket path |
| AWS CLI uses old keys | Local credentials configured | Check `aws configure list` and remove old keys |

---

## Cleanup Reminder

To avoid charges, clean up after practice:

```text
Delete test S3 objects
Terminate EC2 instance
Delete S3 bucket
Delete custom IAM role
Delete custom IAM policy
```

If delete is denied from EC2, remove test objects from the AWS Console or use an admin user for cleanup.

---

## Key Takeaway

```text
EC2 can securely access S3 using an IAM role, instance profile, and STS temporary credentials without storing permanent AWS access keys.
```

---

## Final Summary

```text
IAM Role = Trust relationship and permissions

Instance Profile = Makes the IAM role available to EC2

STS = Provides temporary credentials

AWS CLI / SDK = Automatically obtains and refreshes credentials

S3 Policy = Allows list, upload, and download

Least Privilege = Delete is denied

Security Best Practice = No permanent access keys on EC2
```

---

## Author

```text
Muhammad Khalid Khan
Linux System Administrator | DevOps Engineer
Website: khalidkhan.me
GitHub: github.com/krmaryum
Email: kkhalid7631@gmail.com
Location: Illinois, USA
```

---

## Learning Reminder

```text
Keep Learning, Keep Building, Keep Automating.
```
