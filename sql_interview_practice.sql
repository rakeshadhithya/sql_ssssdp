
-- ============================================
-- SQL INTERVIEW PRACTICE KIT (MySQL)
-- ============================================
-- drop database Practice;
Create database Practice;

use Practice;


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
);

CREATE TABLE OrderDetails (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
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

-- ============================================
-- 3. INTERVIEW QUESTIONS (40+)
-- ============================================
-- A. DDL (5)
-- 1. Create a table Suppliers (supplier_id, supplier_name, city, state) with PK.
-- 2. Alter Products to add supplier_id column and FK reference.
-- 3. Drop stock column from Products.
-- 4. Rename status in Orders to order_status.
-- 5. Drop Suppliers table.

-- B. DML (5)
-- 6. Insert customer Rohit Singh from Pune.
-- 7. Update Nike Shoes price to 6500.
-- 8. Increase Sony Headphones stock by 10.
-- 9. Delete customer Priya Shah.
-- 10. Insert a shipped order for customer_id=2 today.

-- C. Basic SELECT (5)
-- 11. Get products costing more than 50,000.
-- 12. Customers signed up in 2023.
-- 13. Orders placed in July 2023.
-- 14. Customers from Mumbai or Delhi.
-- 15. Products with stock between 10 and 25.

-- D. Joins (5)
-- 16. Orders with customer name and order status.
-- 17. Products purchased by Arjun Mehta.
-- 18. Customers who never placed an order.
-- 19. Order_id, product_name, and quantity for each order.
-- 20. Customers and their total orders.

-- E. Aggregations (5)
-- 21. Total orders per city.
-- 22. Average order value.
-- 23. Top 3 products by sales revenue.
-- 24. Total quantity sold per category.
-- 25. Customers who spent more than 100000.

-- F. Windows (5)
-- 26. Rank customers by total spend.
-- 27. Rank products by revenue per category.
-- 28. Running total of sales by date.
-- 29. Average order value per customer vs overall average.
-- 30. Most recent order per customer.

-- G. Subqueries (5)
-- 31. Products priced above average.
-- 32. Customers with more than avg order count.
-- 33. Customer with max orders.
-- 34. Products never ordered.
-- 35. Customers who ordered Electronics.

-- H. Advanced / CASE (5)
-- 36. Categorize products into High, Medium, Low price.
-- 37. High Value (>50000) or Low Value orders.
-- 38. Monthly sales vs previous month (LAG).
-- 39. Percentage contribution of each product to revenue.
-- 40. Top 2 best-selling products in each category.
