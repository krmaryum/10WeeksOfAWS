#  Week 2 Day 3  
## IAM Roles, STS, Instance Profiles, and Cross-Service Role Assumption

Alhamdulillah, I completed another important AWS security topic in my learning journey:

```text
Week 2 – Day 3
IAM Roles, STS, Temporary Credentials, Instance Profiles, and Cross-Service Role Assumption
```

This topic is very important because in real AWS environments, applications and services should not use permanent access keys when they need to access AWS resources.

The better and safer approach is:

```text
Use IAM Roles
Use STS temporary credentials
Use least privilege permissions
Avoid hardcoded access keys
```

---

## What I Learned

In this section, I learned how AWS services securely access other AWS services using IAM roles.

Some key concepts I covered:

```text
IAM Role
Trust Policy
Permission Policy
STS AssumeRole
Temporary Credentials
Session Token
Expiration Time
Instance Profile
EC2 Role Credentials
Cross-Service Role Assumption
Least Privilege
```

---

## Main Learning Point

The most important memory line for this topic is:

```text
Trust Policy = WHO can assume the role

Permission Policy = WHAT the role can do

STS = Supplies short-lived temporary credentials

Instance Profile = Delivers the role to EC2
```

This one line makes IAM roles much easier to understand.

---

## Practical Project Completed

I also completed a hands-on project:

```text
EC2 Access S3 Bucket Using IAM Role
```

In this project, an EC2 instance accessed an S3 bucket without storing permanent access keys.

The EC2 instance was able to:

```text
List S3 bucket objects
Upload a file to S3
Download a file from S3
Use temporary credentials automatically
Verify role access using STS
```

Project flow:

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

## Commands Practiced

I verified the EC2 role using:

```bash
aws sts get-caller-identity
```

I tested S3 access using:

```bash
aws s3 ls s3://bucket-name
aws s3 cp test-from-ec2.txt s3://bucket-name/
aws s3 cp s3://bucket-name/test-from-ec2.txt .
```

I also tested least privilege by trying to delete an object without `s3:DeleteObject` permission.

Expected result:

```text
AccessDenied
```

This confirmed that the role had only the required permissions.

---

## Important Security Lesson

Never store permanent AWS access keys in:

```text
User data
Environment files
Application source code
AMIs
Shell history
```

Instead, use:

```text
IAM Role + Instance Profile + STS Temporary Credentials
```

This is more secure because temporary credentials expire and are refreshed automatically.

---

## Cross-Service Role Assumption

I also learned how AWS services can call other AWS services securely.

Examples:

```text
EC2 reads objects from S3
Lambda writes logs to CloudWatch Logs
Step Functions invokes Lambda
ECS tasks read secrets from Secrets Manager
```

Each service needs the correct service principal in the trust policy.

Examples:

```text
EC2 = ec2.amazonaws.com
Lambda = lambda.amazonaws.com
Step Functions = states.amazonaws.com
ECS Tasks = ecs-tasks.amazonaws.com
```

---

## Files Created

For this topic, I created:

```text
Study notes
Posters / infographics
Hands-on project guide
README files
Interactive MCQ quizzes
Check-your-understanding notes
```

The MCQ quizzes include:

```text
Answer checking
Score calculation
Timer
Short explanations
Reattempt option
Shuffled questions and answers
```

---

## Final Takeaway

```text
IAM roles help AWS services access resources securely without storing permanent credentials.

Trust policy decides WHO can assume the role.

Permission policy decides WHAT the role can do.

STS provides temporary credentials.

Instance profile delivers the role to EC2.

Least privilege keeps access controlled and safe.
```

This was a very practical and valuable AWS security topic.

Alhamdulillah — step by step, the concepts are becoming clearer.

---

Let's learn together and grow

#90DaysOfDevOps
#DevOpsKaJosh
#TrainWithShubham
@gangadhar ure 
#10WeeksOfAWS 
#AWS10WeekChallenge 
#CloudAdhar

Happy Learning! TrainWithShubham