
-- ============================================
-- SQL INTERVIEW PRACTICE KIT (MySQL)
-- ============================================
SET SQL_SAFE_UPDATES = 0;

USE ssssdp;
SHOW TABLES;
DROP TABLE sales;
DROP TABLE employees;
DROP TABLE departments;
DROP TABLE projects;


-- ===============================================
-- Drop tables if exist
DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;


-- ============================================
-- 1. CREATE TABLES (DDL)
-- ============================================

CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    city VARCHAR(50),
    state VARCHAR(50),
    signup_date DATE
);

CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock INT
);

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE OrderDetails (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- ============================================
-- 2. INSERT DATA
-- ============================================

-- Customers
INSERT INTO Customers (first_name, last_name, email, city, state, signup_date) VALUES
('Arjun','Mehta','arjun.mehta@gmail.com','Mumbai','MH','2023-01-10'),
('Sneha','Patel','sneha.patel@gmail.com','Delhi','DL','2023-02-12'),
('Ravi','Kumar','ravi.kumar@gmail.com','Bangalore','KA','2022-11-05'),
('Priya','Shah','priya.shah@gmail.com','Ahmedabad','GJ','2023-03-20'),
('Vikram','Rao','vikram.rao@gmail.com','Hyderabad','TS','2022-12-15'),
('Rohit','Singh','rohit.singh@gmail.com','Pune','MH','2023-07-21'),
('Neha','Verma','neha.verma@gmail.com','Chennai','TN','2023-01-25'),
('Karan','Gupta','karan.gupta@gmail.com','Kolkata','WB','2022-09-12'),
('Aditi','Joshi','aditi.joshi@gmail.com','Jaipur','RJ','2023-02-01'),
('Anil','Nair','anil.nair@gmail.com','Kochi','KL','2023-03-10'),
('Meera','Reddy','meera.reddy@gmail.com','Hyderabad','TS','2022-10-15'),
('Suresh','Yadav','suresh.yadav@gmail.com','Lucknow','UP','2023-04-11'),
('Pooja','Mishra','pooja.mishra@gmail.com','Delhi','DL','2022-11-22'),
('Deepak','Sharma','deepak.sharma@gmail.com','Mumbai','MH','2023-01-18'),
('Alok','Chatterjee','alok.chatterjee@gmail.com','Kolkata','WB','2023-06-05'),
('Manoj','Bansal','manoj.bansal@gmail.com','Indore','MP','2022-08-25'),
('Ramesh','Pillai','ramesh.pillai@gmail.com','Chennai','TN','2023-03-30'),
('Swati','Kapoor','swati.kapoor@gmail.com','Delhi','DL','2023-07-02'),
('Aman','Jain','aman.jain@gmail.com','Jaipur','RJ','2023-05-16'),
('Sunita','Iyer','sunita.iyer@gmail.com','Bangalore','KA','2023-04-25');

-- Products
INSERT INTO Products (product_name, category, price, stock) VALUES
('iPhone 14','Electronics',80000,15),
('Samsung Galaxy S23','Electronics',75000,20),
('Sony Headphones','Accessories',5000,40),
('HP Laptop','Electronics',60000,10),
('Wooden Chair','Furniture',3500,25),
('Nike Shoes','Fashion',6000,30),
('Adidas Sneakers','Fashion',5500,25),
('Office Desk','Furniture',12000,12),
('Dell Laptop','Electronics',58000,18),
('MacBook Air','Electronics',95000,8),
('Boat Earbuds','Accessories',3000,50),
('Apple Watch','Electronics',30000,14),
('Leather Wallet','Fashion',2000,45),
('Dining Table','Furniture',25000,6),
('LG Monitor','Electronics',15000,22);

-- Orders
INSERT INTO Orders (customer_id, order_date, status) VALUES
(1,'2023-07-01','Shipped'),
(2,'2023-07-02','Pending'),
(1,'2023-07-10','Delivered'),
(3,'2023-07-11','Cancelled'),
(4,'2023-07-15','Delivered'),
(5,'2023-07-20','Shipped'),
(6,'2023-08-01','Delivered'),
(7,'2023-08-05','Shipped'),
(8,'2023-08-06','Pending'),
(9,'2023-08-10','Delivered'),
(10,'2023-08-12','Delivered'),
(11,'2023-08-15','Shipped'),
(12,'2023-08-18','Cancelled'),
(13,'2023-08-20','Delivered'),
(14,'2023-08-22','Delivered'),
(15,'2023-08-25','Pending'),
(16,'2023-08-28','Shipped'),
(17,'2023-08-29','Delivered'),
(18,'2023-09-01','Delivered'),
(19,'2023-09-02','Pending'),
(20,'2023-09-03','Shipped'),
(3,'2023-09-04','Delivered'),
(4,'2023-09-05','Delivered'),
(5,'2023-09-06','Pending'),
(6,'2023-09-07','Shipped'),
(7,'2023-09-08','Delivered'),
(8,'2023-09-09','Cancelled'),
(9,'2023-09-10','Delivered'),
(10,'2023-09-11','Shipped'),
(11,'2023-09-12','Delivered');

-- OrderDetails
INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES
(1,1,1),(1,3,2),
(2,2,1),
(3,4,1),(3,5,2),
(4,6,1),
(5,1,1),
(6,2,2),(6,3,1),
(7,7,1),(7,11,2),
(8,9,1),
(9,10,1),
(10,12,1),(10,13,2),
(11,14,1),
(12,6,1),
(13,8,1),
(14,1,1),(14,3,1),
(15,2,1),(15,5,3),
(16,6,1),(16,7,2),
(17,4,1),
(18,15,2),
(19,9,1),(19,13,2),
(20,10,1),(20,12,1),
(21,2,1),(21,3,1),
(22,14,1),
(23,8,2),(23,6,1),
(24,1,1),
(25,5,2),(25,11,1),
(26,7,1),
(27,4,1),(27,15,1),
(28,9,1),(28,13,1),
(29,10,1),
(30,12,2),(30,3,1);

SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM orderdetails;
SELECT COUNT(*) FROM products;



-- ============================================
-- 3. INTERVIEW QUESTIONS (40+)
-- ============================================
-- A. DDL (5)
-- 1. Create a table Suppliers (supplier_id, supplier_name, city, state) with PK.
CREATE TABLE suppliers(
	supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50)
);

-- 2. Alter Products to add supplier_id column and FK reference.
ALTER TABLE Products 
ADD COLUMN supplier_id INT;

ALTER TABLE Products 
ADD CONSTRAINT fk_supplier
FOREIGN KEY(supplier_id) 
REFERENCES Suppliers(supplier_id);


-- 3. Drop stock column from Products.
ALTER TABLE Products DROP COLUMN stock;
/*Truncate and reenter data for Products*/
TRUNCATE Products;

-- 4. Rename status in Orders to order_status.
ALTER TABLE Orders CHANGE status order_status VARCHAR(20);
-- 5. Drop Suppliers table.
ALTER TABLE Products DROP CONSTRAINT fk_supplier;
DROP TABLE Suppliers;



-- B. DML (5)
-- 6. Insert customer Rohit Singh from Pune.
INSERT INTO Customers(first_name, last_name, city, state, signup_date)
VALUES ('Rohit', 'Singh', 'Pune', 'Maharashtra', DATE(NOW()));

-- 7. Update Nike Shoes price to 6500.
SELECT * FROM Products;
UPDATE Products
SET price = 6500 
WHERE product_name = 'Nike Shoes';

-- 8. Increase Sony Headphones stock by 10.
SELECT * FROM Products;
-- 9. Delete customer Priya Shah.
DELETE FROM Customers 
WHERE first_name LIKE 'Priya' AND last_name LIKE 'Shah';
-- 10. Insert a shipped order for customer_id=2 today.
SELECT * FROM Orders;
INSERT INTO Orders(customer_id, order_date, status)
VALUES (2, DATE(NOW()), 'Pending');




-- C. Basic SELECT (5)
-- 11. Get products costing more than 50,000.
SELECT * FROM Products
WHERE price > 50000;

-- 12. Customers signed up in 2023.
SELECT * FROM Customers
WHERE YEAR(signup_date) = 2023;

-- 13. Orders placed in July 2023.
SELECT * FROM Orders
WHERE MONTH(order_date) = 7 AND YEAR(order_date) = 2023;

-- 14. Customers from Mumbai or Delhi.
SELECT * FROM Customers
WHERE CITY IN ('Mumbai', 'Delhi');

-- 15. Products with stock between 10 and 25.
SELECT * FROM Products
WHERE stock BETWEEN 10 AND 25;




-- D. Joins (5)
-- 16. Orders with customer name and order status.
SELECT CONCAT(c.first_name,' ', c.last_name) AS name, o.status
FROM Customers c 
JOIN Orders o ON c.customer_id = o.customer_id;

-- 17. Products purchased by Arjun Mehta.
SELECT CONCAT(c.first_name,' ', c.last_name) AS name, p.product_name AS product_name
FROM Customers c
JOIN Orders o On c.customer_id = o.customer_id
JOIN OrderDetails od On o.order_id = od.order_id
JOIN Products p On od.product_id = p.product_id
WHERE c.first_name LIKE 'Arjun' AND c.last_name LIKE 'Mehta';

-- 18. Customers who never placed an order.
SELECT CONCAT(c.first_name, c.last_name) AS name
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 19. Order_id, product_name, and quantity for each order.
SELECT o.order_id, p.product_name, od.quantity
FROM Orders o 
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Products p On od.product_id = od.product_id;
 
-- 20. Customers and their total orders.
SELECT c.customer_id, CONCAT(c.first_name, c.last_name) AS name, COUNT(o.order_id) AS total_orders
FROM Customers c 
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, name;



-- E. Aggregations (5)
-- 21. Total orders per city.
SELECT c.city, COUNT(o.order_id)
FROM Customers c 
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.city;

-- 22. Average order value.
SELECT SUM(per_order_value) / COUNT(order_id) AS avg_order_val   -- you can simply take avg() instead of sum() and count()
FROM
(
	SELECT o.order_id, SUM(od.quantity * p.price) AS per_order_value
	FROM Orders o
    JOIN OrderDetails od ON o.order_id = od.order_id
    JOIN Products p ON od.product_id = p.product_id
    GROUP BY o.order_id
) AS order_values;
  
-- 23. Top 3 products by sales revenue.
SELECT p.product_id, p.product_name, SUM(p.price * od.quantity) AS sale_revenue
FROM Products p
JOIN OrderDetails od ON p.product_id = od.product_id
GROUP BY p.product_id, p.product_name
ORDER BY sale_revenue DESC
LIMIT 3;

-- 24. Total quantity sold per category.
SELECT p.category, SUM(od.quantity) AS total_quantity
FROM Products p 
JOIN OrderDetails od ON p.product_id = od.product_id
GROUP BY p.category;

-- 25. Customers who spent more than 100000.
SELECT CONCAT(c.first_name, ' ', c.last_name) AS name,
	   SUM(p.price * od.quantity) AS expenditure
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id
GROUP BY c.customer_id                                     -- don't group by name, as people have same names
HAVING SUM(p.price * od.quantity) > 100000;


-- F. Windows (5)
-- 26. Rank customers by total spend.
SELECT c.customer_id,
	   SUM(od.quantity * p.price) AS expenditure,
       RANK() OVER (ORDER BY SUM(od.quantity * p.price) DESC) AS rnk
FROM Customers c 
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Products p On od.product_id = p.product_id
GROUP BY c.customer_id;

-- 27. Rank products by revenue per category.
SELECT p.product_id,
	   p.product_name,
	   p.category,
	   SUM(od.quantity * p.price) AS revenue,
       RANK() OVER (PARTITION BY p.category ORDER BY SUM(od.quantity * p.price) DESC) AS rnk
FROM OrderDetails od
JOIN Products p ON od.product_id = p.product_id
GROUP BY p.product_id, p.product_name, p.category;

-- 28. Running total of sales by date.
SELECT o.order_date,
	   SUM(od.quantity * p.price) AS sale,
       SUM(SUM(od.quantity * p.price)) OVER(ORDER BY o.order_date) AS running_total
FROM Orders o 
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id
GROUP BY o.order_date;

-- 29. Average order value per customer vs overall average.
SELECT DISTINCT
	c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS name,
    AVG(SUM(od.quantity * p.price)) OVER (PARTITION BY c.customer_id) AS customer_avg,
    AVG(SUM(od.quantity * p.price)) OVER () overall_avg
FROM Customers c 
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id
GROUP BY c.customer_id, CONCAT(c.first_name, ' ', c.last_name), o.order_id;

-- 30. Most recent order per customer.
SELECT 
	customer_id,
    order_id,
    order_date
FROM 
(
	SELECT 
		c.customer_id,
        o.order_id,
        o.order_date,
        RANK() OVER(PARTITION BY c.customer_id ORDER BY o.order_date DESC) AS rnk
	FROM Customers c
    JOIN Orders o ON c.customer_id = o.customer_id
) AS customer_orders
WHERE customer_orders.rnk = 1;





-- G. Subqueries (5)
-- 31. Products priced above average.
SELECT p.product_id, p.product_name
FROM Products p 
WHERE p.price > 
(
	SELECT AVG(pp.price) 
    FROM Products pp
);

-- 32. Customers with more than avg order count.
SELECT c.customer_id, COUNT(o.order_id) AS order_count
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING COUNT(o.order_id) >
(
	SELECT AVG(total_orders) 
    FROM 
    (
		SELECT COUNT(order_id) AS total_orders
        FROM Orders
        GROUP BY customer_id
	) AS orders_per_customer
);

-- 33. Customer with max orders.
SELECT c.customer_id, COUNT(o.order_id) AS orders
FROM Customers c 
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING COUNT(o.order_id) =
(
	SELECT MAX(total_orders)
    FROM
    (
		SELECT COUNT(order_id) AS total_orders
        FROM Orders
        GROUP BY customer_id
	) AS orders_per_customer
);
-- 34. Products never ordered.
SELECT
	p.product_id,
    p.product_name
FROM Products p 
WHERE p.product_id NOT IN 
(
	SELECT product_id
    FROM OrderDetails 
);
-- with join
SELECT 
	p.product_id,
	p.product_name
FROM Products p
LEFT JOIN OrderDetails od ON p.product_id = od.product_id
WHERE od.product_id IS NULL;

-- 35. Customers who ordered Electronics.
SELECT DISTINCT
	c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS name
FROM Customers c 
WHERE c.customer_id IN
(
	SELECT o.customer_id 
    FROM Orders o
    JOIN OrderDetails od On o.order_id = od.order_id
    JOIN Products p On od.product_id = p.product_id
    WHERE p.category = 'Electronics'
)
ORDER BY c.customer_id
;
-- with join
SELECT DISTINCT
	c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS name
FROM Customers c 
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id
WHERE p.category = 'Electronics'
ORDER BY c.customer_id;




-- H. Advanced / CASE (5)
-- 36. Categorize products into High, Medium, Low price.
-- 37. High Value (>50000) or Low Value orders.
-- 38. Monthly sales vs previous month (LAG).
-- 39. Percentage contribution of each product to revenue.
-- 40. Top 2 best-selling products in each category.
