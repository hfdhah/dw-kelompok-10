**Piagam Proyek Data Warehouse**

Kelompok	: 10  
Proses bisnis 	: Pembelian  
Sponsor       	: Mohamad Irwan Afandi, ST, M.Sc. 

1. **Latar belakang**
   
   Adventure Works Cycle adalah perusahaan manufaktur sepeda yang melakukan pembelian bahan baku dan komponen dari berbagai vendor. Seluruh transaksi pembelian saat ini dicatat dalam database operasional (OLTP) yang terstruktur secara ternormalisasi.
   Manajemen menghadapi kesulitan dalam menganalisis data pembelian secara menyeluruh, seperti memantau performa vendor, mengidentifikasi tren pengeluaran per kategori produk, mengevaluasi kinerja staf pengadaan (buyer), serta mendeteksi pola penolakan barang dari vendor. Query analisis pada database operasional membutuhkan banyak JOIN antar tabel dan memperlambat sistem transaksi yang sedang berjalan.
   Oleh karena itu, dibutuhkan sebuah data warehouse khusus proses pembelian yang mampu menyajikan data historis secara cepat, akurat, dan mudah dianalisis untuk mendukung pengambilan keputusan manajemen. 

2. **Tujuan dan pertanyaan bisnis**
   
   Tujuan: Membangun data warehouse proses pembelian untuk memantau performa vendor, efisiensi pengiriman, kinerja buyer dan tren pengeluaran Adventure Works secara historis guna mendukung pengambilan keputusan manajemen. 

   Pertanyaan bisnis yang harus dijawab dashboard:

| No | Pertanyaan | Fakta (Ukuran) | Tabel Sumber | Dimensi (sudut pandang) | Tabel Sumber |
| :---: | ----- | ----- | ----- | ----- | ----- |
| 1 | Vendor mana yang memiliki rasio penolakan barang tertinggi per tahun?  | Jumlah barang ditolak, jumlah barang dipesan | purchasing\_purchaseorderdetail (RejectedQty, OrderQty).  | Vendor, Tanggal (tahun) | purchasing\_purchaseorderheader (VendorID, OrderDate) |
| 2 | Bagaimana tren total nilai pembelian per sub kategori produk setiap kuartal?  | Total nilai pembelian | purchasing\_purchaseorderdetail (LineTotal) | Produk (subkategori, kategori), Tanggal (kuartal) | production\_product (Name), production\_productsubcategory (Name), purchasing\_purchaseorder (OrderDate) |
| 3 | Metode kirim mana yang paling sering melebihi batas waktu (due date) per tahun?  | Jumlah order terlambat | purchasing\_purchaseorderheader (ShipDate), purchasing\_purchaseorderdetail (DueDate) | Metode kirim, Tanggal (tahun) | purchasing\_shipmethod (Name), purchase\_purchaseorderheader (OrderDate) |
| 4 | Produk apa yang paling banyak dibeli (qty) per kuartal? | Jumlah barang dipesan | purchasing\_purchaseorderdetail (OrderQty) | Produk (nama, subkategori, kategori), Tanggal (kuartal)  | Production\_product (Name), production\_productsubcategory (Name), purchasing\_purchaseorderheader (OrderDate) |
| 5 | Vendor mana yang mendominasi total nilai pembelian untuk satu kategori produk tertentu?  | Total nilai pembelian | Purchasing\_purchaseorderdetail (LineTotal) | Vendor, Produk (kategori), Tanggal (tahun)  | Purchasing\_vendor (Name), production\_productcategory (Name), purchasing\_purchaseorderheader (OrderDate) |
| 6 | Karyawan (buyer) mana yang menangani total nilai pembelian terbesar setiap tahun?  | Total nilai pembelian | Purchasing\_purchaseorderheader (EmployeeID)  | Karyawan (buyer), Tanggal (tahun) | Humanresources\_employee, person\_person |

3. **Ruang lingkup**  
     Masuk lingkup:  
      - Proses bisnis: Pembelian   
      - Rentang tahun data: 2011-2014  
      - Tabel sumber:   
        * `purchasing_purchaseorderheader`
        * `purchasing_purchaseorderdetail`
        * `purchasing_vendor`
        * `purchasing_shipmethod`
        * `humanresources_employee`, `person_person`

   Di luar lingkup: 
    * Proses bisnis penjualan, produksi, dan HR  
    * Analisis keuangan dan akuntansi

4. **Tim dan peran**

| Nama | NPM | Peran Utama |
| ----- | ----- | ----- |
| Btari Adiella Duhita S | 23082010150 | Project Manager (ketua tim) |
| Marsyanda Firlyandita | 23082010225 | Data Modeler |
| Balqis Trihapsari Adiratna  | 23082010149  | ETL Developer |
| Dwi Yulianti | 23082010016 | OLAP Developer |
| Nur Hafidhah R  | 23082010206 | Dashboard Developer |

5. **Lingkungan teknis**

| Komponen | Detail |
| ----- | ----- |
| Sumber | PostgreSQL (database adventureworks.sql) |
| Target | MySQL (database dw\_kelompok\_10) |
| ETL | Pentaho Data Integration CE  |
| OLAP | Mondrian  |
| Dashboard | [Chart.js](http://Chart.js) / Tableu |

6. **Risiko awal**

| Risiko | Dampak | Penanganan |
| ----- | ----- | ----- |
| Import database adventureworks2 gagal | Ukuran file terlalu besar | Meningkatkan upload\_max\_filesize dan post\_max\_size di php.ini |
| Proses import database mengalami timeout | Waktu pemrosesan file SQL melebihi batas 300 detik | Meningkatkan max\_execution\_time dan max\_input\_time di php.ini |
| Proses import melalui phpMyAdmin gagal | phpMyAdmin membutuhkan waktu terlalu lama untuk membaca dan memproses file SQL | Mengimport database menggunakan MySQL Command Line melalui CMD |

7. **Kriteria sukses**  
   1. Total nilai pembelian yang ditampilkan di dashboard sama dengan hasil query langsung ke database sumber Adventure Works.  
   2. ETL job dapat dijalankan dua kali berturut-turut tanpa menghasilkan data ganda.  
   3. Skrip DDL dapat dijalankan ulang dari database kosong tanpa error.  
   4. Dashboard mampu menjawab 6 pertanyaan bisnis yang telah ditetapkan.

   
