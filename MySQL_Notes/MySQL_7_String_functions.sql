SELECT * FROM employee_demographics;

# LENGTH finds the length of the String
# eg : when checking phone number has exactly 10 characters/numbers
SELECT first_name, LENGTH(first_name)
FROM employee_demographics;

# UPPER and LOWER convert into upper .lower case
SELECT first_name,UPPER(first_name)
from employee_demographics;

SELECT first_name,lower(first_name)
from employee_demographics;

SELECT lower(first_name),UPPER(first_name)
from employee_demographics;

# TRIM, LTRIM, RTRIM 
SELECT TRIM('    sky    ') as trimmed;
SELECT LTRIM('    sky    ') as trimmed;
SELECT RTRIM('    sky    ') as trimmed;

# LEFT, RIGHT and SUBSTIRNG
SELECT first_name, LEFT(first_name, 4)
FROM employee_demographics;

SELECT first_name, RIGHT(first_name, 4)
FROM employee_demographics;

SELECT first_name,LEFT(first_name, 4),
RIGHT(first_name, 4),
SUBSTRING(first_name,3,2)
FROM employee_demographics;
# SUBSTRING example will be accessing only year of the DOB

# REPLACE and LOCATE
SELECT first_name, REPLACE(first_name,'e','z')
FROM employee_demographics;

SELECT LOCATE('o','rohit');


#CONCAT
SELECT first_name,last_name,
CONCAT(first_name,' ',last_name) as full_name
FROM employee_demographics;