/*
Project: E-Commerce Sales & Customer Analytics
File: 03_data_quality_checks.sql

Purpose:
Check whether our sample data has common quality issues.
These queries report problems without changing the data.
*/

USE EcommerceAnalytics;
GO

-- 1. Check for missing customer information
SELECT *
FROM dbo.customers
WHERE customer_name IS NULL
   OR email IS NULL
   OR signup_date IS NULL;
GO

-- 2. Check for missing product information
SELECT *
FROM dbo.products
WHERE product_name IS NULL
   OR price IS NULL;
GO

-- 3. Check for missing order information
SELECT *
FROM dbo.orders
WHERE customer_id IS NULL
   OR order_date IS NULL
   OR order_status IS NULL;
GO

-- 4. Check for duplicate customer emails
SELECT email, COUNT(*) AS duplicate_count
FROM dbo.customers
WHERE email IS NOT NULL
GROUP BY email
HAVING COUNT(*) > 1;
GO

-- 5. Check for duplicate product names
SELECT product_name, COUNT(*) AS duplicate_count
FROM dbo.products
GROUP BY product_name
HAVING COUNT(*) > 1;
GO

-- 6. Check for duplicate products within an order
SELECT order_id, product_id,
       COUNT(*) AS duplicate_count
FROM dbo.order_items
GROUP BY order_id, product_id
HAVING COUNT(*) > 1;
GO

-- 7. Find orders with no matching customer
SELECT o.*
FROM dbo.orders AS o
LEFT JOIN dbo.customers AS c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;
GO

-- 8. Find order items with no matching order
SELECT oi.*
FROM dbo.order_items AS oi
LEFT JOIN dbo.orders AS o
    ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;
GO

-- 9. Find order items with no matching product
SELECT oi.*
FROM dbo.order_items AS oi
LEFT JOIN dbo.products AS p
    ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;
GO

-- 10. Check for invalid prices or quantities
SELECT *
FROM dbo.products
WHERE price < 0;

SELECT *
FROM dbo.order_items
WHERE quantity <= 0
   OR unit_price < 0;
GO

-- 11. Check for unexpected order statuses
SELECT DISTINCT order_status
FROM dbo.orders
WHERE order_status NOT IN
    ('Delivered', 'Cancelled', 'Pending');
GO
