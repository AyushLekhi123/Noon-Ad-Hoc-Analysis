-- Data Analysis

SELECT * FROM orders;

-- Question 1
-- Find Top 3 outlets by cuisine type without using limit and top function

WITH cte AS(
	SELECT Cuisine, Restaurant_id, COUNT(*) AS no_of_orders
	FROM orders
	GROUP BY Cuisine, Restaurant_id
)
SELECT Cuisine, Restaurant_id, no_of_orders
FROM
(
	SELECT *, ROW_NUMBER() OVER(PARTITION BY Cuisine ORDER BY no_of_orders DESC) AS rn
	FROM cte
) AS t2
WHERE rn <= 3


-- Question 2
-- Find the daily new customer count from the launch date ( everyday how many new customers are we acquiring? )

WITH cte AS(
	SELECT Customer_code, CAST(MIN(Placed_at) AS DATE) AS first_order_date 
	FROM orders 
	GROUP BY Customer_code
)

SELECT first_order_date, COUNT(*) AS no_of_new_customers
FROM cte
GROUP BY first_order_date
ORDER BY first_order_date


-- Question 3
-- Count of all the customers who were acquired in Jan 2025 who only placed only one order and did not place any other order

WITH cte AS(
	SELECT Customer_code, COUNT(*) AS no_of_orders
	FROM orders
	WHERE MONTH(Placed_at) = 1 AND YEAR(Placed_at) = 2025
		AND Customer_code NOT IN 
			(SELECT DISTINCT Customer_code
			 FROM orders
			 WHERE NOT (MONTH(Placed_at) = 1 AND YEAR(Placed_at) = 2025))
	GROUP BY Customer_code
	HAVING COUNT(*) = 1
)

SELECT COUNT(*) no_of_customers FROM cte;


-- Question 4
-- List of all the customers with no order in th last 7 days who were acquired a month ago with their first order on promo

WITH cte AS(
	SELECT Customer_code, MIN(Placed_at) AS first_order_date, MAX(Placed_at) AS last_order_date
	FROM orders
	GROUP BY Customer_code
)

SELECT c.Customer_code
FROM cte c
JOIN orders o
ON c.Customer_code = o.Customer_code AND c.first_order_date = o.Placed_at
WHERE o.Promo_code_Name IS NOT NULL
	AND c.last_order_date < DATEADD(DAY, -7, GETDATE())
	AND c.first_order_date < DATEADD(MONTH, -1, GETDATE())


-- Question 5
-- Growth team is planning to create a trigger that will target customers after their every third order
-- with a personalized communication in March 2025. Write a query for this.

WITH cte AS(
	SELECT *, ROW_NUMBER() OVER(PARTITION BY Customer_code ORDER BY Placed_at) AS order_count
	FROM orders
)

SELECT *
FROM cte
WHERE order_count % 3 = 0
	AND FORMAT(Placed_at, 'MMMM') = 'March' AND YEAR(Placed_at) = 2025


-- Question 6
-- List customers who placed more than 1 order and all their orders were on promo only

SELECT Customer_code, COUNT(*) AS no_of_orders, COUNT(Promo_code_Name) AS  promo_orders
FROM orders
GROUP BY Customer_code
HAVING COUNT(*) > 1 AND COUNT(*) = COUNT(Promo_code_Name)


-- Question 7
-- What percent of customers were organically acquired in Jan 2025? (placed their first order without promo code)

WITH cte AS(
	SELECT *, ROW_NUMBER() OVER(PARTITION BY Customer_code ORDER BY Placed_at) AS rnk
	FROM orders
	WHERE MONTH(Placed_at) = 1 AND YEAR(Placed_at) = 2025
)

SELECT CONCAT(ROUND(CAST(COUNT
			(
			 CASE 
				WHEN  rnk = 1 AND Promo_code_Name IS NULL THEN Customer_code
			 END
			) AS FLOAT) * 100.0 / COUNT(DISTINCT Customer_code), 2), '%') AS percent_of_customers
FROM cte;


