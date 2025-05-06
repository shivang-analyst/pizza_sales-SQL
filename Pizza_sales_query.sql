Q1)--  Retrieve the total number of orders placed.

select count(order_id) as total_order from orders

Q2)-- Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(P.price * O.quantity), 2) AS total_sales
FROM
    pizzas P
        JOIN
    order_details O ON P.pizza_id = O.pizza_id

Q3)-- Identify the highest-priced pizza.

SELECT 
    P.name, A.price
FROM
    pizza_types P
        JOIN
    pizzas A ON P.pizza_type_id = A.pizza_type_id
ORDER BY A.price DESC
LIMIT 1;


Q4)-- Identify the most common pizza size ordered.

SELECT 
    P.size, COUNT(O.order_details_id) AS order_count
FROM
    pizzas P
        JOIN
    order_details O ON P.pizza_id = O.pizza_id
GROUP BY P.size
ORDER BY order_count DESC


Q5)-- Join the necessary tables to find the total quantity of each pizza category ordered.--

SELECT 
    P.category, SUM(O.quantity) AS quantity
FROM
    pizza_types P
        JOIN
    pizzas A ON P.pizza_type_id = A.pizza_type_id
        JOIN
    order_details O ON A.pizza_id = O.pizza_id
GROUP BY P.category
ORDER BY quantity DESC

Q6)-- List the top 5 most ordered pizza 
-- types along with their quantities.-- 

SELECT 
    P.name, SUM(O.quantity) AS quantity
FROM
    pizza_types P
        JOIN
    pizzas I ON P.pizza_type_id = I.pizza_type_id
        JOIN
    order_details O ON O.pizza_id = I.pizza_id
GROUP BY P.name
ORDER BY quantity DESC
LIMIT 5

Q7)-- Determine the distribution of orders by hour of the day.

SELECT 
    HOUR(order_time) AS hour, COUNT(order_id) AS order_count
FROM
    orders
GROUP BY HOUR(order_time);

Q8)-- Join relevant tables to find the category-wise distribution of pizzas.,

SELECT 
    category, COUNT(name) AS count_name
FROM
    pizza_types
GROUP BY category

Q9)-- Determine the top 3 most ordered pizza types based on revenue. 

SELECT 
    P.name, SUM(O.quantity * A.price) AS revenue
FROM
    pizza_types P
        JOIN
    pizzas A ON P.pizza_type_id = A.pizza_type_id
        JOIN
    order_details O ON A.pizza_id = O.pizza_id
GROUP BY P.name
ORDER BY revenue DESC
LIMIT 3;

Q10)-- Calculate the percentage contribution of each 
-- pizza type to total revenue.

SELECT 
    pizza_types.category,
    ROUND(SUM(order_details.quantity * pizzas.price) / (SELECT 
                    ROUND(SUM(order_details.quantity * pizzas.price),
                                2) AS total_sales
                FROM
                    order_details
                        JOIN
                    pizzas ON pizzas.pizza_id = order_details.pizza.id) * 100,
            2) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY revenue DESC;

Q11)-- Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT 
    O.order_date, AVG(D.quantity) AS avg_pizzas_per_day
FROM
    orders O
        JOIN
    order_details D ON O.order_id = D.order_id
GROUP BY order_date

Q12)-- Analyze the cumulative revenue generated over time.

select order_date,
sum(revenue) over(order by order_date)as cum_revenue
from
(select orders.order_date,
sum(order_details.quantity* pizzas.price) as revenue
from order_details
join
pizzas
ON
order_details.pizza_id=pizzas.pizza_id
join
orders
on
orders.order_id=order_details.order_id
group by orders.order_date) as sales;

Q13)-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.

select pizza_types.category,pizza_types.name,
sum((order_details.quantity)* pizzas.price) as revenue
from pizza_types 
join
pizzas
on
pizza_types.pizza_type_id=pizzas.pizza_type_id
join
order_details
on
order_details.pizza_id=pizzas.pizza_id
group by pizza_types.category,pizza_types.name;






