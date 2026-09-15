# SQL and DBMS Interview Revision

Structured revision reference for SQL and DBMS interview rounds (Virtusa-style, applicable broadly to service-based company interviews).

## Contents

- Part A — Priority 1: Must answer instantly (16 topics)
- Part B — Priority 2: Very important (13 topics)
- Part C — Priority 3: DBMS theory (16 topics)
- Part D — Additional topics (not in original notes, commonly asked)
- Part E — Must-write queries
- Part F — Common traps, quick reference table
- Part G — Interview behavior guidelines
- Part H — Thirty-second rapid revision block

---

## Part A — Priority 1

### 1. WHERE vs HAVING
**Say:** WHERE filters rows before grouping. HAVING filters groups after GROUP BY. Aggregate conditions (COUNT, AVG) belong in HAVING.
```sql
SELECT department_id, COUNT(*)
FROM Employee
WHERE salary > 50000
GROUP BY department_id
HAVING COUNT(*) > 5;
```
**Trap:** `WHERE COUNT(*) > 5` is invalid; use HAVING.
**If they push:** WHERE executes before aggregation exists, so the aggregate value is not yet available at that stage.

---

### 2. WHERE vs ON
**Say:** ON defines how rows are matched during a JOIN. WHERE filters the joined result afterward. This distinction matters most with LEFT JOIN, where a condition placed in WHERE can silently convert it into an INNER JOIN by removing NULL-extended rows.
```sql
-- preserves all employees
LEFT JOIN Department d ON e.dept_id = d.id AND d.location = 'Mumbai'

-- drops employees with no Mumbai department
LEFT JOIN Department d ON e.dept_id = d.id
WHERE d.location = 'Mumbai'
```

---

### 3. INNER JOIN vs LEFT JOIN
**Say:** INNER JOIN returns only rows with a match in both tables. LEFT JOIN returns every row from the left table plus matches; unmatched right-side columns become NULL.
**Use case:** Employees with no department — `LEFT JOIN ... WHERE d.id IS NULL`.

---

### 4. LEFT JOIN vs RIGHT JOIN
**Say:** LEFT JOIN preserves the left table; RIGHT JOIN preserves the right table. Swapping table order makes them equivalent, so LEFT JOIN is generally preferred for readability.

---

### 5. JOIN vs UNION
**Say:** JOIN combines tables horizontally, adding columns. UNION combines result sets vertically, adding rows.
**Key fact:** JOIN requires only a matching condition, not identical columns. UNION requires the same column count and compatible data types across all SELECT statements.

---

### 6. UNION vs UNION ALL
**Say:** UNION removes duplicate rows across combined result sets. UNION ALL retains duplicates and is faster since it skips de-duplication.

---

### 7. GROUP BY vs DISTINCT
**Say:** DISTINCT removes duplicate rows from the output. GROUP BY forms groups and is primarily used for aggregation.
```sql
SELECT DISTINCT department_id FROM Employee;
SELECT department_id, COUNT(*) FROM Employee GROUP BY department_id;
```

---

### 8. COUNT(*) vs COUNT(column)
**Say:** COUNT(*) counts all rows, including those with NULLs. COUNT(column) counts only non-NULL values in that column.

| id | salary |
|----|--------|
| 1  | 50000  |
| 2  | NULL   |

`COUNT(*) = 2`, `COUNT(salary) = 1`

---

### 9. IN vs EXISTS
**Say:** IN checks whether a value exists in a subquery's result set. EXISTS checks whether the subquery returns any row at all, and is commonly used with correlated subqueries.
**Trap:** Do not claim EXISTS is always faster; performance depends on indexes and the execution plan.

---

### 10. NOT IN vs NOT EXISTS
**Say:** Both identify non-matching rows, but NOT IN produces unexpected empty results if the subquery contains NULL, due to SQL's three-valued logic. NOT EXISTS is not affected by this and is the safer choice.

---

### 11. DELETE vs TRUNCATE vs DROP
**Say:** DELETE removes rows and supports WHERE; it can generally be rolled back. TRUNCATE removes all rows but keeps the table structure and is typically not filterable. DROP removes the entire table, including its structure.

| Command  | Rows removed  | Structure kept | WHERE allowed |
|----------|---------------|-----------------|---------------|
| DELETE   | Selected/all  | Yes             | Yes           |
| TRUNCATE | All           | Yes             | No            |
| DROP     | All           | No              | No            |

**Caution:** Do not state that TRUNCATE always rolls back. In MySQL it behaves like DDL and causes an implicit commit.

---

### 12. Primary Key vs Foreign Key
**Say:** A primary key uniquely identifies a row in its own table and cannot be NULL. A foreign key references another table's key to establish a relationship, and can be NULL unless restricted.

---

### 13. Primary Key vs UNIQUE Key
**Say:** Both enforce uniqueness. A table has only one primary key, but can have multiple UNIQUE constraints. A primary key can never be NULL; UNIQUE column NULL behavior is database-specific (MySQL allows multiple NULLs in a UNIQUE column).

---

### 14. NULL Handling
**Say:** NULL represents an unknown or missing value, not zero or an empty string. `NULL = NULL` evaluates to UNKNOWN, not TRUE. Always use `IS NULL` or `IS NOT NULL`.
**Trap:** `WHERE salary = NULL` is always false and returns no rows.

---

### 15. GROUP BY vs Window Functions
**Say:** GROUP BY collapses rows into one row per group. Window functions calculate across related rows without collapsing them, so every original row remains visible.
```sql
SELECT name, department_id, salary,
       AVG(salary) OVER (PARTITION BY department_id) AS dept_avg
FROM Employee;
```

---

### 16. RANK vs DENSE_RANK vs ROW_NUMBER
**Say:** ROW_NUMBER assigns a unique number to every row. RANK assigns tied rows the same rank but skips subsequent numbers. DENSE_RANK assigns tied rows the same rank with no gap.

Salaries `100, 100, 90, 80`:

| ROW_NUMBER | RANK    | DENSE_RANK |
|------------|---------|------------|
| 1, 2, 3, 4 | 1,1,3,4 | 1,1,2,3    |

---

## Part B — Priority 2

### 17. JOIN vs Subquery
**Say:** JOIN merges columns from related tables in one step. A subquery is nested inside another query, often used for filtering or existence checks. Neither is universally faster; it depends on the optimizer and indexes.

### 18. Subquery vs Correlated Subquery
**Say:** A normal subquery executes independently once. A correlated subquery references a column from the outer query and re-evaluates for each outer row.
```sql
WHERE salary > (SELECT AVG(salary) FROM Employee e2 WHERE e2.dept_id = e.dept_id)
```

### 19. CTE vs Subquery
**Say:** A CTE, defined with `WITH`, is a named, reusable result set that improves readability in complex, multi-step queries. A subquery is nested inline. The choice is mainly about clarity, not a guaranteed performance difference.

### 20. PARTITION BY vs GROUP BY
**Say:** GROUP BY reduces the result to one row per group. PARTITION BY, used with window functions, divides rows into logical groups for calculation while keeping every row.

### 21. Candidate Key vs Super Key
**Say:** A super key is any set of columns that uniquely identifies a row. A candidate key is a minimal super key, with no redundant column. Remember: a candidate key is a minimal super key.

### 22. Candidate Key vs Primary Key
**Say:** All candidate keys could serve as an identifier; one is chosen as the primary key. The remaining candidate keys can be implemented as UNIQUE constraints.

### 23. Composite Key
**Say:** A key formed from two or more columns that are unique together, even though no single column is unique alone.
```sql
PRIMARY KEY (student_id, course_id)
```

### 24. Multiple Primary Keys or Multiple UNIQUE Constraints
**Say:** A table can have only one primary key constraint, though it can span multiple columns (composite). Multiple UNIQUE constraints on different columns are allowed.

### 25. Can a Foreign Key Contain NULL
**Say:** Yes, unless explicitly defined as NOT NULL. NULL simply means no relationship has been assigned yet.

### 26. UNION Requirements
**Say:** Every SELECT statement in a UNION must return the same number of columns with compatible data types in the same position. Column names do not need to match; the output uses the first query's column names.

### 27. Logical SQL Execution Order
**Say:** Although SELECT is written first, SQL logically processes: FROM/JOIN, then WHERE, then GROUP BY, then HAVING, then SELECT, then DISTINCT, then ORDER BY, then LIMIT.
**Why it matters:** This is why a SELECT alias generally cannot be used inside WHERE — WHERE executes before SELECT.

### 28. SELF JOIN
**Say:** A table joined to itself, used for hierarchical or self-referencing data such as employee-manager relationships.
```sql
SELECT e.name AS employee, m.name AS manager
FROM Employee e LEFT JOIN Employee m ON e.manager_id = m.id;
```

### 29. CROSS JOIN
**Say:** Returns the Cartesian product of two tables — every row of one combined with every row of the other. Three rows by four rows produces twelve rows. Use intentionally, since an accidental cross join can generate a very large result set.

### 30. FULL OUTER JOIN
**Say:** Returns all rows from both tables, matching where possible and filling unmatched columns with NULL. MySQL has no native FULL OUTER JOIN syntax; it is typically emulated with a LEFT JOIN and RIGHT JOIN combined through UNION.

### 31. Constraints and Referential Integrity
**Say:** Constraints (PRIMARY KEY, FOREIGN KEY, UNIQUE, NOT NULL, CHECK, DEFAULT) enforce data validity. Referential integrity specifically requires a foreign key to reference an existing parent row, or be NULL where permitted.

---

## Part C — Priority 3: DBMS Theory

### 32. DBMS
**Say:** Software used to create, store, organize, retrieve, and manage data, with built-in support for security, concurrency, and transactions. Examples: MySQL, PostgreSQL, Oracle, SQL Server.

### 33. DBMS vs RDBMS
**Say:** DBMS is the general category of database management software. RDBMS specifically follows the relational model, storing data in related tables using keys, with stronger constraint and integrity support.

### 34. Database vs Table vs Schema
**Say:** A database is an organized collection of data. A table stores records as rows and attributes as columns. A schema is the logical blueprint defining tables, relationships, constraints, and other database objects.

### 35. Normalization
**Say:** The process of structuring relational data to reduce redundancy and avoid update, insert, and delete anomalies, based on functional dependencies rather than simply removing duplicate values.

- **1NF** — atomic values, no repeating groups
- **2NF** — 1NF, plus no partial dependency (relevant when the key is composite)
- **3NF** — 2NF, plus no transitive dependency (a non-key column depending on another non-key column)

### 36. Denormalization
**Say:** Deliberately introducing redundancy to improve read performance or simplify queries, trading off some integrity and storage efficiency for speed.

### 37. Indexes
**Say:** A data structure that speeds up data retrieval, at the cost of additional storage and slower writes, since every INSERT, UPDATE, and DELETE must also update the index.
**Why not index every column:** Each index adds write overhead and storage cost; index only columns used frequently in filters, joins, or sorting.

### 38. Transactions
**Say:** A logical unit of operations that must all succeed together or not apply at all — for example, a bank transfer involving a debit and a credit. Managed through BEGIN, COMMIT, and ROLLBACK.

### 39. ACID Properties
- **Atomicity** — all operations succeed, or none do
- **Consistency** — the database moves from one valid state to another
- **Isolation** — concurrent transactions do not improperly affect each other
- **Durability** — once committed, data persists even after a failure

### 40. Views
**Say:** A virtual table defined by a stored query, without storing a separate copy of the data. Used to simplify complex queries or restrict exposed columns and rows.
```sql
CREATE VIEW HighEarners AS
SELECT id, name, salary FROM Employee WHERE salary > 50000;
```

### 41. Stored Procedures
**Say:** A named, reusable block of SQL logic stored in the database, which can accept parameters and execute as a single unit. Unlike a view, which represents queryable data, a stored procedure performs actions.

### 42. Triggers
**Say:** Database-side logic that executes automatically in response to an event such as INSERT, UPDATE, or DELETE — for example, writing an audit record automatically. Useful for auditing, but excessive trigger logic can make systems difficult to debug.

### 43. DDL, DML, DQL, DCL, TCL

| Category | Commands                       | Purpose             |
|----------|---------------------------------|----------------------|
| DDL      | CREATE, ALTER, DROP, TRUNCATE   | Define structure     |
| DML      | INSERT, UPDATE, DELETE          | Modify data          |
| DQL      | SELECT                          | Query data           |
| DCL      | GRANT, REVOKE                   | Manage permissions   |
| TCL      | COMMIT, ROLLBACK, SAVEPOINT     | Control transactions |

### 44. CHAR vs VARCHAR
**Say:** CHAR is fixed-length storage. VARCHAR stores variable-length strings up to a defined maximum. Use VARCHAR when lengths vary; CHAR suits fixed-format values such as country codes.

### 45. COALESCE vs IFNULL
**Say:** COALESCE returns the first non-NULL value from a list and is standard, portable SQL. IFNULL is MySQL-specific and accepts only two arguments.

### 46. CASE vs IF
**Say:** CASE is standard SQL and portable across database systems. IF is database-specific, primarily used in MySQL.

### 47. LIKE and BETWEEN
**Say:** LIKE performs wildcard pattern matching, for example `LIKE 'R%'` for names starting with R. BETWEEN is inclusive of both boundary values, so `BETWEEN 50000 AND 80000` includes both figures.

---

## Part D — Additional Topics

Topics not present in the original notes but commonly asked in the same interview rounds.

### 48. Clustered vs Non-Clustered Index
**Say:** A clustered index determines the physical storage order of table data, so a table can have only one. A non-clustered index is a separate structure that points back to the actual data, and a table can have several.
**Follow-up:** The primary key typically creates a clustered index by default in most relational databases.

### 49. EXPLAIN / Execution Plan
**Say:** EXPLAIN shows how the database engine intends to execute a query — which indexes it will use, join order, and estimated cost. It is the correct way to verify a performance claim instead of guessing.
**Interview line:** "I would run EXPLAIN and compare execution plans rather than assume one query is faster."

### 50. Isolation Levels
**Say:** Isolation levels control how visible one transaction's changes are to another concurrent transaction, trading consistency for concurrency.
- **Read Uncommitted** — allows dirty reads
- **Read Committed** — no dirty reads, default in many databases
- **Repeatable Read** — no dirty or non-repeatable reads
- **Serializable** — strictest, fully isolated, lowest concurrency

### 51. Locking and Deadlocks
**Say:** A lock prevents concurrent transactions from conflicting on the same data. A deadlock occurs when two transactions each hold a lock the other needs, so neither can proceed. Databases detect deadlocks and roll back one transaction automatically.

### 52. Stored Procedure vs Function
**Say:** A stored procedure performs a set of operations and may not need to return a value; a function is generally required to return a value and can be used inside a SELECT statement or expression. Exact rules vary by database.

### 53. Common Date and String Functions
**Say (only if asked for examples):**
```sql
NOW()              -- current date and time
DATEDIFF(d1, d2)   -- difference between dates
CONCAT(a, b)       -- join strings
SUBSTRING(str,1,3) -- extract part of a string
UPPER(str) / LOWER(str)
TRIM(str)
```

### 54. Data Types Overview
**Say:** Common categories are numeric (INT, DECIMAL, FLOAT), string (CHAR, VARCHAR, TEXT), date/time (DATE, DATETIME, TIMESTAMP), and boolean. Choosing the right type affects storage size and query correctness — for example, using DECIMAL instead of FLOAT for currency to avoid rounding errors.

### 55. SQL Injection Awareness
**Say:** SQL injection occurs when untrusted input is concatenated directly into a query string, letting an attacker alter the query's logic. The standard defense is parameterized queries or prepared statements, which treat input strictly as data, never as executable SQL.

---

## Part E — Must-Write Queries

Memorize the shape of each query, not the exact wording.

```sql
-- Second highest salary
SELECT MAX(salary) FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee);

-- Second highest salary, alternate method
SELECT DISTINCT salary FROM Employee
ORDER BY salary DESC LIMIT 1 OFFSET 1;

-- Nth highest salary, handles duplicate salaries correctly
SELECT salary FROM (
  SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
  FROM Employee
) ranked
WHERE rnk = N;

-- Employees earning above the average salary
SELECT * FROM Employee
WHERE salary > (SELECT AVG(salary) FROM Employee);

-- Duplicate records by email
SELECT email, COUNT(*) FROM Employee
GROUP BY email HAVING COUNT(*) > 1;

-- Employees with no department
SELECT e.* FROM Employee e
LEFT JOIN Department d ON e.department_id = d.id
WHERE d.id IS NULL;

-- Employee count per department
SELECT department_id, COUNT(*) FROM Employee
GROUP BY department_id;

-- Departments with more than 5 employees
SELECT department_id, COUNT(*) FROM Employee
GROUP BY department_id HAVING COUNT(*) > 5;

-- Top 3 salaries within each department
SELECT * FROM (
  SELECT e.*,
         DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rnk
  FROM Employee e
) ranked
WHERE rnk <= 3;
```

---

## Part F — Common Traps, Quick Reference

| Incorrect                                | Correct                                                   |
|-------------------------------------------|-------------------------------------------------------------|
| `WHERE salary = NULL`                     | `WHERE salary IS NULL`                                       |
| `WHERE COUNT(*) > 5`                      | `HAVING COUNT(*) > 5`                                         |
| "TRUNCATE always rolls back"              | Database-specific; MySQL TRUNCATE causes an implicit commit  |
| "EXISTS or JOIN is always faster"         | "Depends on indexes and the execution plan"                  |
| `NOT IN` with a nullable subquery         | Use `NOT EXISTS` instead                                      |
| LEFT JOIN with a filter placed in WHERE   | Move the condition into ON to preserve all left-table rows   |
| "DBMS does not use tables"                | RDBMS specifically follows the relational model              |

---

## Part G — Interview Behavior Guidelines

1. **Answer briefly first.** Definition, key difference, one example. Stop, and let the interviewer decide whether to probe further.
2. **"Which is faster" questions.** Never pick a side without qualification. Say: "It depends on data size, indexes, and the execution plan."
3. **If corrected by the interviewer.** Stay composed. Say: "You are right, let me correct that," then restate the accurate version. This demonstrates reasoning ability rather than rote memorization.
4. **If you do not know an answer.** Say: "I have not worked with that in depth, but my understanding is..." Never guess or fabricate a technical answer.
5. **For query-writing problems, think aloud in steps:**
   What output is required? Which table(s)? Is a WHERE filter needed? Is a JOIN needed? Is grouping needed? Is HAVING needed? Is a window function needed? Is sorting or limiting needed?

---

## Part H — Thirty-Second Rapid Revision

```
WHERE filters rows        HAVING filters groups        ON defines join match
JOIN adds columns         UNION adds rows (dedup)       UNION ALL keeps duplicates
DISTINCT removes dup rows GROUP BY forms groups
INNER = matches only      LEFT = all left + match       RIGHT = all right + match
FULL = both sides         SELF = table joined to itself CROSS = Cartesian product
ROW_NUMBER = unique       RANK = ties with gap           DENSE_RANK = ties, no gap
Primary key = unique, not null, one per table
Foreign key = references another table's key, can be null
Candidate key = minimal super key; one becomes the primary key
DELETE = rows, supports WHERE
TRUNCATE = all rows, structure kept
DROP = entire table removed
COUNT(*) = all rows       COUNT(column) = non-null values only
IS NULL is correct        = NULL is incorrect
NOT EXISTS is safer than NOT IN when NULLs are possible
1NF: atomic values   2NF: no partial dependency   3NF: no transitive dependency
ACID: Atomicity, Consistency, Isolation, Durability
Execution order: FROM/JOIN -> WHERE -> GROUP BY -> HAVING -> SELECT -> DISTINCT -> ORDER BY -> LIMIT
Clustered index: one per table, defines physical order
Non-clustered index: multiple allowed, points to data
Isolation levels (weakest to strongest): Read Uncommitted, Read Committed, Repeatable Read, Serializable
```
