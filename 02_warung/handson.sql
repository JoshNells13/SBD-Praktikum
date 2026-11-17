USE warung;

-- 1

SELECT * FROM Customers

SELECT
    customer_ID,
    customer_name,
    customer_phone,
    customer_mail
FROM customers

SELECT C.customer_ID, C.customer_name, C.customer_phone, C.customer_mail
FROM customers C

-- 2

SELECT O.*, C.customer_name
FROM orders O, customers C
WHERE
    O.CUSTOMERS_CUSTOMER_ID = C.CUSTOMER_ID

-- 3
SELECT O.order_id, O.order_price
FROM orders O
WHERE
    O.order_price BETWEEN 100000 AND 500000

-- 4
SELECT * FROM customers ORDER BY customer_mail ASC

-- 5
SELECT SUM(ORDER_PRICE) FROM orders

-- 6
SELECT SUM(ORDER_PRICE), CUSTOMERS_CUSTOMER_ID
FROM orders
GROUP BY
    CUSTOMERS_CUSTOMER_ID

-- 7
SELECT o.*, w.worker_name
FROM orders o, workers w
WHERE
    o.workers_worker_ID = w.worker_ID

-- 8
USE warung;

SELECT o.*, w.worker_name
FROM orders o
    INNER JOIN workers w ON o.workers_worker_ID = w.worker_ID
WHERE
    w.worker_ID = 3;

SELECT o.*, w.worker_name
FROM orders o
    INNER JOIN workers w ON o.workers_worker_ID = w.worker_ID
WHERE
    w.worker_name LIKE '%Rina%'
    AND o.order_date > 2027 - 01 -01