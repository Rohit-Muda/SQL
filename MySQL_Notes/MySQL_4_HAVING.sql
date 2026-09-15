# HAVING vs WHERE clause

SELECT * FROM employee_salary;

# we can use HAVING clause when you want to GROUP BY the selected fileds
#but we cannot use hwere clause and group by while using aggregate functions as the aggrigate function isnt created
# Agggregate function is only applied after GROUP BY but WHERE clause runs before group by causeing issue 

SELECT occupation, AVG(salary)
FROM employee_salary
GROUP BY occupation
HAVING AVG(salary)>50000;

# But if we dont use WHERE with AGGREGATE functions then we can use where becuse here the group by is applied, where clause without aggregate function is uesed 
# and then aggregate function is used.

SELECT occupation, AVG(salary)
FROM employee_salary
WHERE occupation LIKE '%manager%'
GROUP BY occupation
HAVING AVG(salary)>50000;
