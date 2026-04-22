-- WHERE Clause

SELECT *
FROM employee_salary
-- WHERE first_name = 'Leslie'
WHERE salary <= 50000
;

SELECT *
FROM employee_demographics
-- WHERE gender != 'female'
WHERE birth_date > '1985-01-01'
;

-- AND OR NOT -- Logical Operators
SELECT *
FROM employee_demographics
-- WHERE birth_date > '1985-01-01' 
-- AND gender  = 'male'
-- OR gender = 'male'

WHERE (first_name = 'Leslie' AND age = 44) OR age > 55
;

-- LIKE Statement
-- % and _
SELECT *
FROM employee_demographics
-- WHERE first_name LIKE '%a%'
-- WHERE first_name LIKE 'a___%'
WHERE birth_date LIKE '1989%'
;




