1. **S2T untuk Mapping 5 Dimensi**

1. Dim\_produk (Tipe 2\)  
   Sumber: production\_product (p) digabung dengan production\_productmodel (pm), production\_productsubcategory (psc), dan production\_productcategory (pc).   
   

| Kolom Target | Tipe Data Target | Tabel & Kolom Sumber | Aturan Transformasi |
| ----- | :---- | :---- | :---- |
| produk\_key | INT (PK) | *None* | Surrogate Key ( Auto Increment) |
| product\_id | INT | p.ProductID | Natural Key / ID asli dari sumber |
| nama\_produk | VARCHAR(100) | p.Name | TRIM(p.Name) |
| model\_produk | VARCHAR(50) | pm.Name | IFNULL(pm.Name, 'Tanpa Model') |
| subkategori | VARCHAR(50) | psc.Name | IFNULL(psc.Name, 'Tanpa Subkategori') |
| kategori | VARCHAR(50) | pc.Name | IFNULL(pc.Name, 'Tanpa Kategori') |
| standard\_cost | DECIMAL(19,4) | p.StandardCost | Biaya standar produksi |
| tgl\_mulai\_efektif | DATE | p.SellStartDate / Tanggal ETL | Tanggal awal berlakunya versi data produk |
| tgl\_akhir\_efektif | DATE | Pentaho / Sistem | Diisi 9999-12-31 jika produk masih aktif |
| is\_current | CHAR(1) | Pentaho / Sistem | 'Y' jika data aktif, 'N' jika arsip lama |

	  
Tabel dim\_produk berfungsi untuk menyimpan informasi detail katalog barang yang dibeli oleh perusahaan, mencakup nama produk, model produk, subkategori, kategori, hingga biaya standar produk. Tabel ini dibentuk dari denormalisasi beberapa tabel sumber OLTP, yaitu production\_product, production\_productmodel, production\_productsubcategory, dan production\_productcategory. Dimensi ini menerapkan strategi SCD Tipe 2 guna melacak riwayat perubahan harga maupun spesifikasi produk dari waktu ke waktu, sehingga analisis tren pengadaan barang di masa lalu tetap akurat. 

2. Dim\_tanggal (Tipe 0\)  
   Sumber: Dihasilkan dari kalender otomatis (Date Generator) tahun 2011 s.d. 2014\.   
   

| Kolom Target | Tipe Data Target | Kolom Sumber | Aturan Transformasi |
| ----- | ----- | ----- | ----- |
| tanggal\_key | INT (PK) | Tanggal Kalender | Format angka YYYYMMDD (contoh: 20110531\) |
| tanggal | DATE | Tanggal Kalender | Format YYYY-MM-DD |
| hari | INT | Tanggal Kalender | DAY(tanggal) (angka 1–31) |
| nama\_hari | VARCHAR(15) | Tanggal Kalender | DAYNAME(tanggal) (Senin, Selasa, ...) |
| bulan | INT | Tanggal Kalender | MONTH(tanggal) (angka 1–12) |
| nama\_bulan | VARCHAR(15) | Tanggal Kalender | MONTHNAME(tanggal) (Januari, Februari, ...) |
| kuartal | INT | Tanggal Kalender | QUARTER(tanggal) (angka 1–4) |
| tahun | INT | Tanggal Kalender | YEAR(tanggal) (2011–2014) |

   

Tabel dim\_tanggal merupakan dimensi waktu standar yang berfungsi sebagai analisis tren transaksi pembelian berdasarkan rentang waktu tertentu (hari, bulan, kuartal, dan tahun). Tabel ini di-generate secara mandiri untuk rentang operasional tahun 2011 hingga 2014 dan menerapkan strategi SCD Tipe 0 (bersifat statis/permanen karena susunan kalender tidak pernah berubah). Dimensi ini penting untuk melihat pola musiman serta pertumbuhan nilai belanja perusahaan dari tahun ke tahun. 

3. Dim\_vendor (Tipe 1\)  
   Sumber: purchasing\_vendor (v)  
   

| Kolom Target | Tipe Data Target | Tabel & Kolom Sumber | Aturan Transformasi |
| ----- | ----- | ----- | ----- |
| vendor\_key | INT (PK) | None | Surrogate Key (Auto Increment) |
| vendor\_id | INT | v.BusinessEntityID | Natural Key vendor |
| nomor\_akun | VARCHAR(30) | v.AccountNumber | TRIM(v.AccountNumber) |
| nama\_vendor | VARCHAR(100) | v.Name | TRIM(v.Name) |
| rating\_kredit | INT | v.CreditRating | Skala 1 s.d. 5 |
| aktif\_flag | CHAR(1) | v.ActiveFlag | 1 jika aktif, 0 jika nonaktif |

Tabel dim\_vendor menyimpan profil pemasok (supplier) mitra perusahaan, yang mencakup identitas vendor, nomor akun, nama perusahaan mitra, tingkat kelayakan kredit (credit rating), serta status keaktifan kerja sama. Data diambil langsung dari tabel sumber purchasing\_vendor. Dimensi ini menerapkan strategi SCD Tipe 1 (overwrite) karena manajemen hanya membutuhkan profil vendor yang paling mutakhir. Tabel ini digunakan untuk memantau performa pasokan barang dan menganalisis rasio penolakan (rejection rate) barang rusak dari vendor. 

4. Dim\_metode\_kirim (Tipe 1\)  
   Sumber: purchasing\_shipmethod (sm)  
   

| Kolom Target | Tipe Data Target | Tabel & Kolom Sumber | Aturan Transformasi |
| ----- | ----- | ----- | ----- |
| metode\_kirim\_key | INT (PK) | None | Surrogate Key (Auto Increment) |
| ship\_method\_id | INT | sm.ShipMethodID | Natural Key metode kirim (1–5) |
| nama\_metode\_kirim | VARCHAR(50) | sm.Name | TRIM(sm.Name) (misal: CARGO TRANSPORT) |
| tarif\_dasar | DECIMAL(19,4) | sm.ShipBase | Biaya dasar pengiriman |

Tabel dim\_metode\_kirim berisi master data jasa ekspedisi atau armada logistik yang digunakan untuk mendistribusikan pesanan dari gudang vendor ke gudang perusahaan. Data diambil dari tabel sumber purchasing\_shipmethod yang mencatat jenis armada dan tarif dasar pengiriman. Menggunakan pendekatan SCD Tipe 1, tabel dimensi ini bermanfaat untuk mengevaluasi efisiensi pengiriman dan mengidentifikasi mitra kurir yang sering melebihi batas waktu kedatangan. 

5. Dim\_karyawan (Tipe 1\)  
   Sumber: humanresources\_employee (e) digabung dengan person\_person (p).   
   

| Kolom Target | Tipe Data Target | Tabel & Kolom Sumber | Aturan Transformasi |
| ----- | ----- | ----- | ----- |
| karyawan\_key | INT (PK) | None | Surrogate Key (Auto Increment) |
| employee\_id | INT | e.BusinessEntityID | Natural Key staf Purchasing |
| nama\_karyawan | VARCHAR(100) | p.FirstName, p.LastName | Gabungkan nama: CONCAT(p.FirstName, ' ', p.LastName) |
| jabatan | VARCHAR(50) | e.JobTitle | Jabatan (misal: Buyer, Purchasing Manager) |

Tabel dim\_karyawan mencatat data staf internal bagian pengadaan barang (buyer dan purchasing manager) yang bertanggung jawab memproses pesanan ke pemasok. Tabel ini dibentuk dengan menggabungkan data pegawai pada humanresources\_employee dan data profil nama pada person\_person. Dimensi ini menerapkan SCD Tipe 1 dan berfungsi untuk mengevaluasi produktivitas kerja karyawan serta melihat staf yang menangani nilai anggaran pembelian terbesar di perusahaan. 

2. **S2T untuk Mapping 1 Fakta**  
   Grain: Satu baris mewakili satu baris detail pesanan pembelian (purchase order detail)  
   Sumber: purchasing\_purchaseorderdetail (pod), purchasing\_purchaseorderheader (poh)  
    (Digabungkan menggunakan relasi: pod.PurchaseOrderID \= poh.PurchaseOrderID)

| Kolom Target | Tipe Data Target | Tabel & Kolom Sumber | Sifat Kolom | Logika Transformasi & Lookup Pentaho  |
| :---: | :---: | :---: | :---: | ----- |
| pembelian\_key | BIGINT | None | Primary Key | Surrogate Key (Auto Increment). |
| tanggal\_key | INT | poh.OrderDate | Foreign Key | Format tanggal menjadi angka: DATE\_FORMAT(poh.OrderDate, '%Y%m%d') lalu lookup ke dim\_tanggal.tanggal\_key. |
| produk\_key | INT | pod.ProductID poh.OrderDate | Foreign Key | Lookup SCD Tipe 2 ke dim\_produk berdasarkan ProductID, di mana OrderDate berada di antara tgl\_mulai\_efektif dan tgl\_akhir\_efektif. |
| vendor\_key | INT | poh.VendorID | Foreign Key | Database Lookup ke dim\_vendor berdasarkan kecocokan VendorID \= vendor\_id untuk mengambil vendor\_key. |
| metode\_kirim\_key | INT | poh.ShipMethodID | Foreign Key | Database Lookup ke dim\_metode\_kirim berdasarkan kecocokan ShipMethodID \= ship\_method\_id untuk mengambil metode\_kirim\_key. |
| karyawan\_key | INT | poh.EmployeeID | Foreign Key | Database Lookup ke dim\_karyawan berdasarkan kecocokan EmployeeID \= employee\_id untuk mengambil karyawan\_key. |
| purchase\_order\_id | INT | poh.PurchaseOrderID | Degenerate Dimension | Dipindahkan langsung (direct mapping) sebagai nomor faktur PO untuk kebutuhan pelacakan/audit. |
| purchase\_order\_detail\_id | INT | pod.PurchaseOrderDetailID | Degenerate Dimension | Dipindahkan langsung (direct mapping) sebagai identitas baris item transaksi. |
| jumlah\_dipesan | INT | pod.OrderQty | Measure (Aditif) | Dipindahkan langsung (direct mapping): kuantitas barang yang dipesan. |
| jumlah\_diterima | DECIMAL(10,2) | pod.ReceivedQty | Measure (Aditif) | Dipindahkan langsung: kuantitas fisik barang yang berhasil diterima di gudang. |
| jumlah\_ditolak | DECIMAL(10,2) | pod.RejectedQty | Measure (Aditif) | Dipindahkan langsung: kuantitas barang yang rusak/ditolak saat inspeksi. |
| harga\_satuan | DECIMAL(19,4) | pod.UnitPrice | Measure (Non-Aditif) | Harga beli per satu unit barang. Tidak dapat dijumlahkan secara langsung antar transaksi. |
| nilai\_pembelian | DECIMAL(19,4) | pod.LineTotal | Measure (Aditif) | Nilai total transaksi pembelian per baris item barang (OrderQty \* UnitPrice). |
| selisih\_hari\_kirim | INT | poh.ShipDate pod.DueDate | Measure (Semi-Aditif) | Kalkulasi selisih hari: DATEDIFF(poh.ShipDate, pod.DueDate). Jika hasilnya \> 0 berarti pengiriman terlambat. |

   Tabel fact\_pembelian merupakan tabel pusat (center) dari star schema proses pembelian dengan tingkat ketelitian (grain) satu baris mewakili satu baris detail barang pada Purchase Order. Tabel ini mengikat kelima tabel dimensi menggunakan foreign key sekaligus menyimpan ukuran numerik transaksi bisnis (measures), seperti jumlah pesanan, kuantitas barang diterima, kuantitas barang rusak/ditolak, harga beli per unit, total nilai transaksi (LineTotal), dan selisih hari keterlambatan pengiriman. Tabel fakta ini menjadi sumber utama kalkulasi agregasi dalam menjawab seluruh pertanyaan bisnis pengadaan. 