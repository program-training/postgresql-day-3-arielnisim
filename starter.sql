-- Active: 1695112106852@@127.0.0.1@5432@northwind @public
-- 2 התרגולים כאן
-- תרגול א
--1
SELECT last_name, first_name, COUNT(order_id) AS total_orders
FROM employees
INNER JOIN orders ON employees.employee_id = orders.employee_id
GROUP BY employees.employee_id

--2
SELECT category_name, SUM(quantity*order_details.unit_price*(1-discount)) AS total_sales
FROM categories 
INNER JOIN products ON products.category_id = categories.category_id
INNER JOIN order_details ON products.product_id = order_details.product_id 
GROUP BY category_name 
ORDER BY total_sales DESC;

--3
WITH avg_per_order AS(
    SELECT order_id, AVG(quantity*unit_price*(1-discount))
    FROM order_details 
    GROUP BY order_id)
SELECT company_name, AVG(avg)
FROM customers INNER JOIN orders ON customers.customer_id = orders.customer_id
INNER JOIN avg_per_order ON avg_per_order.order_id = orders.order_id
GROUP BY company_name

--4
SELECT customers.company_name, SUM(order_details.quantity*order_details.unit_price*(1-order_details.discount)) AS sum
FROM orders 
INNER JOIN customers ON orders.customer_id = customers.customer_id
INNER JOIN order_details ON orders.order_id = order_details.order_id
GROUP BY customers.company_name 
ORDER BY sum DESC
LIMIT 10

--5
SELECT EXTRACT(MONTH FROM orders.order_date) AS months ,SUM(order_details.quantity*order_details.unit_price*(1-order_details.discount)) AS sum   
FROM orders INNER JOIN order_details ON orders.order_id = order_details.order_id
GROUP BY months 
ORDER BY months

--6
SELECT  product_name, units_in_stock
FROM products
WHERE units_in_stock < 10

--7
SELECT customers.company_name, order_details.quantity*order_details.unit_price*(1-order_details.discount) AS sum
FROM orders 
INNER JOIN customers ON orders.customer_id = customers.customer_id
INNER JOIN order_details ON orders.order_id = order_details.order_id 
ORDER BY sum DESC
LIMIT 1 

--8
SELECT orders.ship_country, SUM(order_details.quantity*order_details.unit_price*(1-order_details.discount)) AS sum
FROM orders
INNER JOIN order_details ON orders.order_id = order_details.order_id
GROUP BY orders.ship_country
ORDER BY sum DESC

--9
SELECT shippers.company_name, COUNT(orders.ship_via) AS sum
FROM orders
INNER JOIN shippers ON shippers.shipper_id = orders.ship_via 
GROUP BY shippers.company_name
ORDER BY sum DESC
LIMIT 1

--10
SELECT product_name, reorder_level, products.unit_price   
FROM products LEFT OUTER JOIN order_details
ON products.product_id = order_details.product_id
WHERE order_details.product_id IS NULL


-- -- תרגול ב
--1
SELECT company_name
FROM customers LEFT OUTER JOIN orders ON customers.customer_id = orders.customer_id
WHERE orders.order_id IS NULL

-- 2
SELECT company_name
FROM customers INNER JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY company_name HAVING COUNT(orders.order_id) > 10

--3
SELECT product_name
FROM products
WHERE products.unit_price > (SELECT AVG(unit_price) FROM products)  

--4
SELECT product_name
FROM products LEFT OUTER JOIN order_details ON products.product_id = order_details.product_id
WHERE order_details.product_id IS NULL

--5
SELECT country
FROM customers
GROUP BY country
HAVING COUNT(country) >= 5

--6
WITH coustomers_order_1998 AS(
    SELECT DISTINCT customer_id, order_date 
    FROM orders
    WHERE EXTRACT(YEAR FROM order_date) = 1998
) 
SELECT company_name
FROM customers LEFT OUTER JOIN coustomers_order_1998
ON customers.customer_id = coustomers_order_1998.customer_id
WHERE coustomers_order_1998.customer_id IS NULL

--7
SELECT company_name
FROM customers INNER JOIN orders ON customers.customer_id = orders.customer_id
WHERE country ILIKE 'France' AND order_date > '1998-01-01'   

--8
SELECT company_name
FROM customers INNER JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY company_name HAVING COUNT(order_id) = 3

--9
SELECT product_name
FROM products
INNER JOIN order_details ON products.product_id = order_details.product_id
INNER JOIN orders ON orders.order_id = order_details.order_id
ORDER BY order_date DESC
LIMIT 1

--10
SELECT DISTINCT company_name
FROM suppliers INNER JOIN products ON products.supplier_id = suppliers.supplier_id
WHERE country ILIKE 'USA'




