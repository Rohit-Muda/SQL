SELECT * FROM employee_demographics;


# INNER JOIN: Returns only the rows that have a matching employee_id in both tables.
SELECT *
FROM employee_demographics 
INNER JOIN employee_salary
ON employee_demographics.employee_id=employee_salary.employee_id;


# LEFT JOIN: Returns all rows from the left table and matching rows from the right table; unmatched right-side values are NULL.
SELECT *
FROM employee_demographics 
LEFT JOIN employee_salary
ON employee_demographics.employee_id=employee_salary.employee_id; 


# RIGHT JOIN: Returns all rows from the right table and matching rows from the left table; unmatched left-side values are NULL.
SELECT *
FROM employee_demographics 
RIGHT JOIN employee_salary
ON employee_demographics.employee_id=employee_salary.employee_id;


# SELF JOIN: Joins a table with itself, treating the same table as two separate tables using aliases.
SELECT * 
FROM employee_demographics emp1
JOIN employee_demographics emp2
ON emp1.employee_id=emp2.employee_id;


# SELF JOIN: Allows you to compare or retrieve data from two different "copies" of the same table.
SELECT emp1.employee_id,emp1.first_name,emp1.last_name,
emp2.gender, emp2.age,emp2.birth_date
FROM employee_demographics emp1
JOIN employee_demographics emp2
ON emp1.employee_id=emp2.employee_id;


# SECRET SANTA example
# SELF JOIN: Can pair employees from the same table by treating one copy as the Santa and the other as the recipient.
SELECT 
emp1.employee_id as santa_id,
emp1.first_name as santa_first_name, 
emp1.last_name as santa_last_name,
emp2.employee_id as emp_id,
emp2.first_name as emp_first_name, 
emp2.last_name as emp_last_name
FROM employee_demographics emp1
JOIN employee_demographics emp2
ON emp1.employee_id=emp2.employee_id;


#Multiple tables joined together
# MULTI-TABLE JOIN: Combines data from multiple related tables using matching keys to get information from all of them.
SELECT *
FROM employee_demographics demo
INNER JOIN employee_salary sal
	ON demo.employee_id=sal.employee_id
INNER JOIN parks_departments pd
	ON sal.dept_id = pd.department_id;