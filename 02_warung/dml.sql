USE warung;

-- 1
INSERT INTO
    customers (
        customer_ID,
        customer_name,
        customer_phone,
        customer_mail
    )
VALUES (
        1,
        'Andi',
        '081234567890',
        'andi@example.com'
    ),
    (
        2,
        'Budi',
        '082345678901',
        'budi@example.com'
    ),
    (
        3,
        'Sofi',
        '012345678901',
        'sofi@example.com'
    ),
    (
        4,
        'Budi',
        '098765432109',
        'budiman@example.com'
    );

-- 2
UPDATE customers
SET
    customer_phone = '090908765412'
WHERE
    customer_ID = 2;

-- 3
UPDATE customers
SET
    customer_phone = '012308765412'
WHERE
    customer_name = 'Budi';

-- 4
DELETE FROM customers WHERE customer_ID = 1;

-- 5
DELETE FROM customers WHERE customer_name = 'Budi';