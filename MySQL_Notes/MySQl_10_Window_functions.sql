-- Window Functions

-- Window functions perform calculations across a set of related rows
-- without combining those rows into a single row like GROUP BY does.
-- Each original row is preserved while the calculation is added to the result.
-- Common window functions include ROW_NUMBER(), RANK(), DENSE_RANK(), SUM(), AVG(), etc.

SELECT * 
FROM employee_demographics;


-- GROUP BY combines all rows of each gender into one row,
-- so we get only one average salary for each gender.
SELECT gender, ROUND(AVG(salary),1)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
;


-- Window functions calculate the average across all rows,
-- but keep every employee's individual row in the output.
SELECT dem.employee_id, dem.first_name, gender, salary,
AVG(salary) OVER()
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;


-- We can still keep individual rows while performing calculations across them.
-- Window functions can do much more than a subquery, especially with PARTITION BY and ORDER BY.


-- PARTITION BY divides the rows into groups for the calculation,
-- similar to GROUP BY, but does NOT combine the rows.
-- Here, the average salary is calculated separately for each gender.
SELECT dem.employee_id, dem.first_name, gender, salary,
AVG(salary) OVER(PARTITION BY gender)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;


-- SUM() calculates the total salary within each gender.
-- ORDER BY makes it a running total, adding each employee's salary progressively.
SELECT dem.employee_id, dem.first_name, gender, salary,
SUM(salary) OVER(PARTITION BY gender ORDER BY employee_id)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;


-- ROW_NUMBER(), RANK(), and DENSE_RANK() assign positions/ranks to rows.


-- ROW_NUMBER() gives every row a unique sequential number within each gender.
SELECT dem.employee_id, dem.first_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;


-- ORDER BY salary DESC ranks employees from highest salary to lowest salary.
-- ROW_NUMBER() still gives every employee a unique number, even if salaries are equal.
SELECT dem.employee_id, dem.first_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary desc)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;


-- Comparing ROW_NUMBER() and RANK():
-- ROW_NUMBER() gives unique positions.
-- RANK() gives the same rank to tied values and then skips positions after the tie.
SELECT dem.employee_id, dem.first_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary desc) row_num,
Rank() OVER(PARTITION BY gender ORDER BY salary desc) rank_1 
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;


-- RANK() uses positional ranking.
-- If two employees are tied at rank 5, the next employee gets rank 7.


-- Comparing this to DENSE_RANK():
-- DENSE_RANK() also gives the same rank to tied values,
-- but does NOT skip the next rank after a tie.
SELECT dem.employee_id, dem.first_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary desc) row_num,
Rank() OVER(PARTITION BY gender ORDER BY salary desc) rank_1,
dense_rank() OVER(PARTITION BY gender ORDER BY salary desc) dense_rank_2 -- this is numerically ordered instead of positional like rank
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;