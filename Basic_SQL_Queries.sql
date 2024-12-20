--BASIC QUESTIONS--

--	Qustion 1: Retrieve total number of orders 
SELECT count(order_id) AS total_orders FROM orders

-- Question 2: Calculate the total revenue generated from pizza sales
SELECT 
SUM(order_details.quantity * pizzas.prize)AS revenue
FROM order_details
INNER JOIN pizzas
ON pizzas.pizza_id=order_details.pizza_id

--Question 3: Identify the highest priced pizza
SELECT pizza_types.pizza_type_id, pizza_types.name, pizzas.prize
FROM pizza_types
INNER JOIN pizzas
ON pizzas.pizza_type_id=pizza_types.pizza_type_id
ORDER BY prize DESC
LIMIT 1

--(alternate query)
SELECT* FROM pizzas
ORDER BY prize DESC
LIMIT 1

--Question 4: Identify the most common pizza size orderedpizza
SELECT pizzas.size, COUNT(order_details.order_details_id)
FROM pizzas
JOIN order_details
ON pizzas.pizza_id= order_details.pizza_id
GROUP BY pizzas.size
ORDER BY COUNT(order_details.order_details_id) DESC

--Question 5: List the top 5 most ordered pizza types along with their quantities
SELECT pizza_types.name, SUM(order_details.quantity) 
FROM pizza_types
JOIN pizzas
ON pizzas.pizza_type_id=pizza_types.pizza_type_id
JOIN order_details
ON pizzas.pizza_id=order_details.pizza_id
GROUP BY pizza_types.name
ORDER BY SUM(order_details.quantity) DESC
LIMIT 5

