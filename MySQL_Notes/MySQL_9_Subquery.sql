# Subqueries

# A subquery is a query written inside another SQL query.
# The inner query runs first and its result is used by the outer query.

SELECT *
FROM employee_demographics;

SELECT *
FROM parks_departments;


# The subquery gets employee_ids belonging to department 1,
# and the outer query returns the matching employee details.
SELECT * FROM employee_demographics
WHERE employee_id IN (
	SELECT employee_id FROM parks_departments
    WHERE department_id=1
);


# The subquery calculates the overall average salary,
# and the outer query displays it alongside every employee's salary.
SELECT first_name, salary,(
	SELECT AVG(salary) FROM employee_salary
) AS avg_salary
FROM employee_salary;


# Regular aggregate functions calculate summary values for each gender group.
SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender;


# here we slected subquerry fields and used to access specific fields only
# The inner query creates a temporary result (derived table),
# and the outer query can select and perform further operations on its columns.
SELECT gender, AVG(`MAX(age)`)
FROM(
	SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
	FROM employee_demographics
	GROUP BY gender
) AS agg_table
GROUP BY gender;


# using alias
# Aliases give meaningful names to subquery columns, making them easier to reference in the outer query.
SELECT gender, AVG(age_avg)
FROM(
	SELECT gender, 
	AVG(age) as age_avg,
    MAX(age) as age_max,
    MIN(age) as age_min,
    COUNT(age) as age_count
	FROM employee_demographics
	GROUP BY gender
) AS agg_table
GROUP BY gender;