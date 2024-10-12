-- Bike Store Data Analysis

Use bike_store;

-- 1. Sales Analysis:
-- A.  What is the total sales amount (considering discounts) for each product in a given year?   
SELECT 
	p.product_id, p.product_name, YEAR(o.order_date) AS year,
    SUM(oi.quantity * (oi.list_price - (oi.list_price * oi.discount / 100))) AS total_sales_amount
FROM 
	Order_items oi
JOIN 
	Products p ON oi.product_id = p.product_id
JOIN 
	Orders o ON oi.order_id = o.order_id
GROUP BY 
	year, p.product_id, p.product_name
ORDER BY 
	year, total_sales_amount DESC;


-- B. Which products are the top-selling items based on quantity sold?
SELECT 
	p.product_id, p.product_name, SUM(oi.quantity) total_quantity
FROM 
	order_items oi
JOIN 
	products p ON oi.product_id = p.product_id
GROUP BY 
	p.product_id, p.product_name
ORDER BY 
	total_quantity DESC
LIMIT 10;


-- C. What are the monthly sales trends across different categories?
SELECT 
	c.category_name, YEAR(o.order_date) AS year, MONTH(o.order_date) AS month,
    SUM(oi.quantity * (oi.list_price - (oi.list_price * oi.discount / 100))) AS total_sales_amount
FROM 
	Order_items oi
JOIN 
	products p ON p.product_id = oi.product_id
JOIN 
	categories c ON c.category_id = p.category_id
JOIN 
	Orders o ON oi.order_id = o.order_id
GROUP BY 
	c.category_name, year, month
ORDER BY 
	year, month, total_sales_amount DESC;
    

-- 2. Customer Insights:
-- A. How many orders were placed by each customer, and what is the total revenue generated from them?
SELECT 
	c.Customer_id, 
    CONCAT(c.first_name,' ',c.last_name) AS customer_name, 
    COUNT(o.order_id) AS total_orders,
	SUM(oi.quantity * (oi.list_price - (oi.list_price * oi.discount / 100))) AS total_revenue
FROM 
	customers c
JOIN 
	orders o ON o.customer_id = c.customer_id
JOIN 
	Order_items oi ON o.order_id = oi.order_id
GROUP BY 
	c.Customer_id, customer_name
ORDER BY 
	total_revenue DESC;
    

-- B. What are the top cities where most of the orders are placed?
SELECT 
	c.city, COUNT(o.order_id) AS total_orders
FROM 
	customers c
JOIN
	orders o ON o.customer_id = c.customer_id
GROUP BY
	c.city
ORDER BY
	total_orders DESC
LIMIT 10;


-- C. What are the top states where most of the orders are placed?
SELECT 
	c.state, COUNT(o.order_id) AS total_orders
FROM 
	customers c
JOIN
	orders o ON o.customer_id = c.customer_id
GROUP BY
	c.state
ORDER BY
	total_orders DESC;
    
    
-- D. Identify customers who haven’t placed any orders in the past year.
SELECT 
	c.Customer_id, 
    CONCAT(c.first_name,' ',c.last_name) AS customer_name, 
    c.email,
    c.city,
    c.state
FROM 
	customers c
LEFT JOIN 
	orders o ON o.customer_id = c.customer_id
WHERE 
	YEAR(o.order_date) = 2018
GROUP BY 
	c.Customer_id, customer_name, c.email, c.city, c.state
HAVING
	COUNT(o.order_id) = 0;
 
 
-- 3. Product Performance:
-- A. What are the most popular product categories by sales volume?
SELECT 
	c.category_id, c.category_name, SUM(oi.quantity) as Sales_volume
FROM
	categories c
JOIN
	products p ON c.category_id = p.category_id
JOIN 
	order_items oi ON oi.product_id = p.product_id
GROUP BY
	c.category_id, c.category_name
ORDER BY
	Sales_volume DESC
LIMIT 1;
    

-- B. What are the least popular product categories by sales volume?
SELECT 
	c.category_id, c.category_name, SUM(oi.quantity) as Sales_volume
FROM
	categories c
JOIN
	products p ON c.category_id = p.category_id
JOIN 
	order_items oi ON oi.product_id = p.product_id
GROUP BY
	c.category_id, c.category_name
ORDER BY
	Sales_volume 
LIMIT 1;


-- C. How does product sales performance vary across different brands?
SELECT 
	b.brand_id, b.brand_name,
    SUM(oi.quantity * (oi.list_price - (oi.list_price * oi.discount / 100))) AS total_sales_amount,
    SUM(oi.quantity) AS total_quantity_sold
FROM 
	brands b
JOIN
	products p ON p.brand_id = b.brand_id
JOIN
	order_items oi ON oi.product_id = p.product_id
GROUP BY 
	b.brand_id, b.brand_name
ORDER BY
	total_sales_amount DESC;
    

-- D. What is the average discount provided on each product across all orders?
SELECT
	p.product_id, p.product_name, 
    AVG(oi.discount) AS avg_discount
FROM
	products p
LEFT JOIN
	order_items oi ON oi.product_id = p.product_id
GROUP BY
	p.product_id, p.product_name
ORDER BY
	avg_discount DESC;


--  4. Inventory Management:
-- A. Which stores have the highest stock quantities for each product?
SELECT 
    s.store_id, s.store_name, p.product_id, p.product_name,
    st.quantity AS stock_quantity
FROM 
    Stocks st
JOIN 
    Products p ON st.product_id = p.product_id
JOIN 
    Stores s ON st.store_id = s.store_id
ORDER BY 
    p.product_id, st.quantity DESC;


-- B. Which stores have the lowest stock quantities for each product?
SELECT 
    s.store_id, s.store_name, p.product_id, p.product_name,
    st.quantity AS stock_quantity
FROM 
    Stocks st
JOIN 
    Products p ON st.product_id = p.product_id
JOIN 
    Stores s ON st.store_id = s.store_id
ORDER BY 
    p.product_id, st.quantity;


-- C. What are the products that are low in stock across all stores?
SELECT 
    s.store_id, s.store_name, p.product_id, p.product_name,
    SUM(st.quantity) AS total_stock
FROM 
    Stocks st
JOIN
	stores s ON s.store_id = st.store_id
JOIN 
    Products p ON st.product_id = p.product_id
GROUP BY 
    s.store_id, s.store_name, p.product_id, p.product_name
HAVING 
    total_stock < 5
ORDER BY 
    total_stock ASC;


-- 5. Staff and Store Performance:
-- A. Which store has the highest number of orders and total revenue?
SELECT 
	s.store_id, s.store_name, COUNT(o.order_id) AS total_orders,
    SUM(oi.quantity * (oi.list_price - (oi.list_price * oi.discount / 100))) AS total_revenue
FROM
	stores s
JOIN
	orders o ON o.store_id = s.store_id
JOIN
	order_items oi ON o.order_id = oi.order_id
GROUP BY 
	s.store_id, s.store_name
ORDER BY
	total_orders DESC, total_revenue DESC;


-- B. What is the total sales generated by each staff member?
SELECT 
    st.staff_id,
    CONCAT(st.first_name, ' ', st.last_name) AS staff_name,
    SUM(oi.quantity * (oi.list_price - (oi.list_price * oi.discount / 100))) AS total_sales
FROM 
    Orders o
JOIN 
    Order_items oi ON o.order_id = oi.order_id
JOIN 
    Staffs st ON o.staff_id = st.staff_id
GROUP BY 
    st.staff_id, staff_name
ORDER BY 
    total_sales DESC;


-- C. How does staff performance (sales generated) vary across different stores?
SELECT 
    s.store_id,
    s.store_name,
    st.staff_id,
    CONCAT(st.first_name, ' ', st.last_name) AS staff_name,
    SUM(oi.quantity * (oi.list_price - (oi.list_price * oi.discount / 100))) AS total_sales
FROM 
    Orders o
JOIN 
    Order_items oi ON o.order_id = oi.order_id
JOIN 
    Staffs st ON o.staff_id = st.staff_id
JOIN 
    Stores s ON st.store_id = s.store_id
GROUP BY 
    s.store_id, s.store_name, st.staff_id, staff_name
ORDER BY 
    s.store_name, total_sales DESC;


-- 6. Customer Retention:
-- A. How many customers placed more than one order within the last year?
SELECT COUNT(customers_with_multiple_orders) AS customers_with_multiple_orders
FROM (
	SELECT 
		COUNT(DISTINCT customer_id) AS customers_with_multiple_orders
	FROM 
		Orders
	WHERE 
		YEAR(order_date) = 2018 
	GROUP BY 
		customer_id
	HAVING 
		COUNT(order_id) > 1
) sub;
