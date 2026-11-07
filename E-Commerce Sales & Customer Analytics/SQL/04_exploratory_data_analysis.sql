-- Step 4.1: Order Status Counts
-- Purpose: Count delivered, cancelled, and total orders
-- to understand the overall distribution of order statuses.
select count(distinct case when order_status='Delivered' then order_id end) as 'delivered orders',
count(distinct case when order_status='Cancelled' then order_id end) as 'cancelled orders',
count(distinct order_id) as total_orders
from orders 

-- Step 4.2: Overall Sales Performance
-- Purpose: Calculate total orders by status and total revenue
-- from delivered orders to evaluate overall sales performance.
select count(distinct oi.order_id) as total_orders,count(distinct case when o.order_status='Delivered' then o.order_id end) as 'delivered_orders',
count(distinct case when o.order_status='Cancelled' then o.order_id end) as 'cancelled_orders',
count(distinct case when o.order_status='Pending' then o.order_id end) as 'pending_orders',
sum(case when o.order_status='Delivered' then oi.unit_price * oi.quantity end) as delivered_revenue from order_items oi 
join orders o on o.order_id=oi.order_id 

-- Step 4.3: Monthly Revenue Analysis
-- Purpose: Calculate monthly revenue and the number of delivered orders
-- to identify sales trends over time.
select year(o.order_date) as sales_year,month(o.order_date) as sales_month,count(distinct o.order_id) as delivered_orders,
sum(case when o.order_status='Delivered' then oi.quantity*oi.unit_price end) as delivered_revenue 
from orders o join order_items oi on oi.order_id=o.order_id where o.order_status='Delivered' 
group by year(o.order_date),month(o.order_date) order by year(o.order_date),month(o.order_date)

-- Step 4.4: Top-Selling Products
-- Purpose: Calculate the quantity sold and revenue generated
-- by each product to identify the best-performing products.
select p.product_name,p.category,sum(oi.quantity) as total_quantity_sold,sum(oi.unit_price*oi.quantity) as total_revenue
from products p join order_items oi on oi.product_id=p.product_id join orders o on o.order_id=oi.order_id 
where o.order_status='Delivered' group by p.product_name,p.category order by total_revenue desc

-- Step 4.5: Customer Purchase Analysis
-- Purpose: Calculate total spending and the number of delivered
-- orders for each customer to understand purchasing behavior.
select c.customer_id,c.customer_name,count(distinct o.order_id) as delivered_goods,sum(oi.quantity*oi.unit_price) as total_spent from customers c
join orders o on c.customer_id=o.customer_id join order_items oi on oi.order_id=o.order_id where o.order_status='Delivered'
group by c.customer_id,c.customer_name order by total_spent desc

-- Step 4.6: Customer Segmentation Using CASE
-- Purpose: Categorize customers into spending segments
-- based on their total purchase value.
select c.customer_id,c.customer_name,
case when count(distinct o.order_id)>=3 then 'Frequent' when count(distinct o.order_id)=2 then 'Occasional' else 'One-time' end as customer_segment,
sum(oi.quantity*oi.unit_price) as total_spent from customers c
join orders o on c.customer_id=o.customer_id join order_items oi on oi.order_id=o.order_id where o.order_status='Delivered'
group by c.customer_id,c.customer_name order by total_spent desc

-- Step 4.7: Sales by Product Category
-- Purpose: Calculate total sales revenue for each product category
-- to identify the best-performing categories.
select p.category,sum(oi.quantity) as quantity_sum, sum(oi.quantity*oi.unit_price) as total_revenue from products p 
join order_items oi on oi.product_id=p.product_id join orders o on o.order_id=oi.order_id 
where o.order_status='Delivered' group by p.category order by total_revenue desc

-- Step 4.8: Latest Delivered Order by Customer
-- Purpose: Find the most recent delivered order date for each customer
-- to analyze customer purchasing activity.
select c.customer_id,c.customer_name,max(o.order_date) as last_order_date from customers c 
join orders o on c.customer_id=o.customer_id where o.order_status='Delivered'
group by c.customer_id,c.customer_name order by last_order_date desc

-- Step 4.9: Customers Without Delivered Orders
-- Purpose: Identify customers who have not placed any delivered orders
-- to understand customer inactivity and potential sales opportunities.
select c.customer_id,c.customer_name,o.order_id,o.order_status from customers c left join orders o on o.customer_id=c.customer_id
and o.order_status='Delivered' where o.order_id is null 

-- Step 4.10: Customers with Delivered Orders
-- Purpose: Count the distinct customers who have at least one
-- delivered order to measure the active customer base.
select count(distinct c.customer_id) as customers_with_delivered_orders from customers c
join orders o on o.customer_id = c.customer_id where o.order_status = 'Delivered'

-- Step 4.11: Products Without Delivered Sales
-- Purpose: Identify products that have not generated any
-- delivered sales to highlight products with no completed sales.
select p.product_id,p.product_name,p.category from products p left join order_items oi on oi.product_id = p.product_id
left join orders o on o.order_id = oi.order_id and o.order_status = 'Delivered' where o.order_id is null

-- Step 4.12: Average Order Value (AOV)
-- Purpose: Calculate total delivered revenue, the number of
-- delivered orders, and average revenue per delivered order.
select sum(oi.quantity*oi.unit_price) as total_delivered_revenue,count(distinct oi.order_id) as delivered_order_count,
1.0*sum(oi.quantity*oi.unit_price)/count(distinct oi.order_id) as average_order_value
from order_items oi join orders o on oi.order_id=o.order_id where o.order_status='Delivered'

-- Step 4.13: Order Status Analysis
-- Purpose: Calculate the number and percentage of orders
-- in each status to understand the overall order distribution.
select o.order_status,count(distinct o.order_id) as total_order,
100.0*count(distinct o.order_id)/(select count(*) from orders) as percentage_of_orders
from orders o group by o.order_status

-- Step 4.14: Monthly Order Volume
-- Purpose: Count orders by month and year to identify
-- changes in order volume over time.
select month(o.order_date) as month_order,year(o.order_date) as year_order,count(*) as total_orders from orders o
group by month(o.order_date),year(o.order_date) order by month(o.order_date),year(o.order_date)

-- Step 4.15: Average Units per Order
-- Purpose: Calculate total orders, total units sold, and
-- average units per order to understand purchasing volume.
select count(distinct o.order_id) as total_orders,sum(oi.quantity) as total_units_sold,
1.0*sum(oi.quantity)/count(distinct o.order_id) as average_units_per_order from orders o join order_items oi on oi.order_id=o.order_id
