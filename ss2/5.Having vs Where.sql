-- Having vs Where 

Select gender, avg(age)
From employee_demographics
Group by gender 
Having avg(age) > 40
;

Select occupation, avg(salary)
From employee_salary
Where occupation LIKE '%manager%'
Group by occupation
Having avg(salary) > 75000
;