-- WINDOWS with single table without group

use ssssdp;
show tables;
drop view highvalueproducts;
drop table products;

-- Create the salesdata table
CREATE TABLE salesdata (
    saleid INT PRIMARY KEY,
    salesperson VARCHAR(50),
    saleamount DECIMAL(10, 2),
    saledate DATE
);

-- Insert 20 records into the salesdata table
INSERT INTO salesdata (saleid, salesperson, saleamount, saledate) VALUES
(1, 'Alice', 1500.50, '2025-01-01'),
(2, 'Bob', 2300.75, '2025-01-02'),
(3, 'Charlie', 1800.00, '2025-01-03'),
(4, 'Alice', 2200.25, '2025-01-04'),
(5, 'Bob', 1900.60, '2025-01-05'),
(6, 'Charlie', 2500.00, '2025-01-06'),
(7, 'Alice', 1700.30, '2025-01-07'),
(8, 'Bob', 2100.45, '2025-01-08'),
(9, 'Charlie', 2000.10, '2025-01-09'),
(10, 'Alice', 2400.80, '2025-01-10'),
(11, 'Bob', 1600.90, '2025-01-11'),
(12, 'Charlie', 2300.20, '2025-01-12'),
(13, 'Alice', 1900.15, '2025-01-13'),
(14, 'Bob', 2600.35, '2025-01-14'),
(15, 'Charlie', 2100.70, '2025-01-15'),
(16, 'Alice', 1800.40, '2025-01-16'),
(17, 'Bob', 2000.25, '2025-01-17'),
(18, 'Charlie', 2700.50, '2025-01-18'),
(19, 'Alice', 2200.60, '2025-01-19'),
(20, 'Bob', 2400.00, '2025-01-20');



-- salesdata(saleid, salesperson,saleamount,saledate)

-- lag/lead with self join 
select s1.*,s2.* 
from salesdata  as s1
left join salesdata as s2 on 
s1.saledate=(s2.saledate-1);      -- s1 date + 1 = s2 date i.e. LEAD on right by 1 date

select s1.*,s2.* from salesdata  as s1
left join salesdata as s2 on 
s1.saledate=(s2.saledate+1);      -- s1 date - 1 = s2 date i.e. LAG on right by 1 date


-- lead lag by salesperson   (lag/lead of which column and by how much)
select saleid,salesperson,saleamount,saledate,
lead(saleamount,1) over (order by salesperson) as lead_1,
lead(saleamount,2) over (order by salesperson) as lead_1,
lag(saleamount,1) over (order by salesperson) as lag_1,
lag(saleamount,2) over (order by salesperson) as lag_2
from salesdata;


-- lead lag by salesperson (within the salesperson)
select saleid,salesperson,saleamount,saledate,
lead(saleamount,1) over (partition by salesperson  order by saledate) as lead_1,
lead(saleamount,2) over (partition by salesperson order by saledate) as lead_1,
lag(saleamount,1) over (partition by salesperson order by saledate) as lag_1,
lag(saleamount,2) over (partition by salesperson order by saledate) as lag_2
from salesdata;



-- row number by order
select saleid,salesperson,saleamount,saledate,
row_number() over (order by Saledate) as num
from salesdata;

-- row number within a partition and by order
select saleid,salesperson,saleamount,saledate,
row_number() over (partition by  salesperson order by Saledate) as num
from salesdata;

-- rn, rnk, drnk on different cols
select saleid,salesperson,saleamount,saledate,
row_number() over (partition by  salesperson order by Saledate) as num,
rank() over ( order by Saledate) as rank_c,
dense_rank() over (order by saleamount) as numrank
from salesdata;

-- dense rank
select saleid,salesperson,saleamount,saledate, 
rank() over ( order by saleamount) as rank1,           -- skips rank
dense_rank() over ( order by saleamount) as denserank  -- does not skip rank
from salesdata;


-- cumulative sum 
select saleid,salesperson,saleamount,saledate,
sum(saleamount) over (order by saledate) as CumSum
from salesdata;

-- moving average
select saleid,salesperson,saleamount,saledate,
-- inclue curr row + 1 preceding row and 1 following row
avg(saleamount) over (order by saledate rows between 1 preceding and 1 following) as MovingAverage
from salesdata;


-- union
select saleamount from salesdata where salesperson='Alice'
union 
select saleamount from salesdata where salesperson='Bob';

select * from salesdata where salesperson='Bob'
union                                                 -- no duplicate rows(saleid is unique)
select * from salesdata where salesperson='Bob'
order by saleid;

select * from salesdata where salesperson='Bob'
union all                                              -- keeps duplicates
select * from salesdata where salesperson='Bob'
order by saleid;
