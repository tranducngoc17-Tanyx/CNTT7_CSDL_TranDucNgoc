-- GROUP BY

Select *
From employee_demographics;


Select gender, AVG(age), MAX(age), MIN(age), COUNT(age)
From employee_demographics
GROUP BY gender 
;


-- Select occupation, salary
-- From employee_salary
-- GROUP BY occupation, salary 
-- ;

-- ORDER BY
-- ASC là tăng dần, DESC là giảm dần
Select *
From employee_demographics
-- ORDER BY first_name DESC
ORDER BY gender, age
-- ORDER BY age, gender DESC -- Nên chú ý cách đặt mênh đề ORDER BY, đặt sai thì sẽ vô dụng như đoạn này!!!
;


