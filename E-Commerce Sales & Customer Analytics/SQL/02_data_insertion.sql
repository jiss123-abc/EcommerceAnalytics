/*
Project: E-Commerce Sales & Customer Analytics
File: 02_insert_sample_data.sql
*/

-- Add sample customers
INSERT INTO dbo.customers(customer_name, email, city, signup_date)
VALUES
('Aarav Sharma', 'aarav.sharma@example.com', 'Mumbai', '2025-01-10'),
('Diya Patel', 'diya.patel@example.com', 'Ahmedabad', '2025-01-18'),
('Arjun Nair', 'arjun.nair@example.com', 'Kochi', '2025-02-05'),
('Ananya Reddy', 'ananya.reddy@example.com', 'Hyderabad', '2025-02-21'),
('Rohan Mehta', 'rohan.mehta@example.com', 'Pune', '2025-03-03'),
('Ishita Singh', 'ishita.singh@example.com', 'Delhi', '2025-03-15'),
('Kabir Das', 'kabir.das@example.com', 'Kolkata', '2025-04-01'),
('Meera Iyer', 'meera.iyer@example.com', 'Chennai', '2025-04-12'),
('Vivaan Joshi', 'vivaan.joshi@example.com', 'Bengaluru', '2025-05-08'),
('Sara Thomas', 'sara.thomas@example.com', 'Thiruvananthapuram', '2025-05-20');

-- Add the products available in the store
INSERT INTO dbo.products(product_name, category, price)
VALUES
('Laptop', 'Electronics', 65000.00),
('Smartphone', 'Electronics', 28000.00),
('Wireless Mouse', 'Accessories', 850.00),
('Mechanical Keyboard', 'Accessories', 3200.00),
('Monitor', 'Electronics', 14500.00),
('Headphones', 'Accessories', 2200.00),
('Office Chair', 'Furniture', 7800.00),
('Study Desk', 'Furniture', 9500.00),
('USB-C Hub', 'Accessories', 1800.00),
('External SSD', 'Electronics', 6500.00),
('Webcam', 'Electronics', 3500.00),
('Laptop Stand', 'Accessories', 1200.00);

-- Add orders placed by the customers
INSERT INTO dbo.orders(customer_id, order_date, order_status)
VALUES
(1, '2025-01-15', 'Delivered'),
(2, '2025-01-20', 'Delivered'),
(3, '2025-02-10', 'Delivered'),
(1, '2025-02-18', 'Delivered'),
(4, '2025-02-25', 'Cancelled'),
(5, '2025-03-05', 'Delivered'),
(6, '2025-03-12', 'Delivered'),
(2, '2025-03-20', 'Delivered'),
(7, '2025-04-04', 'Delivered'),
(8, '2025-04-15', 'Pending'),
(3, '2025-04-22', 'Delivered'),
(9, '2025-05-10', 'Delivered'),
(10, '2025-05-18', 'Delivered'),
(1, '2025-05-25', 'Delivered'),
(4, '2025-06-02', 'Delivered'),
(5, '2025-06-12', 'Cancelled'),
(6, '2025-06-20', 'Delivered'),
(7, '2025-07-05', 'Delivered'),
(8, '2025-07-15', 'Delivered'),
(9, '2025-07-25', 'Delivered');
