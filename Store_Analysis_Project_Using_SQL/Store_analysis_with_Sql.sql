--1.query to get the first and last name of each customer
SELECT first_name,last_name
FROM sales.customers;

--2.query to get all information on the customer table
SELECT * FROM
sales.customers;

--3.query to get all customers from Carlifornia with first name in ascending order(where is used to filter rows)
SELECT * FROM
sales.customers WHERE state='CA'
ORDER BY first_name ASC;

--4.query to get the number of customers in each city and all cities of customers located in California(group by is used to 'groupby column based on row'
SELECT city,count(*) AS total_number_of_customer_here
FROM sales.customers
WHERE state='CA'
GROUP BY city

--5 query to find the city in California which has more than ten customers(having clause is used here to filter groups)
SELECT city,count(*) AS total_number_of_customer_here
FROM sales.customers
WHERE state='CA'
GROUP BY city
HAVING count(*) >10

--6 query get all the customers and sort out  the city in descending order and the first name in ascending order
SELECT * FROM sales.customers
ORDER BY city DESC ,first_name ASC

--7 query  all products from the products table and sorts the products by their list prices and names skipping the first 10 products
SELECT * FROM production.products
ORDER BY list_price,product_name
OFFSET 10 ROWS

--8 query  all products from the products table and sorts the products by their list prices and names skipping the first 10 products an select just the next 10
SELECT * FROM production.products
ORDER BY list_price,product_name
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY

--9 query to get  the top 10 most expensive products.
SELECT TOP 10 product_id,product_name,list_price
FROM production.products
ORDER BY list_price DESC

--10 query to get the distinct city,state of all customers
SELECT DISTINCT city,state
FROM sales.customers

--11 query get the category id of 1, and the model is 2016 of all products
SELECT * FROM production.products
WHERE category_id = 1 AND model_year = 2016

--12 query to find products whose list price is greater than 3,000 or whose model is 2018.
SELECT * FROM production.products
WHERE list_price > 3000 OR model_year = 2018

--13 query to find all products with list prices  between 379.99 and 1,999
SELECT * FROM production.products
WHERE list_price BETWEEN 379.99 AND 1999

--14 query to find all product that contains name contains the the word Cruiser
SELECT * FROM production.products
WHERE product_name LIKE '%Cruiser%'

--15 query to find all customers with no phone number
SELECT * FROM sales.customers
WHERE phone IS NULL

--16 qUERY to get all the customers phone number
SELECT * FROM sales.customers
WHERE phone IS NOT NULL

--17 query to find all products with list prices 379.99 ,749.99,1320.99 and 1,999
SELECT * FROM production.products
WHERE list_price IN (379.99 ,749.99,1320.99 , 1999)

--18 query to find all orders placed by customers between January 12, 2017 and January 17, 2017
SELECT * FROM sales.orders
WHERE order_date	BETWEEN '2017-01-12' AND '2017-01-17'

--19 query to find the first_name,last_name,order_status,shipped_date,order_date for customers order
SELECT C.first_name,C.last_name ,O.order_status,O.shipped_date,0.order_date
FROM sales.orders O INNER JOIN sales.customers C
ON O.customer_id = C.customer_id

--20 query to find the product_name,category_name,brand_name and list price of products order by the list_price from highest to lowest
SELECT p.product_name,c.category_name,b.brand_name,list_price 
FROM production.products p INNER JOIN production.categories c ON c.category_id = p.category_id
INNER JOIN production.brands b ON b.brand_id = p.brand_id
ORDER BY list_price DESC;

--21  query to get all products  that have not been sold to any customer yet.
SELECT p.product_name, o.order_id
FROM production.products p LEFT JOIN sales.order_items o ON o.product_id = p.product_id 
WHERE order_id IS NULL

-- 22 query to find the products that belong to order id 100
SELECT p.product_name,o.order_id
FROM production.products p
INNER JOIN sales.order_items o ON o.product_id = p.product_id WHERE order_id = 100
ORDER BY order_id;

--23 query to get all products that do not have any sales alphabetically
SELECT p.product_name, o.order_id
FROM sales.order_items o RIGHT JOIN production.products p 
ON o.product_id = p.product_id
WHERE order_id IS NULL ORDER BY product_name ASC;
 
--24 query to return the number of orders placed by the customers with id 1 ,2,4,5 by year
SELECT customer_id, YEAR (order_date) order_year, COUNT (order_id) order_placed
FROM sales.orders
WHERE customer_id IN (1, 2, 4, 5)
GROUP BY customer_id, YEAR (order_date)
ORDER BY customer_id; 

--25 query to get the number of customers by state and city with city and state arranged in ascending orde
SELECT city,state,COUNT (customer_id) customer_count
FROM sales.customers
GROUP BY state,city
ORDER BY city ASC,state ASC;

--26 query the average, minimum and maximum list prices of all products with the model 2018 by brand
SELECT brand_name, MIN (list_price) min_price, MAX (list_price) max_price,AVG (list_price) average
FROM production.products p INNER JOIN production.brands b ON b.brand_id = p.brand_id
WHERE model_year = 2018
GROUP BY brand_name
ORDER BY brand_name;

--27 query to find the sales orders whose net values are greater than 20,000  :
SELECT order_id,SUM (quantity * list_price * (1 - discount)) AS net_value
FROM sales.order_items
GROUP BY order_id
HAVING SUM (quantity * list_price * (1 - discount))> 20000

--28 query to find the customers who bought products in 2017.
SELECT customer_id,first_name,last_name,city
FROM sales.customers c
WHERE EXISTS (SELECT customer_id FROM sales.orders o
WHERE o.customer_id = c.customer_id AND YEAR (order_date) = 2017)
ORDER BY first_name,last_name;

--29 query to find the sales orders of the customers located in New York
SELECT order_id,order_date,customer_id
FROM sales.orders
WHERE customer_id IN (SELECT customer_id FROM sales.customers WHERE city = 'New York')
ORDER BY order_date DESC;

-- 30  query to find the names of all mountain bikes and road bikes products that the Bike Stores sell.
SELECT product_id,product_name
FROM production.products
WHERE category_id IN (SELECT category_id FROM production.categories
WHERE category_name = 'Mountain Bikes'OR category_name = 'Road Bikes');

