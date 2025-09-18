use ssssdp;

show tables;
drop table employees;


create table emp (
emp_id VARCHAR(10),
dept_id VARCHAR(10)
);

create table dept(
dept_id VARCHAR(10),
dept_name VARCHAR(35)
);

insert into emp (emp_id,dept_id) values
('1','d1'),('12','d6'),
('2','d2'),('7','d9'),('13','d6'),
('3','d3'),('8','d10'),('14','d2'),
('4','d4'),('9','d1'),('15','d3'),
('5','d5'),('10','d2'),('16','d13'),
('6','d6'),('11','d3'),('17','d14'),
('18','d15'),('19','d8'),('20','d5');


INSERT INTO dept VALUES 
('d1','Marketing'),
('d2','Finance'),
('d3','Human Resources'),
('d4','Production'),
('d5','Development'),
('d6','Quality Management'),
('d7','Sales'),
('d8','Research'),
('d9','Customer Service'),
('d10','Analytics'),
('d11','Opertions'),
('d12','Talent Management');

select * from emp;
select * from Dept;


-- use as forein key in table which has more rows, use as primary key in table which has less rows
Select count(*) from emp;
select count(*) from dept;

select emp_id,e.dept_id,d.dept_id,dept_name 
from emp as e
inner join dept as d
on e.dept_id=d.dept_id;
/*
OUTPUT: rows with emp_id 17 and 18 are discarded
emp_id   dept_id   dept_id   dept_name
6	       d6	     d6   	 Quality Management
11	       d3	     d3	     Human Resources
19	       d8	     d8	     Research
*/

select * from emp as e
left join dept as d
on e.dept_id=d.dept_id;
/*
OUTPUT: any four columns
emp_id  dept_id  dept_id   Finance
6	      d6	   d6	   Quality Management
11	      d3	   d3	   Human Resources
17	      d14	   null    null	
18	      d15	   null    null
*/

select * from emp as e
right join dept as d
on e.dept_id=d.dept_id;
/*
OUTPUT: any 3 rows
emp_id   dept_id   dept_id   dept_name
8	      d10	    d10	     Analytics
null	  null	    d11	     Opertions
null      null 		d12	     Talent Management
*/

select count(*) from emp as e
cross join dept as d;
/*
OUTPUT: 
240      (cartesian product)
*/
