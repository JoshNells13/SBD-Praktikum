CREATE DATABASE laboratorium;

USE laboratorium;

-- 1

CREATE TABLE mahasiswa (
    mahasiswa_id CHAR(6) PRIMARY KEY,
    nama_mahasiswa VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    status_aktif BOOLEAN
);

CREATE TABLE petugas (
    petugas_id VARCHAR(6) PRIMARY KEY,
    nama_petugas VARCHAR(100),
    email_petugas VARCHAR(100) UNIQUE
);

CREATE TABLE ruang_laboratorium (
    ruang_id CHAR(6) PRIMARY KEY,
    nama_ruang VARCHAR(100),
    gedung VARCHAR(50),
    lantai INT
);

CREATE TABLE peminjaman (
    peminjaman_id CHAR(6) PRIMARY KEY,
    tanggal_pinjam DATE,
    batas_kembali DATE,
    tanggal_pengembalian DATE NULL,
    mahasiswa_mahasiswa_id CHAR(6),
    petugas_petugas_id VARCHAR(6),
    FOREIGN KEY (mahasiswa_mahasiswa_id) REFERENCES mahasiswa (mahasiswa_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (petugas_petugas_id) REFERENCES petugas (petugas_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE pemasok (
    pemasok_id CHAR(6) PRIMARY KEY,
    nama_pemasok VARCHAR(100),
    telepon VARCHAR(20),
    email_pemasok VARCHAR(100) NULL
);

CREATE TABLE kategori_alat (
    kategori_id CHAR(6) PRIMARY KEY,
    nama_kategori VARCHAR(50)
);

CREATE TABLE alat (
    alat_id CHAR(6) PRIMARY KEY,
    nama_alat VARCHAR(100),
    kondisi VARCHAR(20),
    status_alat VARCHAR(20),
    tanggal_pengadaan DATE NULL,
    kategori_alat_kategori_id CHAR(6),
    ruang_laboratorium_ruang_id CHAR(6),
    pemasok_pemasok_id CHAR(6),
    FOREIGN KEY (kategori_alat_kategori_id) REFERENCES kategori_alat (kategori_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (ruang_laboratorium_ruang_id) REFERENCES ruang_laboratorium (ruang_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (pemasok_pemasok_id) REFERENCES pemasok (pemasok_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE detail_peminjaman (
    peminjaman_peminjaman_id CHAR(6),
    alat_alat_id CHAR(6),
    PRIMARY KEY (
        peminjaman_peminjaman_id,
        alat_alat_id
    ),
    FOREIGN KEY (peminjaman_peminjaman_id) REFERENCES peminjaman (peminjaman_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (alat_alat_id) REFERENCES alat (alat_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 2

ALTER TABLE alat
ADD COLUMN lokasi_penyimpanan VARCHAR(50) NOT NULL DEFAULT 'belum ditemukan';

-- 3

CREATE TABLE perawatan (
    perawatan_id CHAR(6) PRIMARY KEY,
    alat_id CHAR(6) NOT NULL,
    tanggal_perawatan DATE NOT NULL,
    deskripsi VARCHAR(255) NOT NULL,
    biaya INT NOT NULL,
    FOREIGN KEY (alat_id) REFERENCES alat (alat_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 4

INSERT INTO
    mahasiswa (
        mahasiswa_id,
        nama_mahasiswa,
        email,
        status_aktif
    )
VALUES (
        'MHS001',
        'Alya Putri',
        'alya@example.com',
        TRUE
    ),
    (
        'MHS002',
        'Farhan Maulana',
        'farhan@example.com',
        TRUE
    );

INSERT INTO
    petugas (
        petugas_id,
        nama_petugas,
        email_petugas
    )
VALUES (
        'PTG001',
        'Budi Santoso',
        'budi@example.com'
    );

INSERT INTO
    kategori_alat (kategori_id, nama_kategori)
VALUES ('KTG001', 'Elektronik'),
    ('KTG002', 'Mekanik'),
    ('KTG004', 'Audio');

INSERT INTO
    ruang_laboratorium (
        ruang_id,
        nama_ruang,
        gedung,
        lantai
    )
VALUES (
        'RNG001',
        'Ruang Instrumentasi',
        'Gedung Laboratorium A',
        1
    ),
    (
        'RNG002',
        'Ruang Mekanik',
        'Gedung Laboratorium A',
        2
    );

INSERT INTO
    pemasok (
        pemasok_id,
        nama_pemasok,
        telepon,
        email_pemasok
    )
VALUES (
        'PMS001',
        'Pemasok Instrumentasi',
        '0215550101',
        'pemasok01@example.com'
    ),
    (
        'PMS002',
        'Pemasok Mekanik',
        '0215550102',
        NULL
    );

INSERT INTO
    alat (
        alat_id,
        nama_alat,
        kategori_alat_kategori_id,
        ruang_laboratorium_ruang_id,
        pemasok_pemasok_id,
        kondisi,
        status_alat,
        tanggal_pengadaan
    )
VALUES (
        'ALT001',
        'Multimeter Digital',
        'KTG001',
        'RNG001',
        'PMS001',
        'Baik',
        'Dipinjam',
        '2025-08-01'
    ),
    (
        'ALT002',
        'Osiloskop',
        'KTG001',
        'RNG001',
        'PMS001',
        'Baik',
        'Tersedia',
        '2025-08-02'
    ),
    (
        'ALT004',
        'Jangka Sorong',
        'KTG002',
        'RNG002',
        'PMS002',
        'Baik',
        'Tersedia',
        '2025-09-10'
    ),
    (
        'ALT005',
        'Timbangan Digital',
        'KTG001',
        'RNG001',
        'PMS001',
        'Rusak Ringan',
        'Perawatan',
        '2025-11-30'
    );

INSERT INTO
    peminjaman (
        peminjaman_id,
        mahasiswa_mahasiswa_id,
        petugas_petugas_id,
        tanggal_pinjam,
        batas_kembali,
        tanggal_pengembalian
    )
VALUES (
        'PJM001',
        'MHS001',
        'PTG001',
        '2026-10-01',
        '2026-10-08',
        NULL
    ),
    (
        'PJM002',
        'MHS002',
        'PTG001',
        '2026-09-20',
        '2026-09-27',
        '2026-09-26'
    );

INSERT INTO
    detail_peminjaman (
        peminjaman_peminjaman_id,
        alat_alat_id
    )
VALUES ('PJM001', 'ALT001'),
    ('PJM002', 'ALT004');

-- 5

INSERT INTO
    alat (
        alat_id,
        nama_alat,
        kategori_alat_kategori_id,
        ruang_laboratorium_ruang_id,
        pemasok_pemasok_id,
        kondisi,
        status_alat,
        tanggal_pengadaan,
        lokasi_penyimpanan
    )
VALUES (
        'ALT007',
        'Sensor Suhu Digital',
        'KTG001',
        'RNG001',
        'PMS001',
        'Baik',
        'Tersedia',
        '2026-10-13',
        'Lemari Elektronik B'
    );

-- 6

INSERT INTO
    peminjaman (
        peminjaman_id,
        mahasiswa_mahasiswa_id,
        petugas_petugas_id,
        tanggal_pinjam,
        batas_kembali,
        tanggal_pengembalian
    )
VALUES (
        'PJM004',
        'MHS002',
        'PTG001',
        '2026-10-20',
        NULL,
        NULL
    );

INSERT INTO
    detail_peminjaman (
        peminjaman_peminjaman_id,
        alat_alat_id
    )
VALUES ('PJM004', 'ALT007');

UPDATE alat SET status_alat = 'Dipinjam' WHERE alat_id = 'ALT007';

-- 7. Perawatan alat

INSERT INTO
    perawatan (
        perawatan_id,
        alat_id,
        tanggal_perawatan,
        deskripsi,
        biaya
    )
VALUES (
        'PRW001',
        'ALT007',
        '2026-10-13',
        'Perbaikan Sensor Dan Kalibrasi Ulang',
        75000
    );

UPDATE alat SET kondisi = 'Baik' WHERE alat_id = 'ALT005';

UPDATE alat SET status_alat = 'Tersedia' WHERE alat_id = 'ALT005';

-- 8

UPDATE peminjaman
SET
    batas_kembali = DATE_ADD(batas_kembali, INTERVAL 7 DAY)
WHERE
    peminjaman_id = 'PJM001';

-- 9

DELETE FROM alat WHERE alat_id = 'ALT002';

-- 10

ALTER TABLE mahasiswa MODIFY COLUMN nama_mahasiswa VARCHAR(150);

-- 11

ALTER TABLE alat ADD COLUMN catatan_sementara VARCHAR(100) NULL;

-- 12

ALTER TABLE alat DROP COLUMN catatan_sementara;

-- Tes Drop
DROP DATABASE laboratorium