# Meet 7 - Distributed Processing

Buat sebuah program Java untuk Job MapReduce yang digunakan untuk menghitung maximum salary untuk setiap negara dari data salaryinfo.txt.

Submit program java dan screenshot hasil dari menjalankan Job tersebut pada data salaryinfo.txt
Hints:
1. Edit file program WordCount.java (boleh ganti nama-nama Class-nya)
2. Sesuaikan Class Map dengan mengambil kolom kedua sebagai key. Pada fungsi map(), split setiap string value baris. Output dari Class Map adalah key-nya ambil hasil split kedua, value-nya ambil split ketiga.
3. Sesuaikan Class Reduce dengan mengubah fungsi reduce(). Gunakan fungsi Math.max(a,b) untuk mendapatkan nilai salary maksimum untuk setiap key (negara).