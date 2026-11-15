-- =====================================================================
-- DDL Data Warehouse Pembelian (Purchasing) - Kelompok 10
-- Kompatibel: XAMPP / MariaDB / MySQL (Idempotent)
-- =====================================================================

CREATE DATABASE IF NOT EXISTS dwh_kelompok_10;
USE dwh_kelompok_10;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- Hapus tabel lama jika sudah ada
DROP TABLE IF EXISTS fact_pembelian;
DROP TABLE IF EXISTS dim_produk;
DROP TABLE IF EXISTS dim_vendor;
DROP TABLE IF EXISTS dim_metode_kirim;
DROP TABLE IF EXISTS dim_karyawan;
DROP TABLE IF EXISTS dim_tanggal;

SET FOREIGN_KEY_CHECKS = 1;

-- =====================================================================
-- 1. DIMENSI TANGGAL (12 Kolom Standar Resmi Dosen)
-- =====================================================================
CREATE TABLE dim_tanggal (
    tanggal_key          INT          NOT NULL PRIMARY KEY,  -- format YYYYMMDD, -1 = tidak diketahui
    tanggal              DATE         NOT NULL UNIQUE,
    tahun                INT          NOT NULL,
    semester             INT          NOT NULL,     -- 1 = Jan-Jun, 2 = Jul-Des
    kuartal              INT          NOT NULL,     -- 1 s.d. 4
    bulan                INT          NOT NULL,     -- 1 s.d. 12
    nama_bulan           VARCHAR(15)  NOT NULL,     -- Januari ... Desember
    minggu_dalam_tahun   INT          NOT NULL,     -- minggu ISO 8601, 1 s.d. 53
    tanggal_dalam_bulan  INT          NOT NULL,     -- 1 s.d. 31
    hari_dalam_minggu    INT          NOT NULL,     -- Senin = 1 ... Minggu = 7
    nama_hari            VARCHAR(15)  NOT NULL,     -- Senin ... Minggu
    is_akhir_pekan       BOOLEAN      NOT NULL      -- 1 untuk Sabtu dan Minggu
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4
  COMMENT = 'Dimensi tanggal standar kelas DW, versi 1.0';

-- Pemuatan otomatis satu baris per hari (2010-01-01 s.d. 2015-12-31) Kompatibel XAMPP
INSERT INTO dim_tanggal (
    tanggal_key, tanggal, tahun, semester, kuartal, bulan, nama_bulan,
    minggu_dalam_tahun, tanggal_dalam_bulan, hari_dalam_minggu, nama_hari, is_akhir_pekan
)
SELECT
    CAST(DATE_FORMAT(t.d, '%Y%m%d') AS UNSIGNED),
    t.d,
    YEAR(t.d),
    IF(MONTH(t.d) <= 6, 1, 2),
    QUARTER(t.d),
    MONTH(t.d),
    ELT(MONTH(t.d), 'Januari','Februari','Maret','April','Mei','Juni','Juli',
                  'Agustus','September','Oktober','November','Desember'),
    WEEK(t.d, 3),
    DAY(t.d),
    WEEKDAY(t.d) + 1,
    ELT(WEEKDAY(t.d) + 1, 'Senin','Selasa','Rabu','Kamis','Jumat','Sabtu','Minggu'),
    IF(WEEKDAY(t.d) >= 5, 1, 0)
FROM (
    SELECT DATE_ADD('2010-01-01',
                    INTERVAL (a.n + 10*b.n + 100*c.n + 1000*e.n) DAY) AS d
    FROM (SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
          UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) a
    CROSS JOIN (SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
          UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) b
    CROSS JOIN (SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
          UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) c
    CROSS JOIN (SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
          UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) e
) t
WHERE t.d <= '2015-12-31'
ORDER BY t.d;

-- Baris "Tidak diketahui" untuk fakta yang tanggalnya kosong
INSERT INTO dim_tanggal VALUES
    (-1, '1900-01-01', 0, 0, 0, 0, 'Tidak diketahui', 0, 0, 0, 'Tidak diketahui', FALSE);

-- =====================================================================
-- 2. TABEL DIMENSI LAINNYA
-- =====================================================================

-- 2.1 dim_produk (SCD Tipe 2 + Revisi Dosen: model_produk)
CREATE TABLE dim_produk (
    produk_key        INT           NOT NULL AUTO_INCREMENT,
    product_id        INT           NOT NULL,
    nama_produk       VARCHAR(100)  NOT NULL,
    model_produk      VARCHAR(50)   NOT NULL,
    subkategori       VARCHAR(50)   NOT NULL,
    kategori          VARCHAR(50)   NOT NULL,
    standard_cost     DECIMAL(19,4) NOT NULL,
    tgl_mulai_efektif DATE          NOT NULL,
    tgl_akhir_efektif DATE          NOT NULL DEFAULT '9999-12-31',
    is_current        CHAR(1)       NOT NULL DEFAULT 'Y',
    PRIMARY KEY (produk_key),
    UNIQUE KEY ux_dim_produk_versi (product_id, tgl_mulai_efektif),
    KEY ix_dim_produk_current (product_id, is_current),
    CONSTRAINT ck_dim_produk_current CHECK (is_current IN ('Y','N'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2.2 dim_vendor (SCD Tipe 1)
CREATE TABLE dim_vendor (
    vendor_key    INT          NOT NULL AUTO_INCREMENT,
    vendor_id     INT          NOT NULL,
    nomor_akun    VARCHAR(30)  NOT NULL,
    nama_vendor   VARCHAR(100) NOT NULL,
    rating_kredit INT          NULL,
    aktif_flag    CHAR(1)      NOT NULL,
    PRIMARY KEY (vendor_key),
    UNIQUE KEY ux_dim_vendor_bk (vendor_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2.3 dim_metode_kirim (SCD Tipe 1)
CREATE TABLE dim_metode_kirim (
    metode_kirim_key  INT           NOT NULL AUTO_INCREMENT,
    ship_method_id    INT           NOT NULL,
    nama_metode_kirim VARCHAR(50)   NOT NULL,
    tarif_dasar       DECIMAL(19,4) NOT NULL,
    PRIMARY KEY (metode_kirim_key),
    UNIQUE KEY ux_dim_metode_kirim_bk (ship_method_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2.4 dim_karyawan (SCD Tipe 1)
CREATE TABLE dim_karyawan (
    karyawan_key  INT          NOT NULL AUTO_INCREMENT,
    employee_id   INT          NOT NULL,
    nama_karyawan VARCHAR(100) NOT NULL,
    jabatan       VARCHAR(50)  NOT NULL,
    PRIMARY KEY (karyawan_key),
    UNIQUE KEY ux_dim_karyawan_bk (employee_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================================
-- 3. BARIS "TIDAK DIKETAHUI" (-1) DI SETIAP DIMENSI
-- =====================================================================
INSERT INTO dim_produk
    (produk_key, product_id, nama_produk, model_produk, subkategori, kategori,
     standard_cost, tgl_mulai_efektif, tgl_akhir_efektif, is_current)
VALUES
    (-1, -1, 'Tidak diketahui', 'Tidak diketahui', 'Tidak diketahui', 'Tidak diketahui',
     0, '1900-01-01', '9999-12-31', 'Y');

INSERT INTO dim_vendor
    (vendor_key, vendor_id, nomor_akun, nama_vendor, rating_kredit, aktif_flag)
VALUES
    (-1, -1, 'N/A', 'Tidak diketahui', NULL, '0');

INSERT INTO dim_metode_kirim
    (metode_kirim_key, ship_method_id, nama_metode_kirim, tarif_dasar)
VALUES
    (-1, -1, 'Tidak diketahui', 0);

INSERT INTO dim_karyawan
    (karyawan_key, employee_id, nama_karyawan, jabatan)
VALUES
    (-1, -1, 'Tidak diketahui', 'Tidak diketahui');

-- =====================================================================
-- 4. TABEL FAKTA (fact_pembelian)
-- =====================================================================
CREATE TABLE fact_pembelian (
    pembelian_key            BIGINT        NOT NULL AUTO_INCREMENT,
    tanggal_key              INT           NOT NULL,
    produk_key               INT           NOT NULL,
    vendor_key               INT           NOT NULL,
    metode_kirim_key         INT           NOT NULL,
    karyawan_key             INT           NOT NULL,
    purchase_order_id        INT           NOT NULL,
    purchase_order_detail_id INT           NOT NULL,
    jumlah_dipesan           INT           NOT NULL,
    jumlah_diterima          DECIMAL(10,2) NOT NULL,
    jumlah_ditolak           DECIMAL(10,2) NOT NULL,
    harga_satuan             DECIMAL(19,4) NOT NULL,
    nilai_pembelian          DECIMAL(19,4) NOT NULL,
    selisih_hari_kirim       INT           NULL,
    PRIMARY KEY (pembelian_key),
    UNIQUE KEY ux_fact_pembelian_grain (purchase_order_id, purchase_order_detail_id),
    
    KEY ix_fact_tanggal      (tanggal_key),
    KEY ix_fact_produk       (produk_key),
    KEY ix_fact_vendor       (vendor_key),
    KEY ix_fact_metode_kirim (metode_kirim_key),
    KEY ix_fact_karyawan     (karyawan_key),
    
    CONSTRAINT fk_fact_tanggal      FOREIGN KEY (tanggal_key)      REFERENCES dim_tanggal (tanggal_key),
    CONSTRAINT fk_fact_produk       FOREIGN KEY (produk_key)       REFERENCES dim_produk (produk_key),
    CONSTRAINT fk_fact_vendor       FOREIGN KEY (vendor_key)       REFERENCES dim_vendor (vendor_key),
    CONSTRAINT fk_fact_metode_kirim FOREIGN KEY (metode_kirim_key) REFERENCES dim_metode_kirim (metode_kirim_key),
    CONSTRAINT fk_fact_karyawan     FOREIGN KEY (karyawan_key)     REFERENCES dim_karyawan (karyawan_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================================
-- 5. VERIFIKASI AKHIR
-- =====================================================================
SELECT COUNT(*) AS total_baris_dim_tanggal FROM dim_tanggal;
