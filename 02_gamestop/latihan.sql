CREATE DATABASE gamestop2

USE gamestop2

-- 1
CREATE TABLE game (
    G_id CHAR(5) PRIMARY KEY,
    G_title VARCHAR(100),
    G_release_date DATE,
    G_rating VARCHAR(10),
    G_price INT,
    G_stock INT
);

CREATE TABLE staff (
    S_id CHAR(5) PRIMARY KEY,
    S_name VARCHAR(100),
    S_email VARCHAR(100),
    S_gender CHAR(1),
    S_position VARCHAR(50),
    S_address VARCHAR(100)
);

CREATE TABLE tags (
    tag_id CHAR(5) PRIMARY KEY,
    tag_name VARCHAR(50),
    tag_description VARCHAR(250)
);

CREATE TABLE customer (
    C_id CHAR(5) PRIMARY KEY,
    C_name VARCHAR(100),
    C_email VARCHAR(100),
    C_gender CHAR(1),
    C_number VARCHAR(15),
    C_address VARCHAR(100)
);

CREATE TABLE transaction (
    T_id CHAR(5) PRIMARY KEY,
    T_date DATE,
    T_method VARCHAR(20),
    FOREIGN KEY (customer_id) ON REFERENCES customer (C_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (staff_id) REFERENCES staff (S_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE transaction_detail (
    PRIMARY KEY (transaction_id, game_id),
    FOREIGN KEY (transaction_id) REFERENCES transaction (T_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (game_id) REFERENCES game (G_id) ON UPDATE CASCADE ON DELETE CASCADE,
    quantity INT,
    total_price INT
);

CREATE TABLE phone_number (
    S_pnumber VARCHAR(15) PRIMARY KEY,
    FOREIGN KEY (staff_id) REFERENCES staff (S_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE game_tags (
    FOREIGN KEY (tags_id) REFERENCES tags (tag_id) PRIMARY KEY ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (game_id) REFERENCES game (G_id) PRIMARY KEY ON UPDATE CASCADE ON DELETE CASCADE
)

-- 2 Dan
CREATE TABLE developer (
    D_id CHAR(5) PRIMARY KEY,
    D_name VARCHAR(100) NOT NULL,
    D_country VARCHAR(50) NOT NULL
)

ALTER TABLE game ADD COLUMN developer_id CHAR(5)

-- 3
DROP TABLE phone_number

ALTER TABLE staff ADD COLUMN S_pnumber VARCHAR(15) NOT NULL

-- 4
ALTER TABLE customer ADD COLUMN C_joindate DATE

-- 5

INSERT INTO
    customer (
        C_id,
        C_name,
        C_email,
        C_gender,
        C_number,
        C_address
    )
VALUES (
        'C0001',
        'alice',
        'alice@example.com',
        'F',
        '(555) 010-1234',
        '123 Maple St,IL'
    ),
    (
        'C0002',
        'Ben',
        'ben@example.com',
        'F',
        '(555) 011-6789',
        '321 Birch Blvd,WI'
    ),
    (
        'C0003',
        'Choloe',
        'chloe@example.com',
        'F',
        '(555) 012-3456',
        '654 Cedar Ct,TX'
    )

--6
ALTER TABLE game
ADD FOREIGN KEY (developer_id) REFERENCES developer (D_id)

-- 7
INSERT INTO
    staff (
        S_email,
        S_gender,
        S_position,
        S_pnumber,
        S_address,
    )
VALUES (
        'fiona@example.com',
        'F',
        'Cashier',
        '(555) 016-3456',
        'address: 420 Thick Fein,LS',
    )

-- 8
UPDATE game SET G_price = G_price * 0.70 WHERE g_rating = '3+',

--9