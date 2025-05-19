-- The E-Commerce Database Management Project is a robust and scalable database solution designed to streamline and optimize the operations of an e-commerce business.
-- This project is developed using MySQL and focuses on creating a robust database management system that facilitates efficient handling of various aspects of an online store,
-- from product inventory to customer orders.

	USE e_commerceproject;

-- EXPLORATORY DATA ANALYSIS --

-- UNDERSTANDING THE SCHEMA --

SELECT * FROM CUSTOMER;
SELECT * FROM CATEGORY;
SELECT * FROM SELLER;
SELECT * FROM ADDRESS;
SELECT * FROM PRODUCT;
SELECT * FROM CART;
SELECT * FROM CART_ITEM;
SELECT * FROM ORDER_TABLE;
SELECT * FROM ORDERITEM;
SELECT * FROM PAYMENT;
SELECT * FROM REVIEW;

-- --------------------------------------------------------------------------------

-- Q1: Retrieve first_name,last_name and email of all customer records

SELECT first_name, last_name, email FROM customer;

-- --------------------------------------------------------------------------------

-- Q2: List all product names and their prices

SELECT product_name, price FROM product;

-- --------------------------------------------------------------------------------

-- Q3: Display all categories available in the category table

SELECT DISTINCT category_name FROM category;

-- --------------------------------------------------------------------------------

-- Q4: List all products with a stock quantity greater than 75

SELECT product_id, product_name, stock FROM product WHERE stock > 75;

-- --------------------------------------------------------------------------------

-- Q5: Find total number of orders placed by each customer

SELECT customer_id, COUNT(order_id) AS total_orders
FROM order_table GROUP BY customer_id;

-- --------------------------------------------------------------------------------

-- Q6: Retrieve the product name and the total sales amount for each product

SELECT p.product_id, p.product_name, SUM(oi.price * oi.quantity) AS total_sales 
FROM product AS p left join orderitem AS oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name;

-- --------------------------------------------------------------------------------

-- Q7: List all products with category name

SELECT p.product_name, c.category_name
FROM product AS p inner join category AS c ON p.category_id = c.category_id;

-- --------------------------------------------------------------------------------

-- Q8: Show the top 5 most expensive products

SELECT product_id, product_name, price FROM product ORDER BY price DESC LIMIT 5;

-- --------------------------------------------------------------------------------

-- Q9: Display all orders placed in dates between '2025-05-01' and '2025-05-10'

SELECT order_id, order_date, order_amount, order_status, shipping_date
FROM order_table WHERE order_date BETWEEN '2025-05-01' AND '2025-05-10';

-- --------------------------------------------------------------------------------

-- Q10: Display customers with their total spending

SELECT c.customer_id, c.first_name, c.last_name, SUM(oi.price * oi.quantity) AS total_amount
FROM customer AS c
left join order_table AS ot ON c.customer_id = ot.customer_id 
left join orderitem AS oi ON ot.order_id = oi.order_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- --------------------------------------------------------------------------------

-- Q11: Display customers who spends more than 25000

SELECT *
FROM (SELECT c.customer_id, c.first_name, c.last_name, SUM(oi.price * oi.quantity) AS total_amount
FROM customer AS c
left join order_table AS ot ON c.customer_id = ot.customer_id 
left join orderitem AS oi ON ot.order_id = oi.order_id
GROUP BY c.customer_id, c.first_name, c.last_name) AS total_spend
WHERE total_spend.total_amount > 25000;

-- --------------------------------------------------------------------------------

-- Q12: Display the top 3 customers with the highest spending

SELECT c.customer_id, c.first_name, c.last_name, SUM(oi.price * oi.quantity) AS total_amount
FROM customer AS c
left join order_table AS ot ON c.customer_id = ot.customer_id 
left join orderitem AS oi ON ot.order_id = oi.order_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_amount DESC LIMIT 3;

-- --------------------------------------------------------------------------------

-- Q13: List the products that have been sold more than 10 times

SELECT p.product_id, p.product_name, SUM(oi.quantity) AS total_sold
FROM orderitem AS oi inner join product AS p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
HAVING total_sold > 10;

-- --------------------------------------------------------------------------------

-- Q14: Retrieve the most popular category by sales

SELECT c.category_id, c.category_name, SUM(oi.price * oi.quantity) AS total_amount FROM category AS c
left join product AS p ON c.category_id = p.category_id
left join orderitem AS oi ON p.product_id = oi.product_id
GROUP BY c.category_id, c.category_name
ORDER BY total_amount DESC;

-- --------------------------------------------------------------------------------

-- Q15: Most Popular Product by Orders

SELECT p.product_name, COUNT(oi.order_id) AS order_count, SUM(oi.quantity) AS total_qty
FROM product AS p
left join orderitem AS oi ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY order_count DESC , total_qty DESC;

-- --------------------------------------------------------------------------------

-- Q16: Order Completion Rate by Customer

SELECT c.customer_id, c.first_name, c.last_name,
	SUM(IF(ot.order_status = 'delivery',1,0)) AS delivered_orders,
    COUNT(ot.order_id) AS order_count,
    ROUND((SUM(IF(ot.order_status = 'delivery',1,0)) / COUNT(ot.order_id)) * 100, 2) AS completion_rate
FROM customer AS c
inner join order_table AS ot ON c.customer_id = ot.customer_id
GROUP BY c.customer_id
ORDER BY delivered_orders DESC;

-- --------------------------------------------------------------------------------

-- Q17: Total Revenue by Seller and Category

SELECT s.seller_name, c.category_name, SUM(oi.price * oi.quantity) AS total_revenue
FROM seller AS s
left join product AS p ON s.seller_id = p.seller_id
left join category AS c ON c.category_id = p.category_id
left join orderitem AS oi ON oi.product_id = p.product_id
GROUP BY s.seller_name, c.category_name
ORDER BY total_revenue DESC;

-- --------------------------------------------------------------------------------

-- Q18: Average Rating by Product and Category

SELECT p.product_name, c.category_name, ROUND(AVG(cast(r.rating AS DECIMAL)),2) AS avg_rating
FROM product AS p
left join category AS c ON p.category_id = c.category_id
left join review AS r ON r.product_id = p.product_id
GROUP BY p.product_name, c.category_name;

-- --------------------------------------------------------------------------------

-- Q19: Most Profitable Category

SELECT c.category_name, SUM(oi.price * oi.quantity) AS total_revenue
FROM category AS c
left join product AS p ON c.category_id = p.category_id
left join orderitem AS oi ON p.product_id = oi.product_id
GROUP BY c.category_name
ORDER BY total_revenue DESC
LIMIT 1;

-- --------------------------------------------------------------------------------

-- Q20: List the Sellers with their total sales

SELECT s.seller_name, SUM(oi.price * oi.quantity) AS total_sales
FROM seller AS s
left join product AS p ON s.seller_id = p.seller_id
left join orderitem AS oi ON oi.product_id = p.product_id
GROUP BY s.seller_name
ORDER BY total_sales DESC;

-- --------------------------------------------------------------------------------

-- Q21: Customer Purchase Recency and Frequency

SELECT c.customer_id, c.first_name, c.last_name,
	MAX(ot.order_date) AS last_order_date, COUNT(ot.order_id) AS order_count
FROM customer AS c
inner join order_table AS ot ON c.customer_id = ot.customer_id
GROUP BY c.customer_id
ORDER BY last_order_date DESC;

-- --------------------------------------------------------------------------------

-- Q22: Customers with Unpurchased Cart Items

SELECT c.customer_id, c.first_name, c.last_name
FROM customer AS c
left join order_table AS ot ON c.customer_id = ot.customer_id
left join cart AS ca ON ca.cart_id = ot.cart_id
WHERE ot.order_id IS NULL;

-- --------------------------------------------------------------------------------

-- Q23: Average Payment by Mode

SELECT p.payment_mode, ROUND(AVG(ot.order_amount),2) AS avg_amount
FROM payment AS p
left join order_table AS ot ON p.order_id = ot.order_id
GROUP BY p.payment_mode;

-- --------------------------------------------------------------------------------

-- Q24: Customer's Favorite Category

SELECT c.customer_id, c.first_name, c.last_name, ca.category_name, COUNT(oi.product_id) AS purchase_count
FROM customer AS c
inner join order_table AS ot ON c.customer_id = ot.customer_id
inner join orderitem AS oi ON oi.order_id = ot.order_id
inner join product AS p ON p.product_id = oi.product_id
inner join category AS ca ON ca.category_id = p.category_id
GROUP BY c.customer_id, ca.category_name
ORDER BY c.customer_id, purchase_count DESC;

-- --------------------------------------------------------------------------------

-- Q25: List the customers with undelivered online orders.

SELECT c.customer_id, c.first_name, c.last_name, ot.order_id, ot.order_status, p.payment_mode
FROM customer AS c
inner join order_table AS ot ON c.customer_id = ot.customer_id
inner join payment AS p ON p.order_id = ot.order_id
WHERE ot.order_status = 'not delivery' AND p.payment_mode = 'online'
ORDER BY c.customer_id;

-- --------------------------------------------------------------------------------