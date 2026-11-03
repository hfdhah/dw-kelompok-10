**Baris Bus Matrix**

Bus Matrix merupakan matriks yang digunakan untuk menunjukkan hubungan antara proses bisnis dengan dimensi yang digunakan dalam perancangan Data Warehouse. Setiap baris menunjukkan proses bisnis, sedangkan setiap kolom menunjukkan dimensi yang digunakan untuk mendukung analisis pada proses tersebut. Penyusunan Bus Matrix bertujuan untuk mengidentifikasi dimensi yang digunakan secara bersama oleh beberapa proses bisnis *(conformed dimensions)*. Dengan demikian, setiap proses bisnis dapat dianalisis secara terintegrasi menggunakan dimensi yang telah disepakati oleh tim.

| Proses bisnis | Tanggal | Produk | Pelanggan | Wilayah | Promosi | Mata Uang | Metode Kirim | Sales Person | Reseller | Vendor | Karyawan | Alasan Sracp | Jenis Transaksi | Alasan Penjualan |
| :---- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| Penjualan Online | 🇴 | 🇴 | 🇴 | 🇴 | 🇴 | 🇴 | 🇴 |  |  |  |  |  |  |  |
| Penjualan Reseller | 🇴 | 🇴 |  | 🇴 | 🇴 | 🇴 | 🇴 | 🇴 | 🇴 |  |  |  |  |  |
| Kinerja Sales vs Target | 🇴 |  |  | 🇴 |  |  |  | 🇴 |  |  |  |  |  |  |
| Pembelian | 🇴 | 🇴 |  |  |  |  | 🇴 |  |  | 🇴 | 🇴 |  |  |  |
| Produksi | 🇴 | 🇴 |  |  |  |  |  |  |  |  |  | 🇴 |  |  |
| Pergerakan Persediaan | 🇴 | 🇴 |  |  |  |  |  |  |  |  |  |  | 🇴 |  |
| Alasan Pembelian Pelanggan | 🇴 |  | 🇴 | 🇴 |  |  |  |  |  |  |  |  |  | 🇴 |

Berdasarkan hasil perancangan, Bus Matrix tim mencakup tujuh proses bisnis, yaitu Penjualan Online, Penjualan Reseller, Kinerja Sales vs Target, Pembelian, Produksi, Pergerakan Persediaan, dan Alasan Pembelian Pelanggan. Setiap proses bisnis menggunakan kombinasi dimensi yang berbeda sesuai dengan kebutuhan analisisnya. Beberapa dimensi juga digunakan secara bersama oleh lebih dari satu proses bisnis, seperti dimensi Tanggal dan Produk.