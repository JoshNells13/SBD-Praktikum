USE warung;

-- 1
SELECT * FROM orders ORDER BY order_date DESC;

-- 2
SELECT orders.order_date, orders.order_price, customers.customer_name
FROM orders
    JOIN customers ON orders.customers_customer_ID = customers.customer_ID
WHERE
    orders.order_price > 100000;

-- 3
SELECT COUNT(*) AS total_customer FROM customers;

-- 4
SELECT
    customers_customer_ID,
    SUM(order_price) AS total_pembelian
FROM orders
WHERE
    customers_customer_ID = 4
GROUP BY
    customers_customer_ID;

-- 5
INSERT INTO
    workers (
        worker_ID,
        worker_name,
        worker_job,
        worker_phone,
        worker_mail
    )
VALUES (
        1,
        'Rizky',
        'Kasir',
        '081111111111',
        'rizky@example.com'
    ),
    (
        2,
        'Dimas',
        'Koki',
        '082222222222',
        'dimas@example.com'
    ),
    (
        3,
        'Rina',
        'Pelayan',
        '083333333333',
        'rina@example.com'
    );

-- 6
UPDATE orders SET workers_worker_ID = 1 WHERE order_ID = 1;

UPDATE orders SET workers_worker_ID = 2 WHERE order_ID = 2;

UPDATE orders SET workers_worker_ID = 3 WHERE order_ID = 3;

-- 7
SELECT workers.worker_name, customers.customer_name, orders.*
FROM
    orders
    JOIN workers ON orders.workers_worker_ID = workers.worker_ID
    JOIN customers ON orders.customers_customer_ID = customers.customer_ID;

-- 8
SELECT
    workers.worker_name,
    workers.worker_job,
    COUNT(orders.order_ID) AS total_transaksi,
    SUM(orders.order_price) AS total_penjualan,
    AVG(orders.order_price) AS rata_rata_penjualan
FROM workers
    JOIN orders ON workers.worker_ID = orders.workers_worker_ID
GROUP BY
    workers.worker_ID,
    workers.worker_name,
    workers.worker_job
HAVING
    SUM(orders.order_price) > 100000
ORDER BY total_penjualan DESC;