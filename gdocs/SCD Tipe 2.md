Tabel dim\_produk pada database dwh\_kelompok\_10 menerapkan konsep *Slowly Changing Dimension* (SCD) Tipe 2 untuk menyimpan riwayat perubahan biaya produk (standard\_cost) tanpa menimpa data lama. Setiap perubahan biaya akan menghasilkan baris baru dengan surrogate key )produk\_key) berbeda, sementara business key (product\_id) tetap sama.  


Dapat dilihat pada gambar diatas bahwa hasil query untuk product\_id=501 (Mountain-200 Black, 42\) terdiri dari 2 versi, yaitu:

1. Versi 1 (produk\_key \= 1): memiliki nilai “standard\_cost” sebesar 1100.0000 yang berlaku mulai tanggal 2026-01-01 hingga 2026-06-30. Karena sudah digantikan oleh versi berikutnya, maka statusnya tidak aktif (is\_current \= N).  
2. Versi 2 (produk\_key \= 2): memiliki nilai “standard\_cost” sebesar 1250.0000 yang berlaku mulai tanggal 2026-07-01 dengan tgl\_akhir\_efektif \= 9999-12-31 dan is\_current \= Y, yang artinya versi ini sedang aktif digunakan. 

Penggunaan SCD ini memastikan riwayat perubahan biaya produk tetap terjaga, sehingga data transaksi di “fact\_pembelian” melalui “produk\_key” dapat merujuk ke versi biaya yang sesuai pada saat transaksi terjadi.  
