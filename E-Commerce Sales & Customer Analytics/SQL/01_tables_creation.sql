create database EcommerceAnalytics;
USE EcommerceAnalytics;
-- Table 1: Customer details
CREATE TABLE customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE,
    city VARCHAR(100),
    signup_date DATE
);

-- Table 2: Products sold in the store
CREATE TABLE products (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category VARCHAR(100),
    price DECIMAL(10,2) NOT NULL
        CHECK (price >= 0)
);

-- Table 3: Orders placed by customers
CREATE TABLE dbo.orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_status VARCHAR(30) NOT NULL,
    CONSTRAINT FK_orders_customers
        FOREIGN KEY (customer_id)
        REFERENCES dbo.customers(customer_id)
);
-- Table 4: Products included in each order
CREATE TABLE dbo.order_items (
    order_item_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL
        CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL
        CHECK (unit_price >= 0),

    CONSTRAINT FK_order_items_orders
        FOREIGN KEY (order_id)
        REFERENCES dbo.orders(order_id),

    CONSTRAINT FK_order_items_products
        FOREIGN KEY (product_id)
        REFERENCES dbo.products(product_id)
);
