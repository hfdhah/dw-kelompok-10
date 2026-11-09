Strategi SCD adalah metodologi teknis yang digunakan oleh pengembang Data Warehouse untuk menentukan bagaimana sistem memperlakukan data lama ketika data sumber di sistem operasional (OLTP) mengalami perubahan. 

| Tipe SCD | Artinya | Mekanisme |
| :---: | ----- | ----- |
| Tipe 0 | Fixed / Retain Original (Tidak Pernah Berubah) | Nilai atribut pada dimensi bersifat permanen sejak pertama kali dibuat. Sistem tidak pernah mengizinkan pembaruan (update) maupun penambahan baris baru.  |
| Tipe 1 | Overwirte (Menimpa Data Lama) | Ketika terjadi perubahan data pada sistem sumber, nilai lama pada tabel dimensi langsung ditimpa (overwrite) dengan nilai yang baru.  |
| Tipe 2 | Add New Row (Menyimpan Riwayat Perubahan) | Nilai lama tidak dihapus dan tidak ditimpa, melainkan ditandai sebagai data nonaktif (arsip riwayat). Sistem kemudian menyisipkan baris baru (insert new row) dengan Surrogate Key baru untuk menampung nilai terbaru.  |

| No | Dimensi | Tipe SCD | Atribut Key | Kolom Penanda | Alasan Bisnis |
| :---: | ----- | :---: | :---: | :---: | ----- |
| 1 | dim\_tanggal | Tipe 0 | tanggal\_key | \- | Dimensi tanggal dibentuk dari generator kalender tetap untuk rentang 2011–2014. Logika kalender bersifat mutlak dan tidak pernah berubah; tanggal 2011-05-31 selamanya merupakan hari Selasa pada Kuartal 2 tahun 2011\. Data ini diisi satu kali pada tahap awal (initial load) dan bersifat read-only.  |
| 2 | dim\_produk | Tipe 2 | produk\_key | Tgl\_mulai\_efektif, tgl\_akhir\_efektif, is\_current | Wajib silabus & menjaga riwayat harga/kategori. Jika nama, kategori, atau biaya standar produk berubah, sistem membuat baris baru. Ini memastikan transaksi tahun 2011 tetap mengacu pada harga/spesifikasi produk di tahun 2011, bukan data terbaru. |
| 3 | dim\_vendor | Tipe 1 | vendor\_id | \- | Hanya perlu info terkini. Jika nama vendor, kontak, atau nomor akun berubah, data lama langsung ditimpa. Analisis operasional pembelian hanya peduli pada profil vendor paling mutakhir. |
| 4 | dim\_metode\_kirim | Tipe 1 | ship\_method\_id | \- | Master data sangat kecil (hanya 5 baris). Jika ada pembaruan nama armada atau penyesuaian tarif dasar, langsung ditimpa karena tidak memerlukan riwayat masa lalu. |
| 5 | dim\_karyawan | Tipe 1 | employee\_id | \- | Hanya perlu profil mutakhir. Jika staf buyer mengalami mutasi jabatan atau perbaikan nama, cukup ditimpa. Analisis kinerja pembelian tahunan cukup menampilkan nama dan posisi terkini karyawan. |

