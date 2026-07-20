# Basic Information on Databases

- A database is a shared collection of logically related data description of these data designed to meet the information needs of an organization. 

## Properties of DB:

1. Integrity : Accuracy + consistancy
2. Availability
3. Security
4. Independent of Application
5. Concurrency

## Types of Databases:

1. Relational Databases: 
   - Data is stored in tables (rows and columns). Also Known as SQL Databases.
   - Examples: MySQL, PostgreSQL, Oracle

2. NoSQL Databases:
   - Data is stored in a non-tabular format. Also Known as Non-Relational Databases.
   - Examples: MongoDB, Cassandra, Redis

3. Column Databases:
    - Data is stored in columns rather than in rows. Used in Analytical applications.
    -Examples: Apache, HBase, Amazon Redshift, Google BigQuery

4. Graph Databases:
   - Used to store data in graph structures. Used for complex relationships and networks.
   - Examples: Neo4j, Amazon Neptune, ArangoDB

5. Key-Value Databases:
   - Data is stored as a collection of key-value pairs. Used for caching and session management.
   - Examples: Redis, DynamoDB, Riak

---

# Relational Databases 

- table -> relation
- column -> attribute
- row -> tuple
- no of rows ->cardinality
- no of columns -> degree
- domain -> set of values for an attribute

## DBMS
- Database Management System (DBMS) is a software that allows users to define, create, maintain, and control access to the database.
- Data Management - store , retrieve and modify data

- Integrity - maintain data accuracy and consistency
- Concurrency - allow multiple users to access the database simultaneously
- Transaction - Modification of a database must either be completed fully or not at all. (ACID properties)
- Security - protect data from unauthorized access and ensure privacy



