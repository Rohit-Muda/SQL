SELECT * FROM parks_and_recreation.employee_demographics;
# Selct statment selects the data from the db

SELECT * FROM parks_and_recreation.employee_salary;
SELECT * FROM employee_salary;
# Both Statements are differnet , if we are working the the database which consists the tables its fine not to use the database name , but if we are in some other database trying to access the existing db tables we need to use the db_name.table_name 
 
SELECT first_name FROM employee_salary;
SELECT first_name, 
last_name, 
salary 
FROM employee_salary;
# we can select all the fields using * clause but to select specific columns using thier names 

SELECT DISTINCT gender
FROM employee_demographics;
# Distrinct Keyword returns only the unique values of that column.