# Add, Update, and Delete Data in Amazon RDS and DynamoDB

## Table of Contents

1. Overview
2. RDS vs DynamoDB CRUD
3. Amazon RDS CRUD
4. Connect to RDS MySQL
5. Create a Table
6. Insert Data
7. Read Data
8. Update Data
9. Delete Data
10. DELETE vs TRUNCATE vs DROP
11. Amazon DynamoDB CRUD
12. DynamoDB Data Types
13. PutItem
14. GetItem, Query, and Scan
15. UpdateItem
16. DeleteItem
17. Partition Key and Sort Key
18. RDS vs DynamoDB Comparison
19. Common Mistakes
20. Hands-On Practice
21. Interview Questions
22. Memory Tricks

---

# 1. Overview

Adding, reading, updating, and deleting data are called **CRUD operations**.

| Letter | Operation | Meaning |
|---|---|---|
| C | Create | Add new data |
| R | Read | Retrieve data |
| U | Update | Change data |
| D | Delete | Remove data |

The basic difference is:

```text
Amazon RDS      → SQL commands
Amazon DynamoDB → API, AWS CLI, SDK, or Console operations
```

```text
RDS works with rows.
DynamoDB works with items.
```

---

# 2. RDS vs DynamoDB CRUD

| Operation | Amazon RDS | Amazon DynamoDB |
|---|---|---|
| Create | `INSERT` | `PutItem` |
| Read | `SELECT` | `GetItem`, `Query`, `Scan` |
| Update | `UPDATE` | `UpdateItem` |
| Delete | `DELETE` | `DeleteItem` |
| Main unit | Row | Item |
| Identification | SQL `WHERE` | Primary key |
| Access | SQL client/driver | Console, CLI, API, SDK |

---

# 3. Amazon RDS CRUD

Amazon RDS is a managed service for relational database engines such as:

- MySQL
- PostgreSQL
- MariaDB
- Oracle
- Microsoft SQL Server
- Amazon Aurora

Example structure:

```text
Amazon RDS
└── MySQL Engine
    └── school_db
        └── students Table
```

Example table:

| student_id | name | course | score |
|---:|---|---|---:|
| 101 | Ali | AWS | 90 |
| 102 | Sara | Linux | 95 |

---

# 4. Connect to RDS MySQL

You need:

- RDS endpoint
- Port
- Username
- Password
- Security group access
- MySQL client

```bash
mysql \
  -h mydatabase.abc123.us-east-1.rds.amazonaws.com \
  -P 3306 \
  -u admin \
  -p
```

| Option | Meaning |
|---|---|
| `-h` | RDS endpoint |
| `-P` | Port |
| `-u` | Username |
| `-p` | Prompt for password |

Select the database:

```sql
USE school_db;
```

Check the current database:

```sql
SELECT DATABASE();
```

---

# 5. Create a Table

```sql
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    course VARCHAR(100),
    score INT
);
```

Check its structure:

```sql
DESCRIBE students;
```

---

# 6. Insert Data in RDS

## Insert One Row

```sql
INSERT INTO students
(student_id, name, course, score)
VALUES
(101, 'Ali', 'AWS', 90);
```

## Insert Multiple Rows

```sql
INSERT INTO students
(student_id, name, course, score)
VALUES
(102, 'Sara', 'Linux', 95),
(103, 'Bilal', 'Docker', 87),
(104, 'Ahmed', 'Kubernetes', 91);
```

Verify:

```sql
SELECT * FROM students;
```

---

# 7. Read Data in RDS

Read all rows:

```sql
SELECT * FROM students;
```

Read selected columns:

```sql
SELECT name, course
FROM students;
```

Read one student:

```sql
SELECT *
FROM students
WHERE student_id = 101;
```

Filter records:

```sql
SELECT *
FROM students
WHERE score > 90;
```

Sort records:

```sql
SELECT *
FROM students
ORDER BY score DESC;
```

Limit results:

```sql
SELECT *
FROM students
LIMIT 2;
```

---

# 8. Update Data in RDS

Update one row:

```sql
UPDATE students
SET score = 98
WHERE student_id = 102;
```

Update multiple columns:

```sql
UPDATE students
SET course = 'AWS Advanced',
    score = 97
WHERE student_id = 101;
```

Verify:

```sql
SELECT *
FROM students
WHERE student_id = 101;
```

## Dangerous Update

```sql
UPDATE students
SET score = 100;
```

This updates **every row** because there is no `WHERE` clause.

Safe habit:

```sql
SELECT *
FROM students
WHERE student_id = 101;
```

Then:

```sql
UPDATE students
SET score = 100
WHERE student_id = 101;
```

---

# 9. Delete Data in RDS

Delete one row:

```sql
DELETE FROM students
WHERE student_id = 103;
```

Delete multiple selected rows:

```sql
DELETE FROM students
WHERE score < 90;
```

Verify:

```sql
SELECT * FROM students;
```

## Dangerous Delete

```sql
DELETE FROM students;
```

This removes every row but keeps the table.

## Safe Delete Workflow

Preview first:

```sql
SELECT *
FROM students
WHERE score < 90;
```

Then delete:

```sql
DELETE FROM students
WHERE score < 90;
```

---

# 10. DELETE vs TRUNCATE vs DROP

## DELETE

```sql
DELETE FROM students
WHERE student_id = 101;
```

- Deletes selected rows
- Can use `WHERE`
- Keeps the table

Delete all rows:

```sql
DELETE FROM students;
```

## TRUNCATE

```sql
TRUNCATE TABLE students;
```

- Removes all rows
- Keeps the table
- Cannot use `WHERE`
- Usually faster than deleting rows one by one

## DROP TABLE

```sql
DROP TABLE students;
```

- Removes all rows
- Removes the table structure
- Removes indexes belonging to the table

## DROP DATABASE

```sql
DROP DATABASE school_db;
```

- Removes the complete database
- Removes all tables and data

| Command | Deletes Rows | Keeps Table | Supports `WHERE` |
|---|---:|---:|---:|
| `DELETE` | Yes | Yes | Yes |
| `TRUNCATE` | All | Yes | No |
| `DROP TABLE` | All | No | No |
| `DROP DATABASE` | Everything | No | No |

---

# 11. Amazon DynamoDB CRUD

DynamoDB is a fully managed, serverless NoSQL database.

```text
Table
└── Items
    └── Attributes
```

Example:

```text
Table: Students
Partition key: studentId
```

Example item:

```json
{
  "studentId": "101",
  "name": "Ali",
  "course": "AWS",
  "score": 90
}
```

| Term | Meaning |
|---|---|
| Table | Collection of items |
| Item | One record |
| Attribute | One field |
| Partition key | Main identifier |
| Sort key | Optional second identifier |

---

# 12. DynamoDB Data Types

| Type | Meaning | Example |
|---|---|---|
| `S` | String | `"Ali"` |
| `N` | Number | `"90"` |
| `BOOL` | Boolean | `true` |
| `L` | List | A list of values |
| `M` | Map | Nested object |
| `NULL` | Null value | `true` |

CLI JSON example:

```json
{
  "studentId": {"S": "101"},
  "name": {"S": "Ali"},
  "score": {"N": "90"},
  "active": {"BOOL": true}
}
```

In AWS CLI syntax, numbers are written as strings:

```json
"score": {"N": "90"}
```

---

# 13. Add an Item with PutItem

## AWS Console

1. Open DynamoDB.
2. Choose **Tables**.
3. Select the `Students` table.
4. Choose **Explore table items**.
5. Choose **Create item**.
6. Enter the attributes.
7. Choose **Create item**.

## AWS CLI

```bash
aws dynamodb put-item \
  --table-name Students \
  --item '{
    "studentId": {"S": "101"},
    "name": {"S": "Ali"},
    "course": {"S": "AWS"},
    "score": {"N": "90"}
  }'
```

Add another item:

```bash
aws dynamodb put-item \
  --table-name Students \
  --item '{
    "studentId": {"S": "102"},
    "name": {"S": "Sara"},
    "course": {"S": "Linux"},
    "score": {"N": "95"}
  }'
```

## Important PutItem Warning

If the same primary key already exists, `PutItem` can replace the old item.

Prevent replacement:

```bash
aws dynamodb put-item \
  --table-name Students \
  --item '{
    "studentId": {"S": "101"},
    "name": {"S": "Ali"},
    "course": {"S": "AWS"},
    "score": {"N": "90"}
  }' \
  --condition-expression "attribute_not_exists(studentId)"
```

Meaning:

```text
Create the item only if studentId does not already exist.
```

---

# 14. Read Data from DynamoDB

## Get One Item

```bash
aws dynamodb get-item \
  --table-name Students \
  --key '{
    "studentId": {"S": "101"}
  }'
```

## Scan a Table

```bash
aws dynamodb scan \
  --table-name Students
```

A scan reads many or all items and can be expensive on a large table.

## Query a Table

```bash
aws dynamodb query \
  --table-name StudentCourses \
  --key-condition-expression "studentId = :sid" \
  --expression-attribute-values '{
    ":sid": {"S": "101"}
  }'
```

```text
GetItem → One item by exact primary key
Query   → Items matching a key condition
Scan    → Reads many or all items
```

---

# 15. Update an Item with UpdateItem

Update one attribute:

```bash
aws dynamodb update-item \
  --table-name Students \
  --key '{
    "studentId": {"S": "102"}
  }' \
  --update-expression "SET score = :newScore" \
  --expression-attribute-values '{
    ":newScore": {"N": "98"}
  }' \
  --return-values ALL_NEW
```

Update multiple attributes:

```bash
aws dynamodb update-item \
  --table-name Students \
  --key '{
    "studentId": {"S": "101"}
  }' \
  --update-expression "SET course = :course, score = :score" \
  --expression-attribute-values '{
    ":course": {"S": "AWS Advanced"},
    ":score": {"N": "97"}
  }' \
  --return-values ALL_NEW
```

Reserved-word-safe example:

```bash
aws dynamodb update-item \
  --table-name Students \
  --key '{
    "studentId": {"S": "101"}
  }' \
  --update-expression "SET #n = :newName" \
  --expression-attribute-names '{
    "#n": "name"
  }' \
  --expression-attribute-values '{
    ":newName": {"S": "Ali Khan"}
  }' \
  --return-values ALL_NEW
```

## Primary Key Rule

You cannot directly change a DynamoDB primary key with `UpdateItem`.

To change it:

```text
1. Create a new item with the new key.
2. Delete the old item.
```

---

# 16. Delete an Item with DeleteItem

Delete one item:

```bash
aws dynamodb delete-item \
  --table-name Students \
  --key '{
    "studentId": {"S": "101"}
  }'
```

Verify:

```bash
aws dynamodb get-item \
  --table-name Students \
  --key '{
    "studentId": {"S": "101"}
  }'
```

Delete and return the old item:

```bash
aws dynamodb delete-item \
  --table-name Students \
  --key '{
    "studentId": {"S": "102"}
  }' \
  --return-values ALL_OLD
```

Conditional delete:

```bash
aws dynamodb delete-item \
  --table-name Students \
  --key '{
    "studentId": {"S": "102"}
  }' \
  --condition-expression "course = :courseName" \
  --expression-attribute-values '{
    ":courseName": {"S": "Linux"}
  }'
```

The item is deleted only when the condition is true.

---

# 17. Partition Key and Sort Key

Suppose:

```text
Table: StudentCourses
Partition key: studentId
Sort key: courseId
```

| studentId | courseId | courseName |
|---|---|---|
| 101 | C001 | AWS |
| 101 | C002 | Linux |
| 102 | C001 | AWS |

Add an item:

```bash
aws dynamodb put-item \
  --table-name StudentCourses \
  --item '{
    "studentId": {"S": "101"},
    "courseId": {"S": "C001"},
    "courseName": {"S": "AWS"}
  }'
```

Read it:

```bash
aws dynamodb get-item \
  --table-name StudentCourses \
  --key '{
    "studentId": {"S": "101"},
    "courseId": {"S": "C001"}
  }'
```

Delete it:

```bash
aws dynamodb delete-item \
  --table-name StudentCourses \
  --key '{
    "studentId": {"S": "101"},
    "courseId": {"S": "C001"}
  }'
```

When the table has both keys, you must provide:

```text
Partition key + Sort key
```

---

# 18. RDS vs DynamoDB Comparison

| Operation | RDS | DynamoDB |
|---|---|---|
| Add | `INSERT` | `PutItem` |
| Read | `SELECT` | `GetItem`, `Query`, `Scan` |
| Update | `UPDATE` | `UpdateItem` |
| Delete one | `DELETE ... WHERE` | `DeleteItem` |
| Delete all | `DELETE` or `TRUNCATE` | Read keys and batch delete |
| Delete table | `DROP TABLE` | `delete-table` |
| Main unit | Row | Item |
| Identification | `WHERE` | Primary key |
| Query method | SQL | API, CLI, SDK, PartiQL |
| Relationships | Strong support | Usually modeled manually |

---

# 19. Common Mistakes

## RDS: DELETE Without WHERE

Dangerous:

```sql
DELETE FROM students;
```

Safe:

```sql
SELECT *
FROM students
WHERE student_id = 101;
```

Then:

```sql
DELETE FROM students
WHERE student_id = 101;
```

## RDS: UPDATE Without WHERE

Dangerous:

```sql
UPDATE students
SET score = 100;
```

This changes every row.

## RDS: Confusing DELETE and DROP

```text
DELETE → Removes rows
DROP   → Removes the table
```

## DynamoDB: PutItem Replacement

`PutItem` with an existing primary key may replace the item.

Use:

```bash
--condition-expression "attribute_not_exists(studentId)"
```

## DynamoDB: Forgetting the Sort Key

For a composite key, provide both values.

## DynamoDB: Using Scan Too Often

Prefer:

```text
GetItem
Query
```

when possible.

## DynamoDB: Trying to Update a Primary Key

Create a new item and delete the old one.

## General Safety Tips

- Preview data before deletion.
- Use condition expressions.
- Test in a non-production environment.
- Enable backups.
- Apply least-privilege permissions.
- Do not store passwords in scripts.
- Confirm the AWS Region.
- Confirm the table and database names.

---

# 20. Hands-On Practice

## RDS Lab

Create table:

```sql
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    course VARCHAR(100),
    score INT
);
```

Add data:

```sql
INSERT INTO students
(student_id, name, course, score)
VALUES
(101, 'Ali', 'AWS', 90),
(102, 'Sara', 'Linux', 95),
(103, 'Bilal', 'Docker', 87);
```

Read:

```sql
SELECT * FROM students;
```

Update:

```sql
UPDATE students
SET score = 92
WHERE student_id = 101;
```

Delete:

```sql
DELETE FROM students
WHERE student_id = 103;
```

Verify:

```sql
SELECT * FROM students;
```

## DynamoDB Lab

Assume:

```text
Table: Students
Partition key: studentId
```

Add:

```bash
aws dynamodb put-item \
  --table-name Students \
  --item '{
    "studentId": {"S": "101"},
    "name": {"S": "Ali"},
    "course": {"S": "AWS"},
    "score": {"N": "90"}
  }'
```

Read:

```bash
aws dynamodb get-item \
  --table-name Students \
  --key '{
    "studentId": {"S": "101"}
  }'
```

Update:

```bash
aws dynamodb update-item \
  --table-name Students \
  --key '{
    "studentId": {"S": "101"}
  }' \
  --update-expression "SET score = :score" \
  --expression-attribute-values '{
    ":score": {"N": "92"}
  }' \
  --return-values ALL_NEW
```

Delete:

```bash
aws dynamodb delete-item \
  --table-name Students \
  --key '{
    "studentId": {"S": "101"}
  }' \
  --return-values ALL_OLD
```

Verify:

```bash
aws dynamodb get-item \
  --table-name Students \
  --key '{
    "studentId": {"S": "101"}
  }'
```

---

# 21. Interview Questions

## What does CRUD mean?

```text
Create, Read, Update, Delete
```

## How do you add data in RDS?

Use `INSERT`.

```sql
INSERT INTO students
(student_id, name)
VALUES
(101, 'Ali');
```

## How do you delete data in RDS?

Use `DELETE` with `WHERE`.

```sql
DELETE FROM students
WHERE student_id = 101;
```

## What happens if DELETE has no WHERE?

All rows are deleted.

## How do you add data in DynamoDB?

Use `PutItem`.

## How do you delete data in DynamoDB?

Use `DeleteItem` with the complete primary key.

## What can happen when PutItem uses an existing key?

The existing item can be replaced.

## How do you prevent accidental replacement?

Use:

```text
attribute_not_exists(primaryKey)
```

## What is the difference between Query and Scan?

```text
Query → Uses key conditions
Scan  → Reads many or all items
```

## Can you update a DynamoDB primary key?

No. Create a new item and delete the old item.

---

# 22. Memory Tricks

## RDS

```text
INSERT → Add row
SELECT → Read row
UPDATE → Change row
DELETE → Remove row
```

## DynamoDB

```text
PutItem    → Add item
GetItem    → Read item
UpdateItem → Change item
DeleteItem → Remove item
```

Final summary:

```text
RDS uses SQL and works with rows.

DynamoDB uses API operations and works with items.
```
