# AWS Databases and Database Engines — Complete Study Notes

## Table of Contents

1. [What Is a Database?](#1-what-is-a-database)
2. [Why Do Applications Need Databases?](#2-why-do-applications-need-databases)
3. [Basic Database Structure](#3-basic-database-structure)
4. [What Is a Database Engine?](#4-what-is-a-database-engine)
5. [Database Service vs Engine vs Database vs Table](#5-database-service-vs-engine-vs-database-vs-table)
6. [What a Database Engine Actually Does](#6-what-a-database-engine-actually-does)
7. [Common Database Engines](#7-common-database-engines)
8. [Main Types of Databases](#8-main-types-of-databases)
9. [Relational Databases](#9-relational-databases)
10. [NoSQL Databases](#10-nosql-databases)
11. [Amazon RDS](#11-amazon-rds)
12. [Amazon Aurora](#12-amazon-aurora)
13. [Amazon DynamoDB](#13-amazon-dynamodb)
14. [RDS vs DynamoDB](#14-rds-vs-dynamodb)
15. [Real-Life Application Design](#15-real-life-application-design)
16. [Amazon ElastiCache](#16-amazon-elasticache)
17. [Amazon DocumentDB](#17-amazon-documentdb)
18. [Amazon Redshift](#18-amazon-redshift)
19. [Amazon Neptune](#19-amazon-neptune)
20. [Amazon Timestream](#20-amazon-timestream)
21. [Amazon Keyspaces](#21-amazon-keyspaces)
22. [Amazon MemoryDB](#22-amazon-memorydb)
23. [How to Choose the Right AWS Database](#23-how-to-choose-the-right-aws-database)
24. [Simple Decision Flow](#24-simple-decision-flow)
25. [Common Mistakes](#25-common-mistakes)
26. [Interview Questions and Answers](#26-interview-questions-and-answers)
27. [Final Memory Tricks](#27-final-memory-tricks)

---

# 1. What Is a Database?

A **database** is an organized collection of data that can be stored, searched, updated, deleted, and managed by an application.

In simple words:

> A database is a digital place where an application keeps information.

Examples of information stored in databases:

- User names
- Email addresses
- Password hashes
- Product details
- Orders
- Payments
- Student records
- Employee information
- Hospital records
- Bank transactions
- Login sessions
- Application logs
- Notifications
- Inventory levels

Without a database, most applications would not remember anything.

For example, an online shopping website needs to remember:

```text
Customers
Products
Prices
Orders
Payments
Shipping addresses
Order status
Inventory quantity
```

All of this information is normally stored in one or more databases.

---

# 2. Why Do Applications Need Databases?

Applications need databases because users expect information to remain available even after:

- The application restarts
- The server reboots
- The user closes the browser
- Thousands of users connect at the same time
- Data grows from hundreds to millions of records

A database helps an application:

- Store information permanently
- Search records quickly
- Update information safely
- Prevent duplicate records
- Control user access
- Maintain consistency
- Handle multiple users
- Recover from failures
- Create reports
- Connect related information

## Real-Life Analogy

Think of a database like a well-organized office filing system.

| Real-World Item | Database Meaning |
|---|---|
| Filing cabinet | Database |
| Drawer | Table |
| File | Row or record |
| Form heading | Column |
| File number | Primary key |
| Finding a file | Query |
| Office worker | Database engine |
| Office management company | Managed database service |

---

# 3. Basic Database Structure

Suppose we have a database named:

```text
school_db
```

Inside it, we may have tables such as:

```text
students
teachers
courses
fees
results
```

## Example Students Table

| student_id | name | course | score |
|---:|---|---|---:|
| 101 | Ali | Linux | 90 |
| 102 | Sara | AWS | 95 |
| 103 | Bilal | Docker | 85 |

## Important Terms

### Database

A collection of related data.

Example:

```text
school_db
```

### Table

A structured place inside a database that stores one category of information.

Example:

```text
students
```

### Row

One complete record.

Example:

```text
101 | Ali | Linux | 90
```

### Column

One property of a record.

Examples:

```text
student_id
name
course
score
```

### Primary Key

A field that uniquely identifies each row.

Example:

```text
student_id
```

No two students should have the same `student_id`.

### Query

A command used to read or modify data.

Example:

```sql
SELECT name, course, score
FROM students
WHERE score > 90;
```

This query asks:

> Show the students whose score is greater than 90.

Result:

```text
Sara | AWS | 95
```

---

# 4. What Is a Database Engine?

A **database engine** is the software that performs the actual database work.

It is responsible for:

- Storing data
- Reading data
- Updating records
- Deleting records
- Processing queries
- Managing indexes
- Handling transactions
- Controlling users and permissions
- Protecting data consistency
- Managing connections
- Reading from disk or memory
- Returning results to applications

## Simple Definition

> A database engine is the software that understands database commands and performs the work.

## Important Example

```text
Amazon RDS = Managed database service
MySQL      = Database engine
school_db  = Database
students   = Table
Ali        = One row
```

## Structure Example

```text
Amazon RDS
└── MySQL Engine
    └── school_db
        ├── students
        ├── teachers
        └── courses
```

One database engine can manage multiple databases:

```text
MySQL Engine
├── school_db
│   ├── students
│   └── teachers
│
├── shop_db
│   ├── customers
│   ├── products
│   └── orders
│
└── company_db
    ├── employees
    └── payroll
```

---

# 5. Database Service vs Engine vs Database vs Table

These terms are related, but they are not the same.

| Term | Meaning | Example |
|---|---|---|
| Database service | Managed cloud platform | Amazon RDS |
| Database instance | Running compute environment for the database | `db.t3.micro` |
| Database engine | Software that processes data | MySQL |
| Database | Organized collection of data | `company_db` |
| Table | Structured group of records | `employees` |
| Row | One complete record | Employee 101 |
| Column | One property | `email` |
| Query | Command to read or modify data | `SELECT * FROM employees;` |

## Easy Memory Line

```text
RDS is the service.
MySQL is the engine.
school_db is the database.
students is the table.
Ali's information is one row.
```

---

# 6. What a Database Engine Actually Does

Suppose the application runs:

```sql
SELECT * FROM students;
```

The database engine performs several steps.

## Step-by-Step Process

```text
1. The application sends the SQL query.
2. The engine checks the syntax.
3. The engine verifies permissions.
4. The engine finds the students table.
5. The engine decides the fastest way to read the data.
6. The engine reads the records from memory or disk.
7. The engine returns the result.
```

## Update Example

```sql
UPDATE students
SET score = 98
WHERE student_id = 102;
```

The engine:

```text
1. Finds student 102.
2. Checks whether the update is allowed.
3. Changes the score.
4. Records the transaction.
5. Saves the change.
6. Confirms success.
```

## Delete Example

```sql
DELETE FROM students
WHERE student_id = 103;
```

The engine finds the record and removes it safely.

---

# 7. Common Database Engines

## MySQL

MySQL is a popular relational database engine.

Commonly used for:

- Websites
- WordPress
- E-commerce
- Web applications
- Content management systems

## PostgreSQL

PostgreSQL is a powerful relational database engine.

Commonly used for:

- Advanced applications
- Complex queries
- Analytics
- Geospatial data
- Enterprise systems

## MariaDB

MariaDB is a MySQL-compatible relational database engine.

Commonly used when:

- An organization wants an open-source MySQL alternative
- Existing applications already use MySQL-style syntax

## Oracle Database

Oracle is an enterprise relational database engine.

Commonly used in:

- Banking
- Telecom
- Government
- Large enterprise applications

## Microsoft SQL Server

SQL Server is a Microsoft relational database engine.

Commonly used in:

- Microsoft-based environments
- .NET applications
- Business applications
- Enterprise reporting

## Amazon Aurora

Aurora is an AWS-built relational database engine compatible with:

- MySQL
- PostgreSQL

It is designed for cloud workloads.

---

# 8. Main Types of Databases

AWS provides purpose-built database services because different applications have different needs.

The major database categories are:

```text
Relational
Key-Value
Document
In-Memory
Graph
Time-Series
Wide-Column
Data Warehouse
```

The two most important categories for beginners are:

1. Relational databases
2. NoSQL databases

---

# 9. Relational Databases

A relational database stores information in:

- Tables
- Rows
- Columns

Tables can be connected through relationships.

## Example

### Customers Table

| customer_id | name | email |
|---:|---|---|
| 1 | Ali | ali@example.com |
| 2 | Sara | sara@example.com |

### Orders Table

| order_id | customer_id | product | amount |
|---:|---:|---|---:|
| 501 | 1 | Laptop | 900 |
| 502 | 2 | Phone | 700 |

The `customer_id` connects both tables.

```text
Customers
    │
    │ customer_id
    ▼
Orders
```

This relationship allows us to ask:

> Which customer placed which order?

## SQL Join Example

```sql
SELECT customers.name, orders.product, orders.amount
FROM customers
JOIN orders
ON customers.customer_id = orders.customer_id;
```

## Best Use Cases

Relational databases are excellent for:

- Banking
- Payroll
- Student systems
- Hospital systems
- E-commerce orders
- Inventory
- Accounting
- Payments
- Enterprise applications

## Main Strengths

- SQL support
- Joins
- Relationships
- Structured schemas
- Transactions
- Data consistency
- Constraints
- Flexible reporting

---

# 10. NoSQL Databases

NoSQL means:

> Not only SQL

A NoSQL database does not depend only on traditional relational tables.

It may store data as:

- Key-value pairs
- JSON-like documents
- Graph relationships
- Wide-column records
- Time-series measurements

## Why Use NoSQL?

NoSQL is useful when:

- Traffic is very large
- Data structure changes frequently
- Fast key-based access is needed
- Horizontal scaling is important
- The application uses predictable access patterns
- Serverless architecture is preferred

## Example Document

```json
{
  "userId": "USER-101",
  "name": "Ali",
  "city": "Chicago",
  "skills": ["Linux", "AWS", "Docker"]
}
```

Another record in the same collection may contain different fields:

```json
{
  "userId": "USER-102",
  "name": "Sara",
  "subscription": "Premium",
  "lastLogin": "2026-07-10T20:30:00Z"
}
```

This flexible structure is common in NoSQL systems.

---

# 11. Amazon RDS

**RDS** stands for:

> Relational Database Service

Amazon RDS is a managed AWS service for relational databases.

## Important Point

Amazon RDS is not itself the database engine.

Instead, RDS allows you to choose an engine such as:

- MySQL
- PostgreSQL
- MariaDB
- Oracle
- Microsoft SQL Server
- Amazon Aurora

## Example

```text
Amazon RDS
└── MySQL Engine
    └── company_db
        ├── employees
        ├── departments
        └── payroll
```

## RDS Architecture

```text
User
  │
  ▼
Web Application on EC2
  │
  │ SQL Query
  ▼
Amazon RDS Instance
  │
  ▼
MySQL or PostgreSQL Engine
  │
  ▼
Databases, Tables and Records
```

## What AWS Manages

AWS can manage much of the infrastructure work, including:

- Database server provisioning
- Operating-system maintenance
- Database software installation
- Patching
- Automated backups
- Monitoring
- Failure detection
- Recovery options
- Storage configuration
- High availability options
- Read replica options

## What You Still Manage

You remain responsible for:

- Database design
- Tables
- Relationships
- Indexes
- Queries
- Users
- Permissions
- Security groups
- Application connections
- Data quality
- Performance tuning decisions

## Real-Life Example

A customer places an order.

```text
1. The customer clicks Buy.
2. The application sends an INSERT query.
3. RDS stores the order.
4. Inventory is reduced.
5. Payment status is recorded.
6. The application shows confirmation.
```

Example query:

```sql
INSERT INTO orders
(customer_id, product_id, quantity, status)
VALUES
(101, 5001, 1, 'PAID');
```

## RDS Advantages

- Familiar SQL
- Supports relationships
- Supports joins
- Managed backups
- Managed patching
- Easier than installing a database on EC2
- High availability options
- Read replicas
- Good for traditional applications

## RDS Limitations

- Capacity still needs planning
- Instances usually run continuously
- Complex queries may require tuning
- Connections must be managed
- Horizontal write scaling is not as simple as DynamoDB
- Poor indexes can cause slow performance

---

# 12. Amazon Aurora

Amazon Aurora is an AWS-built relational database engine.

It is compatible with:

- MySQL
- PostgreSQL

Aurora is part of the Amazon RDS family.

## Structure

```text
Amazon RDS
├── RDS for MySQL
├── RDS for PostgreSQL
├── RDS for MariaDB
├── RDS for Oracle
├── RDS for SQL Server
└── Amazon Aurora
    ├── MySQL-compatible
    └── PostgreSQL-compatible
```

## Aurora Design

Aurora separates:

- Compute
- Storage

This allows AWS to provide a cloud-oriented architecture.

## Aurora Is Useful For

- Production applications
- High-demand workloads
- MySQL compatibility
- PostgreSQL compatibility
- Multiple read replicas
- High availability
- Cloud-native applications
- Serverless database options

## RDS MySQL vs Aurora MySQL

| Area | RDS for MySQL | Aurora MySQL |
|---|---|---|
| Type | Relational | Relational |
| SQL | Yes | Yes |
| Compatibility | Native MySQL | MySQL-compatible |
| Architecture | Traditional managed instance | AWS cloud-designed cluster |
| Storage | Managed attached storage | Distributed cluster storage |
| Best for | Standard applications | Larger cloud workloads |
| Complexity | Usually simpler | More options |
| Cost | Often lower for small workloads | Can cost more depending on design |

---

# 13. Amazon DynamoDB

Amazon DynamoDB is a fully managed, serverless NoSQL database.

It supports:

- Key-value data
- Document data
- Automatic scaling
- Very fast key-based access
- Flexible item attributes
- Built-in high availability

## Important Difference

With RDS, you select an engine.

```text
RDS:
Choose MySQL, PostgreSQL, Oracle, etc.
```

With DynamoDB, you do not choose a separate database engine.

```text
DynamoDB:
AWS manages the complete NoSQL service.
```

## Basic DynamoDB Structure

```text
Application
    │
    │ AWS SDK or API
    ▼
DynamoDB Table
```

## DynamoDB Terminology

| DynamoDB Term | Meaning |
|---|---|
| Table | Collection of related data |
| Item | One record |
| Attribute | One field |
| Partition key | Main identifier |
| Sort key | Optional second identifier |
| Primary key | Partition key alone, or partition key plus sort key |
| GSI | Global Secondary Index |
| Query | Reads items using key conditions |
| Scan | Reads many or all items |

## Example Item

```json
{
  "userId": "USER-101",
  "name": "Ali",
  "email": "ali@example.com",
  "city": "Chicago",
  "skills": ["Linux", "AWS", "Docker"]
}
```

## Partition Key

The partition key is the main identifier.

Example:

```text
Table: Users
Partition Key: userId
```

| userId | name | city |
|---|---|---|
| USER-101 | Ali | Chicago |
| USER-102 | Sara | Dallas |

Retrieve one user:

```text
Get USER-101
```

DynamoDB uses the partition key to determine where the item is stored.

## Partition Key and Sort Key

Suppose we store customer orders.

```text
Partition Key: customerId
Sort Key: orderDate
```

| customerId | orderDate | product | amount |
|---|---|---|---:|
| C101 | 2026-07-01 | Laptop | 900 |
| C101 | 2026-07-05 | Mouse | 30 |
| C101 | 2026-07-09 | Monitor | 250 |

This allows the application to ask:

```text
Get all orders for customer C101
between July 1 and July 10.
```

## DynamoDB Access Patterns

In DynamoDB, design begins with this question:

> How will the application access the data?

Examples:

```text
Get user by user ID
Get all orders for a customer
Get orders between two dates
Get a product by product ID
Get all active cart items
Get unread notifications for a user
```

Then the keys and indexes are designed around these patterns.

## RDS Design vs DynamoDB Design

```text
RDS:
Design normalized tables first.
Create joins and queries later.

DynamoDB:
Understand access patterns first.
Design keys and indexes around those patterns.
```

## DynamoDB Advantages

- Fully managed
- Serverless
- Automatic scaling options
- Very low-latency access
- No operating-system management
- No database patching
- Flexible items
- Built-in high availability
- Good for massive request volume

## DynamoDB Limitations

- No traditional joins
- Complex ad hoc reporting is harder
- Poor key design causes problems
- Scans can be expensive
- Access patterns should be understood early
- Relationships are often handled in application logic
- Data modeling can be less intuitive for beginners

---

# 14. RDS vs DynamoDB

| Feature | Amazon RDS | Amazon DynamoDB |
|---|---|---|
| Database category | Relational SQL | NoSQL |
| Structure | Tables, rows, columns | Tables, items, attributes |
| Query method | SQL | API, SDK, PartiQL |
| Relationships | Excellent | Modeled manually |
| Joins | Yes | No traditional joins |
| Schema | Structured | Flexible |
| Infrastructure model | Managed instances | Serverless |
| Scaling | Instance and storage scaling | Automatic or configured capacity |
| Best access style | Flexible queries and joins | Known key-based access |
| Common use | Orders, accounts, ERP | Sessions, carts, gaming |
| Reporting | Strong | More limited |
| Transactions | Core strength | Supported, but used differently |
| Capacity planning | More infrastructure planning | Less server planning |

---

# 15. Real-Life Application Design

A real application may use more than one database service.

This is called:

> Polyglot persistence

It means using different databases for different types of data.

## School Application Example

```text
School Application
├── Amazon RDS
│   ├── Students
│   ├── Teachers
│   ├── Courses
│   ├── Fees
│   └── Results
│
└── DynamoDB
    ├── Login Sessions
    ├── Notifications
    ├── Quiz Progress
    └── User Activity
```

## Why RDS?

Because relationships matter.

```text
One student can join many courses.
One teacher can teach many students.
One course can have many exams.
One student can have many fee records.
```

## Why DynamoDB?

Because the application frequently performs direct access.

```text
Get session by session ID
Get quiz progress by student ID
Get unread notifications
Update last viewed lesson
```

## E-Commerce Example

```text
E-Commerce Application
├── RDS
│   ├── Customers
│   ├── Orders
│   ├── Payments
│   └── Invoices
│
├── DynamoDB
│   ├── Shopping Carts
│   ├── Sessions
│   └── User Activity
│
├── ElastiCache
│   ├── Product Cache
│   └── Frequently Viewed Items
│
└── Redshift
    └── Sales Analytics
```

---

# 16. Amazon ElastiCache

Amazon ElastiCache is an in-memory caching service.

It is used to store frequently accessed data in memory.

## Why Use a Cache?

Reading from memory is much faster than repeatedly reading from a database.

## Without Cache

```text
Application
    │
    ▼
Main Database
    │
    ▼
Result
```

## With Cache

```text
Application
    │
    ▼
Cache
  │
  ├── Data found → Return immediately
  │
  └── Data missing → Read from main database
```

## Common Uses

- Login sessions
- Product details
- API response caching
- Leaderboards
- Temporary data
- Frequently viewed pages
- Reducing database load

## Example

```text
First request:
Application → RDS → Save result in cache

Next request:
Application → Cache → Return quickly
```

ElastiCache usually supports a primary database. It is not normally the permanent system of record.

---

# 17. Amazon DocumentDB

Amazon DocumentDB is a document database service.

It stores JSON-like documents and is designed for MongoDB-compatible workloads.

## Example Document

```json
{
  "productId": "P100",
  "name": "Laptop",
  "specifications": {
    "ram": "16 GB",
    "storage": "1 TB",
    "processor": "Intel Core i7"
  },
  "tags": ["computer", "office", "portable"]
}
```

## Best Use Cases

- Product catalogs
- Content management
- User profiles
- Flexible document structures
- JSON-like data
- MongoDB-style applications

## When DocumentDB Is Better Than RDS

Use DocumentDB when:

- The data naturally looks like nested documents
- Fields vary between records
- Joins are not the main requirement
- JSON-style storage is preferred

---

# 18. Amazon Redshift

Amazon Redshift is a data warehouse.

It is designed for:

- Analytics
- Business intelligence
- Historical reporting
- Large aggregations
- Dashboards
- Data analysis across large datasets

## RDS vs Redshift

```text
RDS:
Record today's customer order.

Redshift:
Analyze five years of orders by:
- Region
- Product
- Customer type
- Month
- Revenue
```

## Typical Architecture

```text
Operational Databases
├── RDS
├── DynamoDB
└── Application Logs
       │
       ▼
    Redshift
       │
       ▼
Reports and Dashboards
```

## Important Point

Redshift is not normally used as the primary transactional database for a simple web application.

---

# 19. Amazon Neptune

Amazon Neptune is a graph database.

Graph databases focus on relationships between data.

## Example

```text
Khalid → KNOWS → Ali
Ali → WORKS_AT → Company
Company → LOCATED_IN → Chicago
```

## Best Use Cases

- Social networks
- Fraud detection
- Recommendation engines
- Knowledge graphs
- Identity relationships
- Network topology

## Why Not Use a Traditional Table?

Traditional databases can store relationships, but graph databases are designed to explore complex relationship paths efficiently.

Example question:

```text
Which users are connected to a suspicious account
through two or three relationships?
```

---

# 20. Amazon Timestream

Amazon Timestream is a time-series database.

Time-series data is information recorded over time.

## Example

```text
10:00 CPU usage = 40%
10:01 CPU usage = 55%
10:02 CPU usage = 72%
```

## Best Use Cases

- Server metrics
- IoT sensors
- Temperature readings
- Device telemetry
- Application monitoring
- Performance measurements
- Time-based events

## Why Use a Time-Series Database?

Because the most important field is often time.

Typical questions:

```text
What was CPU usage during the last hour?
What was the average temperature this week?
Which device showed abnormal activity?
```

---

# 21. Amazon Keyspaces

Amazon Keyspaces is a wide-column database service compatible with Apache Cassandra workloads.

## Best Use Cases

- Large distributed applications
- High-volume event data
- IoT applications
- Cassandra-compatible systems
- Wide-column data models

## Main Idea

Wide-column databases are useful when applications need:

- Large-scale distributed storage
- High write volume
- Flexible columns
- Cassandra-style access

---

# 22. Amazon MemoryDB

Amazon MemoryDB is a durable in-memory database with Redis compatibility.

## Difference from ElastiCache

```text
ElastiCache:
Mainly used as a cache.

MemoryDB:
Can be used as a durable primary database
for suitable in-memory workloads.
```

## Best Use Cases

- Very fast applications
- Durable in-memory data
- Real-time workloads
- Applications using Redis data structures

---

# 23. How to Choose the Right AWS Database

| Requirement | Suggested AWS Service |
|---|---|
| MySQL database | RDS for MySQL |
| PostgreSQL database | RDS for PostgreSQL |
| SQL Server application | RDS for SQL Server |
| Oracle workload | RDS for Oracle |
| Cloud-native MySQL or PostgreSQL | Aurora |
| Serverless key-value database | DynamoDB |
| JSON document database | DocumentDB |
| Caching | ElastiCache |
| Durable in-memory database | MemoryDB |
| Analytics and dashboards | Redshift |
| Connected relationship data | Neptune |
| Time-based measurements | Timestream |
| Cassandra-compatible workload | Keyspaces |

## Selection Questions

Ask these questions before choosing:

```text
Do I need SQL?
Do I need joins?
Do I need strong relationships?
Do I need flexible documents?
Do I need massive key-based scale?
Do I need caching?
Do I need analytics?
Do I need graph relationships?
Do I need time-series storage?
```

---

# 24. Simple Decision Flow

```text
Do you need SQL, joins, and relationships?
        │
        ├── Yes
        │    └── RDS or Aurora
        │
        └── No
             │
             ├── Key-value and massive scale?
             │      └── DynamoDB
             │
             ├── JSON documents?
             │      └── DocumentDB
             │
             ├── Cache or temporary fast data?
             │      └── ElastiCache
             │
             ├── Durable in-memory database?
             │      └── MemoryDB
             │
             ├── Analytics and reporting?
             │      └── Redshift
             │
             ├── Connected graph data?
             │      └── Neptune
             │
             ├── Time-series measurements?
             │      └── Timestream
             │
             └── Cassandra-compatible workload?
                    └── Keyspaces
```

---

# 25. Common Mistakes

## Mistake 1: Thinking RDS Is a Database Engine

Incorrect:

```text
RDS is a database engine.
```

Correct:

```text
RDS is a managed service.
MySQL or PostgreSQL is the engine.
```

## Mistake 2: Thinking DynamoDB Is a Relational Database

DynamoDB is NoSQL.

It does not use traditional joins like MySQL or PostgreSQL.

## Mistake 3: Choosing DynamoDB Only Because It Is Serverless

Serverless does not automatically mean it is the best choice.

DynamoDB is best when:

- Access patterns are known
- Key-based access is common
- High scale is needed

## Mistake 4: Using Redshift for Simple Transactions

Redshift is mainly for analytics, not normal order-entry transactions.

## Mistake 5: Using ElastiCache as the Only Permanent Database

ElastiCache is usually used as a cache, not the permanent source of truth.

## Mistake 6: Ignoring Database Design

Even managed services require good design.

Poor design can cause:

- Slow queries
- High costs
- Hot partitions
- Duplicate data
- Difficult reporting
- Application errors

---

# 26. Interview Questions and Answers

## What is a database?

A database is an organized collection of data that applications can store, retrieve, update, and manage.

## What is a database engine?

A database engine is the software responsible for storing, reading, updating, deleting, and protecting data.

## Is Amazon RDS a database engine?

No. Amazon RDS is a managed database service. It supports engines such as MySQL, PostgreSQL, MariaDB, Oracle, SQL Server, and Aurora.

## What is the difference between RDS and MySQL?

RDS is the AWS managed service. MySQL is one of the database engines that can run inside RDS.

## What is Amazon Aurora?

Amazon Aurora is an AWS-built relational database engine compatible with MySQL and PostgreSQL.

## What is DynamoDB?

DynamoDB is a fully managed, serverless NoSQL database designed for scalable key-value and document workloads.

## What is the main difference between RDS and DynamoDB?

RDS is relational and supports SQL, joins, schemas, and relationships. DynamoDB is NoSQL and is designed around partition keys, sort keys, and access patterns.

## Can an application use both RDS and DynamoDB?

Yes. For example:

```text
RDS:
Orders and payments

DynamoDB:
Sessions and shopping carts
```

## When should you use RDS?

Use RDS when you need:

- SQL
- Joins
- Relationships
- Transactions
- Structured data
- Flexible reporting

## When should you use DynamoDB?

Use DynamoDB when you need:

- Serverless NoSQL
- Fast key-based access
- Automatic scaling
- Flexible items
- Very high request volume
- Predictable access patterns

## What is a partition key?

A partition key is the main key DynamoDB uses to identify and distribute items.

## What is a sort key?

A sort key is an optional second key used to organize multiple related items under the same partition key.

## What is ElastiCache?

ElastiCache is an in-memory caching service used to speed up applications and reduce load on primary databases.

## What is Redshift?

Redshift is a data warehouse used for analytics, reporting, and business intelligence.

## What is DocumentDB?

DocumentDB is a document database service for JSON-like and MongoDB-compatible workloads.

## What is Neptune?

Neptune is a graph database for connected data and relationship-heavy applications.

## What is Timestream?

Timestream is a time-series database for data recorded over time, such as metrics and sensor readings.

---

# 27. Final Memory Tricks

```text
RDS         = Managed relational database service
MySQL       = Relational database engine
PostgreSQL  = Advanced relational database engine
Aurora      = AWS cloud-native SQL engine
DynamoDB    = Serverless NoSQL database
DocumentDB  = JSON-like documents
ElastiCache = Fast caching
MemoryDB    = Durable in-memory database
Redshift    = Analytics and reporting
Neptune     = Graph relationships
Timestream  = Time-based measurements
Keyspaces   = Cassandra-compatible wide-column database
```

## Most Important Comparison

```text
Need SQL, joins, and relationships?
→ RDS or Aurora

Need serverless, key-based, scalable NoSQL?
→ DynamoDB
```

## Final One-Line Summary

```text
RDS is the service.
MySQL is the engine.
The database stores the data.
The table organizes the records.
The query asks for the data.
```
