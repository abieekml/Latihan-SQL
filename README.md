
## 📊 Skema Database
Database ini terdiri dari 6 tabel yang saling terhubung:
* **customer**: Profil pelanggan.
* **employee**: Data karyawan dengan hierarki atasan-bawahan (self-referencing).
* **category**: Kategori produk dengan dukungan sub-kategori (self-referencing).
* **product**: Katalog produk yang tersedia.
* **purchase**: Data transaksi pembelian utama.
* **purchase_item**: Detail item dari setiap pembelian (junction table).

## 🛠️ Cara Penggunaan
1. Jalankan kueri di file `schema.sql` untuk membangun struktur database.
2. Gunakan `solutions.sql` untuk melihat jawaban dari 30 soal latihan yang tersedia.


