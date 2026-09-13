# UNION clause

# UNION combines the results of two or more SELECT queries into one result set.
# Both SELECT statements must have the same number of columns, with compatible data types.

# just a example but in real world we cannot use this
SELECT age, gender
FROM employee_demographics
UNION
SELECT first_name, last_name
FROM employee_salary;

# same fields being UNION will take only distinct value UNION by default gives UNION DISTINCT
# UNION removes duplicate rows by default (equivalent to UNION DISTINCT).
SELECT age, gender
FROM employee_demographics
UNION
SELECT age, gender
FROM employee_demographics;

# if you ned all values irrespective of duplication use UNION ALL
# UNION ALL keeps all rows, including duplicates, and is generally faster than UNION.
SELECT age, gender
FROM employee_demographics
UNION ALL
SELECT age, gender
FROM employee_demographics;

# Eaxample case of multiple UNIONS
# Multiple UNIONs can combine results from different conditions/tables into one result set.
SELECT first_name,last_name, 'OLD MAN' as label
FROM employee_demographics
WHERE age>40 and gender='Male'
UNION
SELECT first_name,last_name, 'OLD LADY' as label
FROM employee_demographics
WHERE age>40 and gender='Female'
UNION
SELECT first_name,last_name, 'RICH' as label
FROM employee_salary
WHERE salary>70000;