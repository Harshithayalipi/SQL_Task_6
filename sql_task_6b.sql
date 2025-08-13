USE task4_db;
-- SQL queries with nested logic

-- SUBQUERIES FOR WHERE
-- 1. Single-row subqueries
--  Greater than (>)
SELECT buyer_name, item_id
FROM buyers
WHERE item_id IN (
    SELECT item_id FROM electronics
    WHERE price > (SELECT AVG(price) FROM electronics)
);

--  Less than (<) 
SELECT buyer_name, item_id
FROM buyers
WHERE item_id IN (
    SELECT item_id FROM electronics
    WHERE price < (SELECT AVG(price) FROM electronics)
);

--  Equal to (=) 

SELECT buyer_name, item_id
FROM buyers
WHERE item_id IN (
    SELECT item_id FROM electronics
    WHERE category = (
        SELECT category FROM electronics WHERE item_name = 'Laptop'
    )
);


-- 2. Multi-row subqueries 
--  IN 
SELECT buyer_name, item_id
FROM buyers
WHERE item_id IN (
    SELECT item_id FROM electronics
    WHERE category IN (
        SELECT category FROM electronics WHERE price > 20000
    )
);

--  NOT IN 

SELECT buyer_name, item_id
FROM buyers
WHERE item_id IN (
    SELECT item_id FROM electronics
    WHERE category NOT IN (
        SELECT category FROM electronics WHERE price > 20000
    )
);

-- 3. Correlated subqueries - EXISTS 
SELECT buyer_name, item_id
FROM buyers b
WHERE EXISTS (
    SELECT 1 FROM electronics e
    WHERE e.category = (
        SELECT category FROM electronics WHERE item_id = b.item_id
    )
    AND e.price > 40000
);
