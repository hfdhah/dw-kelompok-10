Laporan Progres Pekan 10  
Kelompok	: 10  
Proses bisnis 	: Pembelian  
Status        	: Hijau / Kuning / Merah

1\. Target dan capaian

| Target Pekan Ini | Status | Bukti  |
| ----- | ----- | ----- |
| Membentuk tim dan peran di piagam proyek secara lengkap | Hijau | <img width="475" height="191" alt="Image" src="https://github.com/user-attachments/assets/41593031-7ae3-4c8c-a917-5210d4293c8d" /> |
| Membuat 5 pertanyaan bisnis beserta fakta dan dimensinya | Hijau | <img width="485" height="293" alt="Image" src="https://github.com/user-attachments/assets/c80ea125-630a-4eef-9831-32a9afde5f70" /> <img width="333" height="374" alt="Image" src="https://github.com/user-attachments/assets/772de0de-f05e-45ed-8e85-51162e39d119" /> <img width="438" height="113" alt="Image" src="https://github.com/user-attachments/assets/f8ae2b1a-13fd-47ed-a020-912b7582917d" /> |
| Membuat pernyataan grain dalam satu kalimat | Hijau | <img width="367" height="30" alt="Image" src="https://github.com/user-attachments/assets/b4c3cd52-c4bb-45c5-9fbd-06386a5d7c0b" /> |
| Membuat schema versi 1 | Hijau | <img width="910" height="1268" alt="Image" src="https://github.com/user-attachments/assets/bc69aefe-e261-4dbe-970c-e79ba7b92d93" /> |
| Membuat baris bus matrix tim | Hijau | <img width="425" height="319" alt="Image" src="https://github.com/user-attachments/assets/936342fc-9fde-405a-9f62-ff5c074442e9" /> |
| Membuat profil data sumber: jumlah baris, rentang tanggal, jumlah NULL | Hijau | <img width="423" height="360" alt="Image" src="https://github.com/user-attachments/assets/e942e28e-c0e5-4741-aa9a-757ffd1b097e" /> <img width="359" height="355" alt="Image" src="https://github.com/user-attachments/assets/ed3958a8-82e0-4569-b8c8-0b80a2207129" /> <img width="361" height="377" alt="Image" src="https://github.com/user-attachments/assets/ccd1614b-827e-4da4-8158-e4a1b2133b59" /> <img width="368" height="329" alt="Image" src="https://github.com/user-attachments/assets/1b2ecf4c-187d-456d-9823-11115f936e0e" /> <img width="362" height="371" alt="Image" src="https://github.com/user-attachments/assets/c1143341-d0ad-4616-b743-784befe48cb8" /> |
| Import database Adventure Works menggunakan MySQL di laptop tiap anggota | Hijau | 1. Dwi Yulianti ![][image16] 2. Balqis trihapsari Adiratna ![][image17] 3. Nur Hafidhah R <img width="959" height="516" alt="Image" src="https://github.com/user-attachments/assets/e406830b-ce28-4080-9803-90813271209e" /> 4. Marsyanda Firlyandita <img width="960" height="504" alt="image" src="https://github.com/user-attachments/assets/44f88803-8b0f-48f4-81ab-11d30ef09a16" /> 5. Btari Adiella Duhita ![][image20] | | Membuat repository github | Hijau | Link akses: [https\://github.com/hfdhah/dw-kelompok-10](https://github.com/hfdhah/dw-kelompok-10)  |

2\. Kendala pengerjaan

| Kendala | Dampak | Penanganan |
| ----- | ----- | ----- |
| Import database adventureworks2 gagal | Ukuran file terlalu besar | Meningkatkan upload\_max\_filesize dan post\_max\_size di php.ini |
| Proses import database mengalami timeout | Waktu pemrosesan file SQL melebihi batas 300 detik | Meningkatkan max\_execution\_time dan max\_input\_time di php.ini |
| Proses import melalui phpMyAdmin gagal | phpMyAdmin membutuhkan waktu terlalu lama untuk membaca dan memproses file SQL | Mengimport database menggunakan MySQL Command Line melalui CMD |

 3\. Kendala tim:  
Tidak ada

4\. Keputusan yang butuh persetujuan sponsor

- Menggunakan Tableu untuk Dashboard  
- Menggunakan MySQL 

5\. Rencana pekan depan

| Target | Penanggung Jawab |
| ----- | ----- |
| Source-to-target mapping untuk setiap kolom dimensi dan fakta |  |
| Strategi SCD tiap dimensi (tipe 0, 1, atau 2\) beserta alasannya |  |
| Urutan load: staging, dimensi, lalu fakta |  |
| Desain cube: dimensi, hierarki, dan measure |  |
| Star schema versi 2 |  |
| Pentaho sudah bisa dibuka dan terhubung ke database sumber | Semua anggota tim |

6\. Kontribusi anggota

| Nama | Peran | Yang Dikerjakan Pekan Ini | Bukti Commit |
| ----- | ----- | ----- | ----- |
| Btari Adiella Duhita Salsabila | Project Manager (ketua tim) | Membantu dalam membuat laporan progres Membantu mengerjakan star schema 1 Import database Adventure Works |  |
| Marsyanda Firlyandita | Data Modeler | Menerjemahkan kebutuhan bisnis ke 6 pertanyaan beserta fakta & dimensi Menentukan grain Melakukan profil data sumber pada database Import database Adventure Works |  |
| Balqis Trihapsari Adiratna  | ETL Developer | Membantu mengerjakan Star Schema 1 Membantu mengerjakan baris bus matrix Membantu dalam pembuatan laporan progress Import database Adventure Works |  |
| Dwi Yulianti | OLAP Developer | Membantu menganalisis fakta dan dimensi berdasarkan pertanyaan bisnis. Mempelajari struktur database AdventureWorks Membantu pengerjaan Star Schema dan Bus Matrix. Import database Adventure Works  |  |
| Nur Hafidhah R  | Dashboard Developer | Membantu mengerjakan risiko pada piagam proyek Membantu membuat repository github Membantu dalam pembuatan laporan progress Import database Adventure Works | <img width="959" height="516" alt="Image" src="https://github.com/user-attachments/assets/bfdf935d-e5c4-4287-9ee9-400220e18067" /> <img width="470" height="239" alt="Image" src="https://github.com/user-attachments/assets/91a5df9c-b9d7-4391-ac1a-f150d86279b4" /> <img width="959" height="490" alt="Image" src="https://github.com/user-attachments/assets/3fcb6714-8edf-403f-b67b-912c530bac3c" /> <img width="257" height="338" alt="Image" src="https://github.com/user-attachments/assets/be2fc196-4469-446d-adca-5ab859bebb47" /> <img width="254" height="269" alt="Image" src="https://github.com/user-attachments/assets/9c4f82ad-c006-4507-bdb9-fce0f3788061" /> <img width="248" height="287" alt="Image" src="https://github.com/user-attachments/assets/8e8a6950-a7c7-40d6-ad5e-6cc03dfb9f02" /> <img width="252" height="297" alt="Image" src="https://github.com/user-attachments/assets/3d7efa0e-8a5c-4518-b643-4da91dd75eeb" /> <img width="252" height="296" alt="Image" src="https://github.com/user-attachments/assets/8074ad2c-72e7-40cf-b245-b966765d61da" /> <img width="252" height="328" alt="Image" src="https://github.com/user-attachments/assets/dba89def-5706-4e19-ab43-f27075be8f22" /> <img width="251" height="140" alt="Image" src="https://github.com/user-attachments/assets/02d8182b-22d1-46ad-90bf-901cd9cb1c14" /> |


