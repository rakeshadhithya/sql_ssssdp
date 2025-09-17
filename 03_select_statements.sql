
SET SQL_SAFE_UPDATES = 0;
SET SQL_SAFE_UPDATES = 1;

use ssssdp;

-- necessary for cleanup
show tables;
-- drop all tables shown


CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    gender CHAR(1),
    department VARCHAR(50),
    marks INT,
    city VARCHAR(50)
);
INSERT INTO Students (first_name,  age, gender, department, marks, city) VALUES
('Arjun', 20, 'M', 'Computer Science', 78, 'Hyderabad');
INSERT INTO Students (first_name, last_name, age, gender,  marks, city) VALUES
('Meena', 'Iyer', 21, 'F',  82, 'Chennai');
INSERT INTO Students (first_name, last_name, age, gender, department, marks, city) VALUES
('Arjun', 'Reddy', 20, 'M', 'Computer Science', 78, 'Hyderabad'),
('Meena', 'Iyer', 21, 'F', 'Electronics', 82, 'Chennai'),
('Vikas', 'Singh', 22, 'M', 'Mechanical', 55, 'Delhi'),
('Divya', 'Menon', 23, 'F', 'Civil', 68, 'Kochi'),
('Ravi', 'Kumar', 24, 'M', 'Computer Science', 88, 'Bangalore'),
('Anjali', 'Mishra', 22, 'F', 'Electronics', 92, 'Mumbai'),
('Suresh', 'Yadav', 21, 'M', 'Civil', 74, 'Jaipur'),
('Pooja', 'Rana', 20, 'F', 'Computer Science', 65, 'Lucknow'),
('Imran', 'Ali', 23, 'M', 'Mechanical', 81, 'Delhi'),
('Kavya', 'Shah', 22, 'F', 'Electronics', 59, 'Ahmedabad'),
('Rohit', 'Chopra', 21, 'M', 'Computer Science', 93, 'Delhi'),
('Sana', 'Khan', 20, 'F', 'Civil', 70, 'Hyderabad'),
('Manish', 'Tiwari', 24, 'M', 'Mechanical', 62, 'Kolkata'),
('Alok', 'Mishra', 22, 'M', 'Computer Science', 85, 'Pune'),
('Nisha', 'Roy', 23, 'F', 'Electronics', 77, 'Kolkata'),
('Deepak', 'Joshi', 21, 'M', 'Civil', 90, 'Lucknow'),
('Shreya', 'Kapoor', 22, 'F', 'Mechanical', 66, 'Chennai'),
('Gaurav', 'Sethi', 23, 'M', 'Computer Science', 72, 'Delhi'),
('Farhan', 'Qureshi', 24, 'M', 'Electronics', 83, 'Mumbai'),
('Ritika', 'Pillai', 21, 'F', 'Civil', 58, 'Bangalore');




/*
SELECT column1, column2, ...
FROM table_name

[WHERE condition]

[ORDER BY column ASC|DESC]
[LIMIT number_of_rows OFFSET offset_value];
*/





-- WITHOUT CONDITION

-- Show all columns from Students.
SELECT * FROM Students;

-- Show only first_name, last_name, marks.
SELECT last_name, marks,first_name  FROM Students;



-- CONDITION WHERE & Relational Operators: =, !=, <>, >, >=, <, <=
-- Students from Delhi
SELECT * FROM Students WHERE city = 'Delhi';
SELECT last_name, marks,first_name  FROM Students WHERE city = 'Delhi';

-- Students with marks greater than 80
SELECT first_name, marks FROM Students WHERE marks > 80;

-- Students not from Mumbai
SELECT first_name, city FROM Students 
WHERE city <> 'Mumbai';

-- Students with marks less than 50 
SELECT first_name, marks FROM Students 
WHERE marks < 50;






-- Comparision & Logical Operators
/*
IN = "choose from a list (,,)"

BETWEEN = "within a range"

LIKE = "pattern search (wildcard)"  (like is case insensitive, use == or != for case sensitive)

IS NULL = "blank / missing value"

NOT = "exclude this condition"

AND = "both conditions must be true"

OR = "any one is enough"

*/ 


-- IN
-- List students from (Bangalore, Chennai, Kolkata) using IN.
SELECT *
FROM Students
WHERE city IN ('Bangalore', 'Chennai', 'Kolkata');

-- Show students not from Mumbai or Delhi.
SELECT *
FROM Students
WHERE city NOT IN ('Mumbai', 'Delhi');

SELECT first_name, city
FROM Students
WHERE
city<>'Delhi' and city<> 'Mumbai' and city<> 'Hyderabad';

-- Students from those cities
SELECT first_name, city
FROM Students
WHERE city IN ('Delhi', 'Mumbai', 'Hyderabad');

-- Students not from Delhi, Mumbai, or Hyderabad, and order
SELECT first_name, city
FROM Students
WHERE city NOT IN ('Delhi', 'Mumbai', 'Hyderabad')
ORDER BY CITY;



-- BETWEEN 

-- Marks between 70 and 90
SELECT first_name, marks FROM Students 
WHERE marks BETWEEN 70 AND 90;

-- Marks outside 70–90
SELECT first_name, marks
FROM Students
WHERE marks NOT BETWEEN 70 AND 90;




-- LIKE

-- Find students whose first_name starts with ‘S’.
SELECT *
FROM Students
WHERE first_name LIKE 'S%';          -- case sensitive

-- Students NOT from Bangalore
SELECT first_name, city
FROM Students
WHERE  not city = 'Bangalore';      -- case insensitive


-- Students whose first name starts with 'N'
SELECT first_name FROM Students WHERE first_name LIKE 'N%';

-- Students whose last name ends with 'a'
SELECT last_name FROM Students WHERE last_name LIKE '%A';

-- Students whose first Names containing 'eh'
SELECT first_name FROM Students WHERE first_name LIKE '%eh%';

-- Last name does NOT end with 'a'
SELECT last_name
FROM Students
WHERE last_name NOT LIKE '%a';



-- IS NULL, IS NOT NULL

-- Students with a city value
SELECT first_name
FROM Students
WHERE last_name  IS  NOT NULL;

-- Students with not a city value
SELECT first_name, city
FROM Students
WHERE city IS NULL;




-- MULTIPLE OPERATORS 

-- Show students whose marks are between 70 and 90 (inclusive).
SELECT first_name, last_name, marks
FROM Students
WHERE marks BETWEEN 70 AND 90;

-- Students from Delhi AND marks > 80
SELECT first_name, city, marks
FROM Students
WHERE city = 'Delhi' AND marks > 80;

-- Students either from Mumbai OR with marks < 60
SELECT first_name, city, marks
FROM Students
WHERE city = 'Mumbai' OR marks < 60;

-- Show students from Delhi with marks > 80.
SELECT *
FROM Students
WHERE city = 'Delhi' AND marks > 80;


-- Female students in Computer Science
SELECT first_name, last_name FROM Students 
WHERE gender = 'F' AND department = 'Computer Science';

-- Female Computer Science students from Delhi or Mumbai with marks > 85
SELECT first_name, gender, department, city, marks
FROM Students
WHERE gender = 'F'
  AND department = 'Computer Science'
  AND city IN ('Delhi', 'Mumbai')
  AND marks > 85;

-- Students NOT from Electronics dept, age between 21 and 23, and marks < 70
SELECT first_name, department, age, marks
FROM Students
WHERE department <> 'Electronics'
  AND age BETWEEN 21 AND 23
  AND marks < 70;




-- DISTINCT 
-- List unique cities
SELECT DISTINCT city FROM Students;

-- Unique departments
SELECT DISTINCT department FROM Students;





-- ORDER BY LIMIT OFFSET

-- Sort by marks ascending
SELECT first_name, marks 
FROM Students 
ORDER BY marks ASC;  -- ASC is Optional

-- Sort by city, then by marks descending
SELECT first_name, city, marks FROM Students ORDER BY city, marks DESC;


-- Show first_name, city, marks sorted by marks DESC, then first_name ASC.
SELECT first_name, city, marks
FROM Students
ORDER BY marks DESC, first_name ASC;

-- Show top 3 students by marks.
SELECT first_name, last_name, marks
FROM Students
ORDER BY marks DESC
LIMIT 3;




-- AGGREGATE FUNCTIONS

-- Highest marks
SELECT MAX(marks) FROM Students;

-- Average marks
SELECT AVG(marks) FROM Students;

-- Count of students
SELECT COUNT(*) FROM Students;





-- GROUP BY (For unique columns, or aggregate remaining columns)

-- Group by department
SELECT department, AVG(marks) AS avg_marks 
FROM Students 
GROUP BY department;

-- For each department, show average marks (department + avg).
SELECT department, AVG(marks) AS avg_marks
FROM Students
GROUP BY department;

-- For each city, show the maximum marks in that city.
SELECT city, MAX(marks) AS max_marks
FROM Students
GROUP BY city;

-- Count how many students per city (city + count), highest count first.
SELECT city, COUNT(*) AS student_count
FROM Students
GROUP BY city
ORDER BY student_count DESC;

-- Show only those departments whose average marks ≥ 80.
SELECT department, AVG(marks) AS avg_marks
FROM Students
GROUP BY department
HAVING AVG(marks) >= 80;




-- Show department-wise gender split: department, total, females, males.
-- COUNT counts only non-null, does not consider value. SUM evaluates exp for each row and counts
SELECT
  department,
  COUNT(*)                             AS total_students,
  SUM(gender = 'F')                    AS females,
  SUM(gender = 'M')                    AS males
FROM Students
GROUP BY department;

/* Create a computed columns full_name = first + ' ' + last, and a grade:
A: marks ≥ 85
B: 70–84
C: 50–69
D: < 50
Return student_id, full_name, marks, grade.
*/

SELECT
  student_id,
  CONCAT(first_name, ' ', last_name)   AS full_name,
  marks,
  CASE
    WHEN marks >= 85 THEN 'A'
    WHEN marks BETWEEN 70 AND 84 THEN 'B'
    WHEN marks BETWEEN 50 AND 69 THEN 'C'
    ELSE 'D'
  END AS grade
FROM Students;


SELECT DISTINCT
    department,
    city,
    COUNT(*) AS student_count,
    AVG(marks) AS avg_marks,
    CASE
        WHEN AVG(marks) >= 85 THEN 'Excellent'
        WHEN AVG(marks) BETWEEN 70 AND 84 THEN 'Good'
        ELSE 'Needs Improvement'
    END AS performance_category
FROM Students
WHERE gender = 'F'              -- step 2: filter rows first
  AND marks > 60                -- only females with marks > 60
GROUP BY department, city        -- step 3: group into dept+city buckets
HAVING AVG(marks) >= 70          -- step 4: keep groups with avg ≥ 70
ORDER BY avg_marks DESC, city    -- step 7: sort by avg_marks, then city
LIMIT 5;                         -- step 8: return only top 5

