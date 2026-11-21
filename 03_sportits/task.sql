USE sportits;

-- 1
SELECT P.nama, P.nrp, P.prodi, T.nama AS nama_tim
FROM peserta P
    JOIN tim T ON P.tim_id = T.id
WHERE
    P.prodi = 'Teknik Informatika';

-- 2
SELECT P.id, P.nama, P.divisi
FROM panitia P
    JOIN jadwal_kompetisi J ON P.jadwal_kompetisi_id = J.id
WHERE
    J.lokasi = 'Stadion ITS Sukolilo';

-- 3
SELECT DISTINCT
    T.nama AS nama_tim
FROM
    registrasi R
    JOIN tim T ON R.tim_id = T.id
    JOIN its_sport_competition ISC ON R.its_sport_competition_id = ISC.id
WHERE
    ISC.nama = 'Futsal';

-- 4
SELECT
    ISC.nama AS nama_kompetisi,
    SUM(ISP.nominal_sponsor) AS total_nominal_sponsor
FROM
    its_sport_competition ISC
    JOIN its_sponsor ISP ON ISC.id = ISP.its_sport_competition_id
GROUP BY
    ISC.id,
    ISC.nama;

SELECT
    ISC.nama AS nama_kompetisi,
    SUM(ISP.nominal_sponsor) AS total_nominal_sponsor
FROM
    its_sport_competition ISC
    JOIN its_sponsor ISP ON ISC.id = ISP.its_sport_competition_id
GROUP BY
    ISC.id,
    ISC.nama
ORDER BY total_nominal_sponsor DESC;

-- 5
SELECT R.id AS id_registrasi, T.nama AS nama_tim, R.waktu_registrasi
FROM registrasi R
    JOIN tim T ON R.tim_id = T.id
ORDER BY R.waktu_registrasi;

SELECT R.id AS id_registrasi, T.nama AS nama_tim, R.waktu_registrasi
FROM registrasi R
    JOIN tim T ON R.tim_id = T.id
WHERE
    R.waktu_registrasi BETWEEN '2026-10-10 00:00:00' AND '2026-10-16 23:59:59'
ORDER BY R.waktu_registrasi;

-- 6
SELECT
    J.lokasi AS nama_lokasi,
    COUNT(DISTINCT J.id) AS jumlah_pertandingan
FROM jadwal_kompetisi J
    JOIN panitia P ON J.id = P.jadwal_kompetisi_id
WHERE
    P.divisi = 'Acara'
GROUP BY
    J.lokasi;

SELECT
    J.lokasi AS nama_lokasi,
    COUNT(DISTINCT J.id) AS jumlah_pertandingan
FROM jadwal_kompetisi J
    JOIN panitia P ON J.id = P.jadwal_kompetisi_id
WHERE
    P.divisi = 'Acara'
GROUP BY
    J.lokasi
HAVING
    COUNT(DISTINCT J.id) > 1
ORDER BY jumlah_pertandingan DESC;

-- 7
SELECT
    ISC.nama AS nama_kompetisi,
    ISC.slot_tim,
    T.nama AS nama_tim,
    R.waktu_registrasi
FROM
    registrasi R
    JOIN tim T ON R.tim_id = T.id
    JOIN its_sport_competition ISC ON R.its_sport_competition_id = ISC.id
WHERE
    ISC.slot_tim <= 20;

SELECT
    ISC.nama AS nama_kompetisi,
    ISC.slot_tim,
    T.nama AS nama_tim,
    R.waktu_registrasi
FROM
    registrasi R
    JOIN tim T ON R.tim_id = T.id
    JOIN its_sport_competition ISC ON R.its_sport_competition_id = ISC.id
WHERE
    ISC.slot_tim <= 20
    AND R.waktu_registrasi >= '2026-10-10 00:00:00'
ORDER BY R.waktu_registrasi ASC;

-- 8
SELECT
    ISC.nama AS nama_kompetisi,
    ROUND(
        COUNT(R.id) * 100.0 / ISC.slot_tim,
        2
    ) AS fulfillment,
    ISC.slot_tim - COUNT(R.id) AS sisa_slot
FROM
    its_sport_competition ISC
    LEFT JOIN registrasi R ON ISC.id = R.its_sport_competition_id
    AND R.waktu_registrasi BETWEEN '2026-10-10 00:00:00' AND '2026-10-20 23:59:59'
GROUP BY
    ISC.id,
    ISC.nama,
    ISC.slot_tim;

WITH
    daily_fulfillment AS (
        SELECT
            DATE(R.waktu_registrasi) AS waktu,
            ISC.id AS kompetisi_id,
            ISC.slot_tim,
            COUNT(R.id) * 100.0 / ISC.slot_tim AS fulfillment
        FROM
            registrasi R
            JOIN its_sport_competition ISC ON R.its_sport_competition_id = ISC.id
        WHERE
            R.waktu_registrasi BETWEEN '2026-10-10 00:00:00' AND '2026-10-20 23:59:59'
        GROUP BY
            DATE(R.waktu_registrasi),
            ISC.id,
            ISC.slot_tim
    )
SELECT waktu, ROUND(AVG(fulfillment), 2) AS average_fulfillment
FROM daily_fulfillment
GROUP BY
    waktu
ORDER BY waktu ASC;

-- 9
SELECT J.id, J.waktu_mulai, J.waktu_akhir, J.nama_tim_1, J.nama_tim_2, J.lokasi
FROM jadwal_kompetisi J
WHERE
    J.lokasi LIKE 'Lapangan%'
    AND (
        EXISTS (
            SELECT 1
            FROM peserta P
                JOIN tim T ON P.tim_id = T.id
            WHERE
                T.nama = J.nama_tim_1
                AND P.prodi LIKE 'Teknik%'
        )
        OR EXISTS (
            SELECT 1
            FROM peserta P
                JOIN tim T ON P.tim_id = T.id
            WHERE
                T.nama = J.nama_tim_2
                AND P.prodi LIKE 'Teknik%'
        )
    );

-- 10
WITH
    total_sponsor AS (
        SELECT
            its_sport_competition_id,
            SUM(nominal_sponsor) AS total
        FROM its_sponsor
        GROUP BY
            its_sport_competition_id
    )
SELECT
    S.id AS id_sponsor,
    S.nama_pic AS nama_pic_sponsor,
    COALESCE(
        CASE
        -- Kondisi 1: Sponsor sudah pernah mensponsori kompetisi
            WHEN EXISTS (
                SELECT 1
                FROM its_sponsor IS2
                WHERE
                    IS2.sponsor_id = S.id
            ) THEN (
                SELECT ISC.nama
                FROM
                    its_sport_competition ISC
                    JOIN total_sponsor TS ON ISC.id = TS.its_sport_competition_id
                ORDER BY TS.total ASC, ISC.nama ASC
                LIMIT 1
            )
            -- Kondisi 2: Sponsor belum pernah mensponsori kompetisi
            ELSE (
                SELECT ISC.nama
                FROM its_sport_competition ISC
                WHERE
                    NOT EXISTS (
                        SELECT 1
                        FROM its_sponsor IS2
                        WHERE
                            IS2.its_sport_competition_id = ISC.id
                    )
                ORDER BY ISC.tgl_mulai ASC, ISC.nama ASC
                LIMIT 1
            )
        END,
        'Tidak ada kompetisi'
    ) AS rekomendasi_kompetisi
FROM sponsor S;