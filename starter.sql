-- Active: 1695112106852@@127.0.0.1@5432@northwind @public
-- 2 התרגולים כאן
-- תרגול א
--1
SELECT Employees.last_name, Employees.first_name, COUNT(order_id)
FROM Employees
INNER JOIN Orders
ON Employees.employee_id = Orders.employee_id GROUP BY Employees.employee_id
--2
SELECT categories.category_name, SUM(order_details.quantity*order_details.unit_price*(1-order_details.discount)) AS sum
FROM categories 
INNER JOIN products ON products.category_id = categories.category_id
INNER JOIN order_details ON products.product_id = order_details.product_id 
GROUP BY categories.category_name 
ORDER BY sum DESC;
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

--10order_details.unit_price 
-- SELECT *       
-- FROM products
-- INNER JOIN order_details ON products.product_id IN(order_details.product_id) ORDER BY products.product_id




-- -- תרגול ב
-- --1

-- -- 2
SELECT customers.company_name
FROM customers 
WHERE  

-- --3
SELECT product_name FROM products WHERE products.unit_price > (SELECT AVG(unit_price) FROM products)  
 

-- SELECT * FROM order_details 

 
-- SELECT * FROM orders 

-- SELECT * FROM products
 
SELECT customer_id FROM customers
