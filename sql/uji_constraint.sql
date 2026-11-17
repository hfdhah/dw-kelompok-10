-- produk_key = 99999 (produk palsu/tidak ada)
INSERT INTO fact_pembelian (
    tanggal_key, produk_key, vendor_key, metode_kirim_key, karyawan_key,
    purchase_order_id, purchase_order_detail_id,
    jumlah_dipesan, jumlah_diterima, jumlah_ditolak, harga_satuan, nilai_pembelian, selisih_hari_kirim
) VALUES (
    20130515, 99999, -1, -1, -1,
    999991, 1,
    10, 10, 0, 50.00, 500.00, 0
);

-- Uji 2
INSERT INTO fact_pembelian (
    tanggal_key, produk_key, vendor_key, metode_kirim_key, karyawan_key,
    purchase_order_id, purchase_order_detail_id,
    jumlah_dipesan, jumlah_diterima, jumlah_ditolak, harga_satuan, nilai_pembelian, selisih_hari_kirim
) VALUES (
    20130515, -1, -1, -1, -1,
    999992, 1,
    5, 5, 0, 100.00, 500.00, 0
);

-- PO dan detail ID
INSERT INTO fact_pembelian (
    tanggal_key, produk_key, vendor_key, metode_kirim_key, karyawan_key,
    purchase_order_id, purchase_order_detail_id,
    jumlah_dipesan, jumlah_diterima, jumlah_ditolak, harga_satuan, nilai_pembelian, selisih_hari_kirim
) VALUES (
    20130515, -1, -1, -1, -1,
    999992, 1,
    8, 8, 0, 100.00, 800.00, 0
);

-- Uji 3: Validasi Baris Default -1
INSERT INTO fact_pembelian (
    tanggal_key, produk_key, vendor_key, metode_kirim_key, karyawan_key,
    purchase_order_id, purchase_order_detail_id,
    jumlah_dipesan, jumlah_diterima, jumlah_ditolak, harga_satuan, nilai_pembelian, selisih_hari_kirim
) VALUES (
    -1, -1, -1, -1, -1,
    999993, 1,
    20, 18, 2, 25.00, 500.00, 3
);

-- Bersihkan Data
DELETE FROM fact_pembelian WHERE purchase_order_id >= 999990;
