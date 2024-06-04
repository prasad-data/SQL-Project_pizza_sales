






-- List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pizza_type.name, ROUND(SUM(order_details.quantity), 2) as Quantity
FROM
    pizza_type
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_type.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_type.name
ORDER BY Quantity DESC
LIMIT 5;
    
-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    pizza_type.category, SUM(order_details.quantity) AS quantity
FROM
    pizza_type
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_type.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_type.category
ORDER BY quantity DESC;

-- Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(order_time) AS hr_of_the_day,
    COUNT(order_id) AS num_of_orders
FROM
    orders
GROUP BY HOUR(order_time)
ORDER BY hr_of_the_day;


-- Join relevant tables to find the category-wise distribution of pizzas.
SELECT 
    category, COUNT(category) AS TYPE
FROM
    pizza_type
GROUP BY category
ORDER BY category DESC;


-- Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT 
    ROUND(AVG(quantity), 0) 
FROM
    (SELECT 
        order_date, SUM(order_details.quantity) AS quantity
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.order_date) AS order_quantity_per_day;


-- Determine the top 3 most ordered pizza types based on revenue.    
SELECT 
    pizza_type.name,
    ROUND(SUM(pizzas.price * order_details.quantity),
            2) AS revenue
FROM
    pizza_type
        JOIN
    pizzas ON pizza_type.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_type.name
ORDER BY revenue DESC
LIMIT 3;
    
    
-- Calculate the percentage contribution of each pizza type to total revenue.
SELECT 
    pizza_type.category,
    ROUND(SUM(order_details.quantity * pizzas.price) / (SELECT 
                    ROUND(SUM(order_details.quantity * pizzas.price),
                                2) AS total_sales
                FROM
                    order_details
                        JOIN
                    pizzas ON pizzas.pizza_id = order_details.pizza_id),
            2) * 100 AS percent_share
FROM
    pizza_type
        JOIN
    pizzas ON pizza_type.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_type.category;


-- Analyze the cumulative revenue generated over time.
-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
    
    