USE task4_db;

-- SUBQUERIES FOR SELECT

SELECT item_name, price,
    (SELECT SUM(sales_amount) FROM electronics) AS total_sales_all_items
FROM electronics;

SELECT  item_name, price,(SELECT MAX(price) FROM electronics) AS highest_price
FROM electronics;

SELECT item_name,category,price,
    (SELECT AVG(sales_amount) FROM electronics e2 
     WHERE e2.category = e1.category) AS avg_sales_in_category FROM electronics e1;
     
	-- SUBQUERIES IN FROM
    
SELECT category, AVG(price) AS avg_price
FROM ( SELECT category, price FROM electronics) AS sub GROUP BY category;

SELECT item_name, price
FROM ( SELECT item_name, price FROM electronics) AS e WHERE price > (SELECT AVG(price) FROM electronics);

-- NESTED SUBQUERY

-- Finds the list of Buyers who purchased the most expensive item in the store

SELECT buyer_name
FROM buyers
WHERE item_id = (
    SELECT item_id
    FROM electronics
    WHERE price = (
        SELECT MAX(price) FROM electronics
    )
);

