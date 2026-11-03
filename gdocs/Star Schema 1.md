**Perancangan Star Schema v1** 

Proses bisnis yang dipilih dalam perancangan Data Warehouse kelompok ini adalah proses pembelian (Purchasing) pada database AdventureWorks. Pemilihan proses ini bertujuan untuk mendukung analisis aktivitas pembelian, mulai dari jumlah barang yang dipesan, jumlah barang yang diterima, jumlah barang yang ditolak, hingga nilai transaksi pembelian.

1. **Penetapan Grain**  
   Grain yang digunakan dalam perancangan tabel fakta adalah satu baris untuk setiap baris detail Purchase Order. Artinya, setiap baris pada tabel fakta merepresentasikan satu produk dalam satu transaksi pembelian. Apabila satu Purchase Order memiliki beberapa produk, setiap produk akan dicatat sebagai baris fakta yang berbeda.  
2. **Penentuan Tabel Dimensi**

| No. | Tabel Dimensi | Fungsi |
| :---: | ----- | ----- |
| 1\. | dim\_tanggal | Menganalisis pembelian berdasarkan tanggal, bulan, kuartal, dan tahun. |
| 2\. | dim\_produk | Menganalisis pembelian berdasarkan produk, subkategori, dan kategori. |
| 3\. | dim\_vendor | Menganalisis kontribusi dan performa pemasok. |
| 4\. | dim\_metode\_kirim | Menganalisis pembelian berdasarkan metode pengiriman. |
| 5\. | dim\_karyawan | Mengidentifikasi karyawan yang menangani transaksi pembelian. |

3. **Penetapan Tabel Fakta**  
   Tabel fakta utama yang dirancang adalah fact\_pembelian. Tabel ini digunakan untuk menyimpan ukuran kuantitatif dari aktivitas pembelian. Atribut fakta yang direncanakan meliputi:

| No | Atribut | Keterangan |
| :---: | ----- | ----- |
| 1 | order\_qty | Jumlah produk yang dipesan |
| 2 | received\_qty | Jumlah produk yang diterima |
| 3 | rejected\_qty | Jumlah produk yang ditolak |
| 4 | stocked\_qty | Jumlah produk yang masuk ke persediaan |
| 5 | unit\_price | Harga pembelian per unit |
| 6 | line\_total | Total nilai pembelian per detail transaksi |
| 7 | is\_late | Penanda keterlambatan pengiriman |

   

4. Hubungan Tabel Fakta dan Dimensi  
   Tabel fact\_pembelian menjadi pusat dari Star Schema dan memiliki hubungan dengan lima tabel dimensi. Hubungan tersebut menggunakan foreign key yang mengacu pada primary key masing-masing dimensi. Khusus dimensi tanggal, digunakan tiga peran berbeda, yaitu tanggal pemesanan, tanggal jatuh tempo, dan tanggal pengiriman. Ketiga peran tersebut tetap menggunakan satu tabel dim\_tanggal melalui tiga foreign key yang berbeda.

5. Hasil Perancangan  
   Berdasarkan pemilihan proses bisnis, penetapan grain, pemilihan dimensi, dan pemilihan fakta, diperoleh rancangan Star Schema v1 untuk proses pembelian AdventureWorks. Rancangan ini diharapkan dapat mendukung analisis nilai pembelian, kuantitas produk, performa vendor, serta ketepatan waktu pengiriman.  
     
6. Diagram  
<img width="910" height="1268" alt="Image" src="https://github.com/user-attachments/assets/b5faac52-6d35-4b18-b3f7-a9485e45e999" />
