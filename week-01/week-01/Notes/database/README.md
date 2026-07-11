# AWS Databases & Database Engines — Study Pack

This repository contains a complete study pack for learning **AWS databases and database engines** from beginner to practical level.

The material covers:

- Database fundamentals
- Database engines
- Amazon RDS
- Amazon Aurora
- Amazon DynamoDB
- Other AWS purpose-built database services
- RDS vs DynamoDB
- CRUD operations in RDS and DynamoDB
- Interactive MCQ practice
- Visual poster revision

---

# Included Resources

## 1. Complete Study Notes

**File:**

```text
AWS-Databases-and-Database-Engines-Complete-Study-Notes.md
```

These notes explain databases from scratch and cover:

- What a database is
- Why applications need databases
- Tables, rows, columns, and primary keys
- What a database engine is
- Database service vs engine vs database
- Relational databases
- NoSQL databases
- Amazon RDS
- Amazon Aurora
- Amazon DynamoDB
- Amazon ElastiCache
- Amazon DocumentDB
- Amazon Redshift
- Amazon Neptune
- Amazon Timestream
- Amazon Keyspaces
- Amazon MemoryDB
- AWS database selection guide
- Interview questions
- Memory tricks

This is the main theory document for the topic.

---

## 2. Visual Study Poster

**File:**

```text
AWS-Databases-and-Database-Engines-Poster.png
```

The poster provides a quick visual summary of:

- Database basics
- Database engine meaning
- Relational vs NoSQL
- RDS vs DynamoDB
- AWS database family
- Quick decision guide
- Memory tricks

The poster is useful for:

- Fast revision
- Classroom display
- Interview preparation
- GitHub portfolio projects
- Visual learning

---

## 3. Interactive MCQ Quiz

**File:**

```text
AWS-Databases-and-Database-Engines-MCQ-Quiz.html
```

The quiz contains:

- 25 questions
- 15-minute timer
- Live progress tracking
- Answer checking
- Score and percentage
- Correct and incorrect answer highlighting
- Short explanations
- Unanswered-question tracking
- Automatic submission when time expires
- Reattempt option
- Shuffled questions
- Shuffled answer choices
- Responsive design

### How to Use

1. Download the HTML file.
2. Open it in a browser.
3. Answer all questions.
4. Submit the quiz.
5. Review the explanations.
6. Use **Reattempt & Shuffle** for another attempt.

No installation is required.

---

## 4. RDS and DynamoDB CRUD Study Notes

**File:**

```text
RDS-and-DynamoDB-Add-Update-Delete-Study-Notes.md
```

These practical notes explain how to create, read, update, and delete data.

Topics include:

- CRUD meaning
- Connecting to RDS MySQL
- Creating SQL tables
- `INSERT`
- `SELECT`
- `UPDATE`
- `DELETE`
- `TRUNCATE`
- `DROP TABLE`
- DynamoDB `PutItem`
- DynamoDB `GetItem`
- DynamoDB `Query`
- DynamoDB `Scan`
- DynamoDB `UpdateItem`
- DynamoDB `DeleteItem`
- Partition keys
- Sort keys
- Condition expressions
- Safe deletion practices
- Common mistakes
- Hands-on labs
- Interview questions

---

# Main Concepts

## Database

A database is an organized collection of data that applications can store, search, update, and manage.

```text
Database
└── Tables
    └── Rows
        └── Columns
```

---

## Database Engine

A database engine is the software that performs the actual database work.

It:

- Stores data
- Reads data
- Updates records
- Deletes records
- Processes queries
- Manages transactions
- Protects data consistency

Example:

```text
Amazon RDS = Managed service
MySQL      = Database engine
school_db  = Database
students   = Table
Ali        = Row
```

---

# RDS vs DynamoDB

| Feature | Amazon RDS | Amazon DynamoDB |
|---|---|---|
| Type | Relational | NoSQL |
| Query method | SQL | API, CLI, SDK, PartiQL |
| Data structure | Tables, rows, columns | Tables, items, attributes |
| Joins | Supported | No traditional joins |
| Schema | Structured | Flexible |
| Scaling | Instance-based managed service | Serverless scalable |
| Best for | Relationships and transactions | Fast key-based access |

---

# CRUD Comparison

| Operation | Amazon RDS | Amazon DynamoDB |
|---|---|---|
| Create | `INSERT` | `PutItem` |
| Read | `SELECT` | `GetItem`, `Query`, `Scan` |
| Update | `UPDATE` | `UpdateItem` |
| Delete | `DELETE` | `DeleteItem` |

---

# Quick AWS Database Guide

| Requirement | AWS Service |
|---|---|
| Relational database | Amazon RDS |
| Cloud-native MySQL/PostgreSQL | Amazon Aurora |
| Serverless NoSQL | Amazon DynamoDB |
| JSON-like documents | Amazon DocumentDB |
| Caching | Amazon ElastiCache |
| Durable in-memory database | Amazon MemoryDB |
| Analytics and reporting | Amazon Redshift |
| Graph data | Amazon Neptune |
| Time-series data | Amazon Timestream |
| Cassandra-compatible workloads | Amazon Keyspaces |

---

# Suggested Learning Order

```text
1. Read the complete study notes
2. Review the visual poster
3. Practice the interactive MCQ quiz
4. Complete the RDS and DynamoDB CRUD notes
5. Repeat the quiz
```

---

# Recommended Folder Structure

```text
AWS-Databases-and-Database-Engines/
├── README.md
├── AWS-Databases-and-Database-Engines-Complete-Study-Notes.md
├── AWS-Databases-and-Database-Engines-Poster.png
├── AWS-Databases-and-Database-Engines-MCQ-Quiz.html
└── RDS-and-DynamoDB-Add-Update-Delete-Study-Notes.md
```

---

# Learning Outcomes

After completing this study pack, you should be able to:

- Explain what a database is
- Explain what a database engine is
- Differentiate between a service, engine, database, table, row, and item
- Compare relational and NoSQL databases
- Explain Amazon RDS
- Explain Amazon Aurora
- Explain Amazon DynamoDB
- Select an appropriate AWS database service
- Perform CRUD operations in RDS
- Perform CRUD operations in DynamoDB
- Explain partition keys and sort keys
- Avoid common delete and update mistakes
- Answer basic AWS database interview questions

---

# Safety Notes

## RDS

Always use a `WHERE` condition when updating or deleting selected rows.

Dangerous:

```sql
DELETE FROM students;
```

Safer:

```sql
DELETE FROM students
WHERE student_id = 101;
```

## DynamoDB

`PutItem` can replace an existing item when the same primary key is used.

Safer:

```bash
--condition-expression "attribute_not_exists(studentId)"
```

---

# Final Memory Trick

```text
RDS         = Managed relational database service
MySQL       = Database engine
Aurora      = AWS cloud-native relational engine
DynamoDB    = Serverless NoSQL database
ElastiCache = In-memory cache
Redshift    = Analytics
Neptune     = Graph database
Timestream  = Time-series database
```

```text
RDS works with rows.
DynamoDB works with items.
```

---

# Author

**Muhammad Khalid Khan**

- GitHub: `@krmaryum`
- Email: `krmaryum@yahoo.com`

---

# Purpose

This repository is created for:

- AWS learning
- DevOps practice
- Interview preparation
- Classroom revision
- Visual study
- Hands-on database practice
