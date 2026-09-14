SELECT *
FROM parks_departments;

SELECT first_name,last_name,age,
CASE
	WHEN age<=30 THEN 'YOUNG'
	WHEN age BETWEEN 31 and 50 THEN 'OLD'
    WHEN age>=50 THEN 'DEAD'
END AS age_status
FROM employee_demographics;


# Example
# salary <50000 -> 5% increase
# salary >=50000 -> 7% increase
# dept = Finance or Healthcare -> 10% bonus

SELECT first_name, last_name, salary,
CASE
	WHEN salary<50000 THEN salary+(salary*0.05)
    WHEN salary>50000 THEN salary+(salary*0.07)
END AS Increments,
CASE 
	WHEN dept_id=6 or dept_id=4 THEN salary*0.10
END AS Bonus
FROM employee_salary;