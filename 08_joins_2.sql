use ssssdp;

show tables;
drop table dept;
drop table emp;


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
('18','d15'),('19','d8'),('20','d5'),
('19','d8'),('20','d5'),('11','d3'),('17','d14');


INSERT INTO dept VALUES 
('d1','Marketing'),
('d2','Finance'),
('d3','Human Resources'),
('d3','Human Resources'),
('d4','Production'),
('d5','Development'),
('d5','Development'),
('d6','Quality Management'),
('d7','Sales'),
('d8','Research'),
('d8','Research'),
('d9','Customer Service'),
('d10','Analytics'),
('d11','Opertions'),
('d12','Talent Management');

select * from emp;
select * from dept;


select count(*) from emp as e
inner join dept as d
on e.dept_id=d.dept_id;
/*
OUTPUT:
count(*)
29
*/

select count(*) from emp as e
left join dept as d
on e.dept_id=d.dept_id;
/*
OUTPUT:
count(*)
33
*/

select count(*) from emp as e
right join dept as d
on e.dept_id=d.dept_id;
/*
OUTPUT:
count(*)
32
*/

select count(*) from emp as e
cross join dept as d;
/*
OUTPUT:
count(*)
360
*/