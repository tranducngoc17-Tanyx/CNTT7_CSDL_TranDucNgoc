CREATE DATABASE CompanyDB;

USE CompanyDB;

CREATE TABLE Department (
    dept_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    dept_name VARCHAR(100) NOT NULL,
    location VARCHAR(100)
);

CREATE TABLE Employee (
    emp_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    emp_name VARCHAR(100) NOT NULL,
    gender INT DEFAULT 1,
    birth_date DATE,
    salary DECIMAL(10,2),
    dept_id INT,

    CONSTRAINT fk_employee_department
    FOREIGN KEY (dept_id)
    REFERENCES Department(dept_id)
    ON UPDATE CASCADE
);

CREATE TABLE Project (
    project_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    project_name VARCHAR(150) NOT NULL,
    emp_id INT,
    start_date DATE DEFAULT (CURRENT_DATE),
    end_date DATE,

    CONSTRAINT fk_project_employee
    FOREIGN KEY (emp_id)
    REFERENCES Employee(emp_id)
);

ALTER TABLE Employee
ADD COLUMN email varchar(100) unique;

ALTER TABLE Project
MODIFY project_name varchar(200);

ALTER TABLE Project
ADD CONSTRAINT chk_project_date
CHECK (end_date >= start_date OR end_date IS NULL);

INSERT INTO Department (dept_name, location)
VALUES
('IT', 'Ha Noi'),
('HR', 'HCM'),
('Marketing', 'Da Nang');

INSERT INTO Employee (emp_name, gender, birth_date, salary, dept_id, email)
VALUES
('Nguyen Van A', 1, '1990-01-15', 1500, 1, 'a@gmail.com'),
('Tran Thi B', 0, '1995-05-20', 1200, 1, 'b@gmail.com'),
('Le Minh C', 1, '1988-10-10', 2000, 2, 'c@gmail.com'),
('Pham Thi D', 0, '1992-12-05', 1800, 3, 'd@gmail.com');

INSERT INTO Project (project_name, emp_id, start_date, end_date)
VALUES
('Website Redesign', 1, '2024-01-01', '2024-06-01'),
('Recruitment System', 3, '2024-02-01', '2024-08-01'),
('Marketing Campaign', 4, '2024-03-01', NULL);

UPDATE Employee
SET salary = salary + '200'
WHERE dept_id = 1;

set sql_safe_updates = 0;
UPDATE Project
SET end_date = '2024-12-31'
WHERE end_date IS NULL;
set sql_safe_updates = 1;

