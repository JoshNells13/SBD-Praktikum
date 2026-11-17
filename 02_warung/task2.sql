USE warung;

-- 1 Tampilkan daftar Order dan nama pegawai yang menangani
-- ID Dan Nama
SELECT o.*, w.worker_name
FROM orders o
    INNER JOIN workers w ON o.workers_worker_ID = w.worker_ID
WHERE
    w.worker_ID = 2;

SELECT o.*, w.worker_name
FROM orders o
    INNER JOIN workers w ON o.workers_worker_ID = w.worker_ID
WHERE
    w.worker_name LIKE '%Rina%'
    AND o.order_date > 2027 - 01 -01

-- 2 Data Tertinggi Dan Terendah
SELECT MAX(order_price) AS "Pembayaran Tertinggi", MIN(order_price) AS "Pembayaran Terendah"
FROM orders

-- 3 Tampilkan Jumlah Order Dari Masing2 Di tangani Worker
SELECT o.workers_worker_ID, SUM(order_ID) AS "Jumlah Ditangani"
FROM orders o
GROUP BY
    o.workers_worker_ID

-- Kalau Nama
SELECT w.worker_name, SUM(order_ID) AS "Jumlah Ditangani"
FROM orders o
    INNER JOIN workers w ON o.workers_worker_ID = w.worker_ID
GROUP BY
    w.worker_name,
    w.worker_ID

-- 4
USE warung;

SELECT
    O.workers_worker_ID,
    COUNT(O.order_ID) AS `Jumlah Order`,
    COUNT(O.order_ID) * 10000 AS `Komisi`
FROM
    orders O
    INNER JOIN menu_orders MO ON O.order_ID = MO.orders_order_ID
    INNER JOIN menu M ON MO.menu_menu_ID = M.menu_ID
WHERE
    M.menu_name = 'Gurame Bakar Premium'
GROUP BY
    O.workers_worker_ID;