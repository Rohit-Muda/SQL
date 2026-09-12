show databases;

SELECT * FROM parks_and_recreation.employee_demographics;

SELECT * FROM employee_demographics
WHERE age>=40;

SELECT * FROM employee_demographics
WHERE gender='MALE';

SELECT * FROM employee_demographics
WHERE gender!='MALE';

SELECT * FROM employee_salary;

SELECT * FROM employee_salary
WHERE salary>=40000;

SELECT * FROM employee_demographics
WHERE birth_date>'1980-01-01';
# date format always : YYYY-MM-DD

# AND OR NOT operators
SELECT * FROM employee_demographics
WHERE birth_date>'1980-01-01' AND gender='Female';

SELECT * FROM employee_demographics
WHERE (birth_date>'1980-01-01' AND gender!='Female') OR age>50;

# LIKE statement
# % and _ 

SELECT * FROM employee_demographics
WHERE first_name LIKE 'Jer%';			# names that start with 'Jer'

SELECT * FROM employee_demographics
WHERE first_name LIKE '%er%';			# has 'er' somewhere between in the first name

SELECT * FROM employee_demographics
WHERE first_name LIKE '%a';				# ending with 'a' or amything- use before the needed letter

SELECT * FROM employee_demographics
WHERE first_name LIKE 'a%';

SELECT * FROM employee_demographics
WHERE first_name LIKE 'a___';			# name startig with 'a' and having 3 characters after exactly

SELECT * FROM employee_demographics
WHERE first_name LIKE 'a___%';  		# name startig with 'a' and having 3 characters and then may or may not have anything after