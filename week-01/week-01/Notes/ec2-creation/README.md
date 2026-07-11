# EC2 Launch Template Versions Lab

## Overview

This repo/study note explains how to create an AWS EC2 instance, create a launch template from that instance, launch new EC2 instances from the template, and manage launch template versions.

It also includes the real troubleshooting issues faced during practice, especially the **EBS card index error** and the **EC2 metadata public IP blank issue**.

---

## What You Will Learn

By completing this lab, you will understand:

- How to create an EC2 instance manually
- How to connect to EC2 using SSH
- How to create a launch template from an existing EC2 instance
- How to launch EC2 from a launch template
- How to create and use launch template versions
- How to add Nginx using user data
- How to test Nginx from EC2 and browser
- How to troubleshoot common EC2 launch template errors

---

## Lab Flow

```text
1. Create EC2 manually
2. Connect using SSH
3. Create launch template from EC2
4. Launch EC2 from template
5. Fix template errors using new versions
6. Create v3 with Nginx user data
7. Test Nginx with curl and browser
8. Document errors and solutions
```

---

## Template Version Summary

| Version | Purpose | Result |
|---|---|---|
| v1 | Initial launch template from EC2 | Had storage/EBS card index issue |
| v2 | Fixed EBS card index issue | EC2 launched successfully |
| v3 | Added Nginx user data | Website worked in browser |

---

## Important User Data Script

```bash
#!/bin/bash
apt-get update -y
apt-get install nginx -y
echo "Assalam o alaikum, This server IP is $(hostname -i)" > /var/www/html/index.html
systemctl enable nginx
systemctl restart nginx
```

---

## Common Error Covered

### EBS Card Index Error

Error:

```text
EBS card index is not supported for this instance type.
```

Fix:

```text
Storage → Volume 1 → EBS card index → Don't include in launch template
```

Then:

```text
Create new template version → Set default version → Launch instance again
```

---

## Testing Commands

Check Nginx:

```bash
systemctl status nginx
```

Test locally:

```bash
curl localhost
```

Test private IP:

```bash
curl PRIVATE-IP
```

Open in browser:

```text
http://PUBLIC-IP
```

---

## Files

| File | Description |
|---|---|
| `ec2-launch-template-versions-study-notes.md` | Complete study notes for EC2 launch template and versions |
| `README.md` | Short project/lab overview |

---

## Key Lesson

Do not only fix the launch screen.

Fix the launch template by creating a **new version**, then set the correct version as **default**.

```text
Modify template → Create new version → Set default version → Launch EC2
```

---

## Status

Lab completed successfully.

Nginx was installed through user data and the web page was accessible from the browser.
