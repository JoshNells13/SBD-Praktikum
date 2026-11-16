CREATE DATABASE warung

USE warung

-- 1
CREATE TABLE people ( people_id INT, people_name VARCHAR(255) );
-- 2
RENAME TABLE people TO customers;
-- 3
DROP TABLE customers;
-- 4
CREATE TABLE customers (
    customer_ID INT,
    customer_name VARCHAR(255) NOT NULL,
    customer_phone VARCHAR(16) NOT NULL,
    customer_mail VARCHAR(255) NOT NULL
);

ALTER TABLE customers ADD address VARCHAR(255);

-- 5
ALTER TABLE customers RENAME COLUMN address TO customer_address;

-- 6
ALTER TABLE customers MODIFY customer_address VARCHAR(16);
-- 7
ALTER TABLE customers ADD PRIMARY KEY (customer_ID);

-- 8
CREATE TABLE orders (
    order_ID INT PRIMARY KEY,
    order_date TIMESTAMP NOT NULL,
    order_price INT NOT NULL,
    order_payment VARCHAR(255) NOT NULL,
    customers_customer_ID INT,
    workers_worker_ID INT
);

CREATE TABLE workers (
    worker_ID INT PRIMARY KEY,
    worker_name VARCHAR(255) NOT NULL,
    worker_job VARCHAR(255) NOT NULL,
    worker_phone VARCHAR(255) NOT NULL,
    worker_mail VARCHAR(255) NOT NULL
);

-- 9
ALTER TABLE orders
ADD FOREIGN KEY (customers_customer_ID) REFERENCES customers (customer_ID);

-- 10
ALTER TABLE orders
ADD FOREIGN KEY (workers_worker_ID) REFERENCES workers (worker_ID);
-- 11
CREATE TABLE menu (
    menu_ID INT PRIMARY KEY,
    menu_name VARCHAR(255) NOT NULL,
    menu_description VARCHAR(255),
    menu_price INT NOT NULL
);

CREATE TABLE menu_orders (
    menu_orders_ID INT PRIMARY KEY,
    menu_menu_ID INT,
    orders_order_ID INT,
    amount INT NOT NULL,
    FOREIGN KEY (menu_menu_ID) REFERENCES menu (menu_ID),
    FOREIGN KEY (orders_order_ID) REFERENCES orders (order_ID)
);