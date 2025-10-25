-- DDL: CREATE, DROP, ALTER, TRUNCATE

-- CREATE, USE, DROP DATABASE
CREATE DATABASE IF NOT EXISTS ssssdp;

USE ssssdp;

-- CREATE, DROP TABLE IN DATABSE (NO USE for TABLE)
CREATE TABLE employees (
    emp_no      INT,
    emp_sal     DECIMAL(10,3),      -- max 10 digits before point allowed, and truncated to 3 digits after decimal point
    birth_date  DATE,
    first_name  VARCHAR(14),        -- varchar: variable length with max 14 chars
    last_name   VARCHAR(16),
    gender      CHAR(1),            -- char: fixed length, if less fills with spaces
    hire_date   DATE
);
drop table employees;


-- NAME, DATATYPE AND CONSTRAINTS
-- common datatypes: int, decimal, chr(), varchr(), date
-- common constraints: not null, unique, check, primary key, foreign key
CREATE TABLE employees (
    emp_no      INT             NOT NULL ,
    birth_date  DATE            NOT NULL,
    first_name  VARCHAR(14)     NOT NULL,
    last_name   VARCHAR(16)     NOT NULL,
    gender      char(1)         NOT NULL,    
    hire_date   DATE            NOT NULL
);

DROP TABLE employees;

CREATE TABLE employees (
    emp_no      INT             NOT NULL PRIMARY KEY,
    birth_date  DATE            NOT NULL,
    first_name  VARCHAR(14)     NOT NULL,
    last_name   VARCHAR(16)     NOT NULL,
    gender      CHAR(1)         NOT NULL,
    hire_date   DATE            NOT NULL
);

DROP TABLE employees;

-- compound key/ composite key: two or more columns are used to uniquely identify each record 
CREATE TABLE employees (
    emp_no      INT             NOT NULL,
    emp_id      INT             NOT NULL,
    birth_date  DATE            NOT NULL,
    first_name  VARCHAR(14)     NOT NULL,
    last_name   VARCHAR(16)     NOT NULL,
    gender      CHAR(1)         NOT NULL CHECK (gender IN ('M', 'F')),
    hire_date   DATE            NOT NULL
    PRIMARY KEY(emp_no, emp_id)
);

DROP TABLE employees;






-- CONSTRAINT FOREIGN KEY (as the last column)

CREATE TABLE departments (
    dept_no     INT PRIMARY KEY,
    dept_name   VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE employees (
    emp_no      INT PRIMARY KEY,
    birth_date  DATE NOT NULL,
    first_name  VARCHAR(14) NOT NULL,
    last_name   VARCHAR(16) NOT NULL,
    gender      CHAR(1) NOT NULL CHECK (gender IN ('M', 'F')),
    hire_date   DATE NOT NULL,
    dept_no     INT,
    CONSTRAINT fk_dept FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

INSERT INTO departments (dept_no, dept_name) 
VALUES (1, 'Human Resources'), 
       (2, 'Finance'), 
       (3, 'IT');
       
 INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date, dept_no)
VALUES (101, '1990-01-01', 'Arun', 'Vasa', 'M', '2020-05-01', 3),
       (102, '1992-03-10', 'Anita', 'Shah', 'F', '2021-06-01', 2);      



-- BENEFITS OF FOREIGN KEY
       
-- Fails because, foreign key 11 is not present in departments table
INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date, dept_no)
VALUES (103, '1991-07-15', 'John', 'Doe', 'M', '2022-08-01', 11);       

-- parent table: the one with primary key, child table the one with foreign key
select * from employees;     -- child table
select * from departments;   -- parent table
-- without cascade, cannot delete or update parent row: foreign key constraint fail when that value is present in child table
DELETE FROM departments WHERE dept_no = 2;

drop table employees;
drop table departments;
CREATE TABLE departments (
    dept_no     INT PRIMARY KEY,
    dept_name   VARCHAR(50) NOT NULL UNIQUE
);
-- now create employees table with forein key constraint as cascade, so when changes in parent table automatically reflect in child table
CREATE TABLE employees (
    emp_no      INT PRIMARY KEY,
    birth_date  DATE NOT NULL,
    first_name  VARCHAR(14) NOT NULL,
    last_name   VARCHAR(16) NOT NULL,
    gender      CHAR(1) NOT NULL CHECK (gender IN ('M', 'F')),
    hire_date   DATE NOT NULL,
    dept_no     INT,
    CONSTRAINT fk_dept FOREIGN KEY (dept_no) 
        REFERENCES departments(dept_no)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO departments (dept_no, dept_name) 
VALUES (1, 'Human Resources'), 
       (2, 'Finance'), 
       (3, 'IT');
 INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date, dept_no)
VALUES (101, '1990-01-01', 'Arun', 'Vasa', 'M', '2020-05-01', 3),
       (102, '1992-03-10', 'Anita', 'Shah', 'F', '2021-06-01', 2);  
       
select * from employees;
select * from departments;
-- now this works, it deletes rows in child table with foreign key value as this
DELETE FROM departments WHERE dept_no = 2;





/*
ALTER DATABASE → properties of a database (charset, collation, some options).
ALTER TABLE → columns, indexes, constraints, name&default.
*/


-- ALTER COLUMN: ALTER (table) ADD/DROP/MODIFY/CHANGE column (RENAME can be used for columns from 8.0+)
-- ADD: new, DROP: remove, MODIFY: type constraint, CHANGE: name, type & constriant

-- Add a new column to departments
ALTER TABLE departments ADD location VARCHAR(50);

-- Add a new column to employees
ALTER TABLE employees ADD salary DECIMAL(10,2);

-- Remove emp_salary column
ALTER TABLE employees DROP COLUMN emp_salary;

-- Change dept_name size from 50 → 100
ALTER TABLE departments MODIFY dept_name VARCHAR(100);

-- Change salary from DECIMAL(10,2) → DECIMAL(12,2)
ALTER TABLE employees MODIFY salary DECIMAL(12,2);

-- Rename location → dept_location
ALTER TABLE departments CHANGE location dept_location VARCHAR(50);

-- Rename salary → emp_salary
ALTER TABLE employees CHANGE salary emp_salary DECIMAL(12,2);



-- ALTER CONSTRAINT & INDEX: ADD/DROP CONSTRAINT or INDEX NAME TYPE(column) 
-- No MODIFY/CHANGE for index & constraint, drop and re-add


-- Add index
ALTER TABLE table_name ADD INDEX index_name (column_name);

-- Drop index
ALTER TABLE departments DROP INDEX index_name;


-- Add UNIQUE constraint to dept_name
ALTER TABLE departments ADD CONSTRAINT unique_dept UNIQUE (dept_name);

-- Drop unique constraint (drop index for constraint works only in mysql/maria)
ALTER TABLE departments DROP INDEX unique_dept;

-- Add CHECK constraint to ensure salary > 0
ALTER TABLE employees ADD CONSTRAINT chk_salary CHECK (emp_salary > 0);

-- Drop check constraint, both ways find
ALTER TABLE employees DROP CHECK chk_salary;
ALTER TABLE employees DROP CONSTRAINT chk_salary;

-- add forigen key
ALTER TABLE employees 
ADD CONSTRAINT fk_dept FOREIGN KEY (dept_no) 
REFERENCES departments(dept_no)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- drop forigen key, both ways fine
ALTER TABLE employees DROP FOREIGN KEY fk_dept;
ALTER TABLE employees DROP CONSTRAINT fk_dept;



-- ALTER TABLE: RENAME, ALTER SET/DROP DEFAULT
-- Rename departments to company_departments
ALTER TABLE departments RENAME TO company_departments;

-- Rename employees to company_employees
ALTER TABLE employees RENAME TO company_employees;

-- Set default hire_date as today
ALTER TABLE employees ALTER hire_date SET DEFAULT (CURRENT_DATE);

-- Remove default
ALTER TABLE employees ALTER hire_date DROP DEFAULT;

-- Drop the employees table
DROP TABLE employees;

-- Drop the departments table
DROP TABLE departments;



-- TRUNCATE
-- Now truncate
TRUNCATE TABLE employees;