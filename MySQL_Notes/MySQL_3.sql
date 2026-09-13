# GROUP BY clause----

# when we are performing group by we need to either use a ARRGEGATE function and GROUP BY
# or we have to make sure the filed used for group by should exist in selected fields with the the aggregate function.

SELECT MAX(age)
FROM employee_demographics
GROUP BY gender;

SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender;

SELECT occupation
FROM employee_salary
GROUP BY occupation;

SELECT occupation, AVG(salary)
FROM employee_salary
GROUP BY occupation;

SELECT gender, AVG(age),MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender;


# ORDER BY clause--------
SELECT * FROM employee_demographics 
ORDER BY gender;

# By deadult is ORDERS in Ascending order i.e ASC
SELECT * FROM employee_demographics 
ORDER BY age;	
		
SELECT * FROM employee_demographics 
ORDER BY age DESC;

# what ever is first written in oder by cluase will be implemented first, if gender comes before age , gender will be Ordered first then age
SELECT * FROM employee_demographics 
ORDER BY gender, age;					

SELECT * FROM employee_demographics 
ORDER BY age, gender;                  # if duplicare ages are there then it will oder them by gender if not only age will be ordered

# we can use column numbers to ORDER BY but not recomended as it might confuse and cause problems
SELECT * FROM employee_demographics 
ORDER BY 5, 4; 