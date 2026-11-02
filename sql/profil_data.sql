-- =============================================================================
-- PROFIL DATA SUMBER (DATA PROFILING)
-- Proses Bisnis : Pembelian (Purchasing)
-- Database      : Adventure Works (MySQL)
-- Kelompok      : 10
-- Data Modeler  : Marsyanda Firlyandita
-- 
-- GRAIN: Satu baris pada tabel fakta mewakili satu baris detail purchase order
--        (purchaseorderdetail).
-- =============================================================================


-- -----------------------------------------------------------------------------
-- 1. Query 1: Rentang Tanggal & Volume Pesanan
-- Tujuan : Mempersiapkan analisis tren waktu (Kuartal & Tahun) untuk Q1 - Q6.
-- Hasil  : Total 4.012 pesanan (2011 s.d. 2014).
--          Status: 1=Pending (225), 2=Approved (12), 3=Rejected (86), 4=Complete (3.689).
-- -----------------------------------------------------------------------------
SELECT 
    status, 
    COUNT(*) AS jumlah_pesanan,
    MIN(OrderDate) AS tanggal_awal, 
    MAX(OrderDate) AS tanggal_akhir
FROM purchasing_purchaseorderheader
GROUP BY status;


-- -----------------------------------------------------------------------------
-- 2. Query 2: Kualitas Data Vendor (Cek NULL)
-- Tujuan : Mempersiapkan performa & dominasi vendor (Q1 dan Q5).
-- Hasil  : 0 (Semua pesanan 100% memiliki VendorID, tidak ada data orphan).
-- -----------------------------------------------------------------------------
SELECT 
    COUNT(*) AS pesanan_tanpa_vendor
FROM purchasing_purchaseorderheader
WHERE VendorID IS NULL;


-- -----------------------------------------------------------------------------
-- 3. Query 3: Profil Barang Ditolak (Rejection)
-- Tujuan : Mempersiapkan analisis rasio penolakan barang per vendor (Q1).
-- Hasil  : 563 baris transaksi dengan total 72.700 unit barang ditolak.
-- -----------------------------------------------------------------------------
SELECT 
    COUNT(*) AS total_baris_ada_ditolak,
    SUM(RejectedQty) AS total_unit_ditolak
FROM purchasing_purchaseorderdetail
WHERE RejectedQty > 0;


-- -----------------------------------------------------------------------------
-- 4. Query 4: Profil Pengiriman & Batas Waktu
-- Tujuan : Mempersiapkan analisis keterlambatan pengiriman per metode kirim (Q3).
-- Hasil  : 0 data NULL untuk ShipDate dan ShipMethodID (Data pengiriman lengkap).
-- -----------------------------------------------------------------------------
SELECT 
    SUM(CASE WHEN ShipDate IS NULL THEN 1 ELSE 0 END) AS tanpa_shipdate,
    SUM(CASE WHEN ShipMethodID IS NULL THEN 1 ELSE 0 END) AS tanpa_shipmethod
FROM purchasing_purchaseorderheader;


-- -----------------------------------------------------------------------------
-- 5. Query 5: Jumlah Baris Fakta & Kelengkapan Produk
-- Tujuan : Mempersiapkan grain tabel fakta dan tren produk terbanyak (Q2 dan Q4).
-- Hasil  : 8.845 calon baris fakta, 0 ProductID NULL, 0 Qty tidak valid.
-- -----------------------------------------------------------------------------
SELECT 
    COUNT(*) AS calon_jumlah_baris_fakta,
    SUM(CASE WHEN ProductID IS NULL THEN 1 ELSE 0 END) AS tanpa_productid,
    SUM(CASE WHEN OrderQty IS NULL OR OrderQty <= 0 THEN 1 ELSE 0 END) AS qty_tidak_valid
FROM purchasing_purchaseorderdetail;


-- -----------------------------------------------------------------------------
-- 6. Query 6: Volume Data Master Dimensi
-- Tujuan : Mengetahui total volume data master yang akan mengisi tabel dimensi.
-- Hasil  : Master Vendor = 104, Master Metode Kirim = 5, Master Produk = 504.
-- -----------------------------------------------------------------------------
SELECT 'Master Vendor' AS dimensi, COUNT(*) AS total_data FROM purchasing_vendor
UNION ALL
SELECT 'Master Metode Kirim' AS dimensi, COUNT(*) AS total_data FROM purchasing_shipmethod
UNION ALL
SELECT 'Master Produk' AS dimensi, COUNT(*) AS total_data FROM production_product;
