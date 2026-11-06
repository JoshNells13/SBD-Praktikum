-- Buat database
CREATE DATABASE IF NOT EXISTS gamestop;

USE gamestop;

-- 1. Buat tabel awal
CREATE TABLE customer (
    C_id CHAR(5) PRIMARY KEY,
    C_name VARCHAR(100),
    C_email VARCHAR(100),
    C_gender CHAR(1),
    C_pnumber VARCHAR(15),
    C_address VARCHAR(100)
);

CREATE TABLE staff (
    S_id CHAR(5) PRIMARY KEY,
    S_name VARCHAR(100),
    S_email VARCHAR(100),
    S_gender CHAR(1),
    S_position VARCHAR(50),
    S_address VARCHAR(100)
);

CREATE TABLE phone_number (
    S_pnumber VARCHAR(15) PRIMARY KEY,
    staff_id CHAR(5),
    FOREIGN KEY (staff_id) REFERENCES staff (S_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE game (
    G_id CHAR(5) PRIMARY KEY,
    G_title VARCHAR(100),
    G_release_date DATE,
    G_rating VARCHAR(10),
    G_price INT,
    G_stock INT
);

CREATE TABLE tags (
    tag_id CHAR(5) PRIMARY KEY,
    tag_name VARCHAR(50),
    tag_description VARCHAR(250)
);

CREATE TABLE game_tags (
    tags_id CHAR(5),
    game_id CHAR(5),
    PRIMARY KEY (tags_id, game_id),
    FOREIGN KEY (tags_id) REFERENCES tags (tag_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (game_id) REFERENCES game (G_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE transaction (
    T_id CHAR(5) PRIMARY KEY,
    T_date DATE,
    T_method VARCHAR(20),
    customer_id CHAR(5),
    staff_id CHAR(5),
    FOREIGN KEY (customer_id) REFERENCES customer (C_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (staff_id) REFERENCES staff (S_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE transaction_detail (
    transaction_id CHAR(5),
    game_id CHAR(5),
    quantity INT,
    total_price INT,
    PRIMARY KEY (transaction_id, game_id),
    FOREIGN KEY (transaction_id) REFERENCES transaction (T_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (game_id) REFERENCES game (G_id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- 2. Buat tabel developer & tambah developer_id ke game
CREATE TABLE developer (
    D_id CHAR(5) PRIMARY KEY,
    D_name VARCHAR(100) NOT NULL,
    D_country VARCHAR(50) NOT NULL
);

ALTER TABLE game ADD COLUMN developer_id CHAR(5);

-- 3. Hapus phone_number & tambah S_pnumber ke staff
DROP TABLE phone_number;

ALTER TABLE staff ADD COLUMN S_pnumber VARCHAR(15) NOT NULL;

-- 4. Tambah C_joindate ke customer
ALTER TABLE customer ADD COLUMN C_joindate DATE;

-- 6. Tambah FK developer ke game
ALTER TABLE game
ADD CONSTRAINT fk_game_developer FOREIGN KEY (developer_id) REFERENCES developer (D_id) ON UPDATE CASCADE ON DELETE CASCADE;

-- 5. Insert data awal
INSERT INTO
    developer (D_id, D_name, D_country)
VALUES ('D0001', 'Activision', 'USA'),
    (
        'D0002',
        'EA Sports',
        'Canada'
    ),
    ('D0003', 'Avalanche', 'UK'),
    (
        'D0004',
        'Arrowhead',
        'Sweden'
    ),
    (
        'D0005',
        'Firewalk Studio',
        'USA'
    );

INSERT INTO
    customer (
        C_id,
        C_name,
        C_email,
        C_gender,
        C_pnumber,
        C_address,
        C_joindate
    )
VALUES (
        'C0001',
        'Alice',
        'alice@example.com',
        'F',
        '(555) 010-1234',
        '123 Maple St, IL',
        '2023-12-01'
    ),
    (
        'C0002',
        'Ben',
        'ben@example.com',
        'M',
        '(555) 011-6789',
        '321 Birch Blvd, WI',
        '2023-12-02'
    ),
    (
        'C0003',
        'Chloe',
        'chloe@example.com',
        'F',
        '(555) 012-3456',
        '654 Cedar Ct, TX',
        '2023-12-03'
    ),
    (
        'C0004',
        'Daniel',
        'daniel@example.com',
        'M',
        '(555) 013-8901',
        '246 Willow Way, OR',
        '2023-12-04'
    ),
    (
        'C0005',
        'Ethan',
        'ethan@example.com',
        'M',
        '(555) 014-9012',
        '147 Maplewood Ln, GA',
        '2023-12-05'
    );

INSERT INTO
    staff (
        S_id,
        S_name,
        S_email,
        S_pnumber,
        S_address,
        S_position,
        S_gender
    )
VALUES (
        'S0001',
        'Adam',
        'adam@example.com',
        '(555) 010-5678',
        '456 Oak Ave, NE',
        'Cashier',
        'M'
    ),
    (
        'S0002',
        'Bella',
        'bella@example.com',
        '(555) 011-2345',
        '789 Pine Rd, OH',
        'Cashier',
        'F'
    ),
    (
        'S0003',
        'Charlie',
        'charlie@example.com',
        '(555) 012-7890',
        '987 Elm St, CO',
        'Database Engineer',
        'M'
    ),
    (
        'S0004',
        'Daisy',
        'daisy@example.com',
        '(555) 013-4567',
        '135 Spruce Pl, WA',
        'Customer Service Rep',
        'F'
    ),
    (
        'S0005',
        'Emma',
        'emma@example.com',
        '(555) 014-5678',
        '369 Ash Dr, TN',
        'Content Writer',
        'F'
    );

INSERT INTO
    game (
        G_id,
        G_title,
        G_release_date,
        G_rating,
        G_price,
        G_stock,
        developer_id
    )
VALUES (
        'G0001',
        'Call of Duty: Black Ops 6',
        '2024-10-25',
        '18+',
        1040000,
        2,
        'D0001'
    ),
    (
        'G0002',
        'F1 24',
        '2024-05-31',
        '3+',
        759000,
        11,
        'D0002'
    ),
    (
        'G0003',
        'Hogwarts Legacy',
        '2023-02-11',
        '13+',
        799000,
        9,
        'D0003'
    ),
    (
        'G0004',
        'FC 25',
        '2024-09-27',
        '3+',
        799000,
        32,
        'D0002'
    ),
    (
        'G0005',
        'HELLDIVERS II',
        '2024-02-08',
        '18+',
        579000,
        20,
        'D0004'
    ),
    (
        'G0006',
        'Concord',
        '2024-08-23',
        '13+',
        579000,
        10,
        'D0005'
    );

INSERT INTO
    tags (
        tag_id,
        tag_name,
        tag_description
    )
VALUES (
        'T01',
        'Action',
        'Fast-paced gameplay requiring quick reflexes and combat skills.'
    ),
    (
        'T02',
        'Horror',
        'Focuses on creating fear and tension through unsettling atmospheres and scares.'
    ),
    (
        'T03',
        'Puzzle',
        'Challenges players to solve problems and riddles using logic and critical thinking.'
    ),
    (
        'T04',
        'RPG',
        'Players assume character roles, developing skills and engaging in storytelling.'
    ),
    (
        'T05',
        'Sports',
        'Involves competitive gameplay based on real or fictional sports, emphasizing skill, strategy, and teamwork.'
    );

INSERT INTO
    game_tags (tags_id, game_id)
VALUES ('T01', 'G0001'),
    ('T01', 'G0005'),
    ('T01', 'G0006'),
    ('T01', 'G0003'),
    ('T04', 'G0003'),
    ('T05', 'G0002'),
    ('T05', 'G0004');

INSERT INTO
    transaction (
        T_id,
        T_date,
        T_method,
        customer_id,
        staff_id
    )
VALUES (
        'T0001',
        '2024-01-01',
        'Cash',
        'C0001',
        'S0001'
    ),
    (
        'T0002',
        '2024-01-02',
        'Cash',
        'C0002',
        'S0001'
    ),
    (
        'T0003',
        '2024-01-02',
        'QRIS',
        'C0003',
        'S0001'
    ),
    (
        'T0004',
        '2024-01-09',
        'Debit',
        'C0004',
        'S0002'
    ),
    (
        'T0005',
        '2024-01-13',
        'Credit',
        'C0005',
        'S0002'
    );

INSERT INTO
    transaction_detail (
        transaction_id,
        game_id,
        quantity,
        total_price
    )
VALUES ('T0001', 'G0001', 1, 1040000),
    ('T0002', 'G0002', 1, 759000),
    ('T0003', 'G0003', 1, 799000),
    ('T0004', 'G0004', 2, 1598000),
    ('T0005', 'G0005', 2, 1158000);

-- 7. Tambah kolom join date & insert staff Fiona
ALTER TABLE staff ADD COLUMN S_joindate DATE;

INSERT INTO
    staff (
        S_id,
        S_name,
        S_email,
        S_pnumber,
        S_address,
        S_position,
        S_gender,
        S_joindate
    )
VALUES (
        'S0006',
        'Fiona',
        'fiona@example.com',
        '(555) 016-3456',
        '420 Thick Fein, LS',
        'Cashier',
        'F',
        '2024-01-10'
    );

-- 8. Diskon 30% game rating 3+
UPDATE game SET G_price = G_price * 0.70 WHERE G_rating = '3+';

-- 9. Transaksi pembelian Hogwarts Legacy oleh Ethan
INSERT INTO
    transaction (
        T_id,
        T_date,
        T_method,
        customer_id,
        staff_id
    )
VALUES (
        'T0006',
        '2024-11-01',
        'Cash',
        'C0005',
        'S0001'
    );

INSERT INTO
    transaction_detail (
        transaction_id,
        game_id,
        quantity,
        total_price
    )
VALUES (
        'T0006',
        'G0003',
        9,
        9 * 799000
    );

UPDATE game SET G_stock = 0 WHERE G_id = 'G0003';

-- 10. Update posisi Fiona
UPDATE staff
SET
    S_position = 'Database Engineer'
WHERE
    S_name = 'Fiona';

-- 11. Hapus game Concord
DELETE FROM game WHERE G_title = 'Concord';

-- 12. Hapus database
DROP DATABASE gamestop;