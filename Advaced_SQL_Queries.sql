--ADVANCED QUERIES--

--Question 1: Calculate the percentage of each pizza type to total revenue

SELECT pizza_types.category, 
(SUM(pizzas.prize*order_details.quantity)/(SELECT 
SUM(order_details.quantity * pizzas.prize)
FROM order_details
INNER JOIN pizzas
ON pizzas.pizza_id=order_details.pizza_id)*100) AS revenue
FROM pizza_types
JOIN pizzas
ON pizzas.pizza_type_id=pizza_types.pizza_type_id
JOIN order_details
ON pizzas.pizza_id=order_details.pizza_id
GROUP BY pizza_types.category
ORDER BY revenue DESC

--NOTE:
--1st join is used to calculate the total revenue of the pizza (line 6-10)
--2nd join is used to calculate the revenue of each category (line 11-13)

--Question 2: Analyze the cumulative revenue generated over time.
SELECT order_date, SUM(revenue) OVER(ORDER BY order_date) AS cumulative_revenue 
FROM 
(SELECT orders.order_date, SUM(order_details.quantity* pizzas.prize) AS revenue
FROM orders
JOIN order_details
ON order_details.order_id= orders.order_id
JOIN pizzas
ON pizzas.pizza_id= order_details.pizza_id
GROUP BY orders.order_date) AS total_sales

--Question 3:Determine the top 3 most ordered pizza types based
--on revenue for each pizza category
SELECT category, name, revenue 
FROM
(SELECT category, name, revenue, RANK() OVER(PARTITION BY category ORDER BY revenue DESC) AS rn
FROM
(SELECT pizza_types.category, pizza_types.name, 
SUM(order_details.quantity*pizzas.prize) AS revenue
FROM pizza_types
JOIN pizzas
ON pizzas.pizza_type_id=pizza_types.pizza_type_id
JOIN order_details
ON pizzas.pizza_id=order_details.pizza_id
GROUP BY pizza_types.category, pizza_types.name) AS a) AS b
WHERE rn<=3


