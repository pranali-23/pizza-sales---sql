--INTERMEDIATE QUESTIONS--

--Question 1: Join necessary tables to find total quantity of each pizza category ordered
SELECT pizza_types.category, SUM(order_details.quantity) AS quantity
FROM pizza_types
JOIN pizzas
ON pizzas.pizza_type_id=pizza_types.pizza_type_id
JOIN order_details
ON order_details.pizza_id= pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;

--Question 2: Determine the distribution of orders by hours of the day
SELECT EXTRACT(HOUR FROM order_time) AS time, COUNT(order_id) AS order_count FROM orders
GROUP BY time

--Question 3: Join the relevant tables to find the category wise distribution of pizzas.
SELECT category, COUNT(name) FROM pizza_types
GROUP BY category

--Question 4: Group the orders by date and 
--calculate the average number of pizzas ordered per day

SELECT ROUND (AVG(quantity)) AS avg_pizza_ordered_per_day
FROM 
(SELECT orders.order_date, SUM (order_details.quantity) AS quantity
FROM orders
JOIN order_details
ON orders.order_id= order_details.order_id
GROUP BY orders.order_date) AS order_quantity

--Question 5: Determine the top most ordered pizza based on the revenue
SELECT pizza_types.name, SUM (pizzas.prize*order_details.quantity) AS revenue
FROM pizza_types
JOIN pizzas
ON pizzas.pizza_type_id=pizza_types.pizza_type_id
JOIN order_details
ON order_details.pizza_id= pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 3

