-- ============================================
-- TOPIK 7: UJIAN - GROUP BY & AGGREGATE FUNCTIONS
-- ============================================
-- Database: toko_online
-- Tables: pelanggan, pembelian, produk
-- 
-- Tujuan: Mengukur pemahaman Anda mengenai fungsi agregasi, grouping (GROUP BY),
-- penyaringan hasil agregasi (HAVING), dan integrasi dengan JOIN.
--
-- Aturan Ujian:
-- 1. Selesaikan semua soal secara mandiri tanpa melihat file jawaban.sql.
-- 2. Tulis query Anda di bawah deskripsi soal masing-masing.
-- 3. Setelah selesai, bandingkan hasil query Anda dengan file jawaban.sql.
-- 4. Nilai kelulusan: Jika >=5 soal benar (>=83%) → Lulus dan siap untuk PROJECT 2!
-- ============================================

USE toko_online;

-- ============================================
-- SOAL 1: Pendapatan dan Volume Penjualan Toko
-- ============================================
-- Tim Finance membutuhkan laporan performa penjualan toko secara keseluruhan.
-- Buatlah satu baris ringkasan data transaksi yang menampilkan:
-- 1. Total nilai seluruh transaksi yang terjadi di toko (nama kolom: total_pendapatan)
-- 2. Jumlah total unit produk yang berhasil terjual (nama kolom: total_unit_terjual)
-- 3. Rata-rata nilai transaksi per pembelian (nama kolom: rata_rata_transaksi)
-- 4. Nilai transaksi pembelian terbesar yang pernah terjadi (nama kolom: transaksi_terbesar)
--
-- Tulis query Anda di sini:



-- ============================================
-- SOAL 2: Kontribusi Penjualan per Kategori
-- ============================================
-- Tim Product Management ingin mengetahui kategori produk mana yang paling berkontribusi
-- terhadap pendapatan toko.
-- Buatlah laporan yang menampilkan:
-- 1. Nama kategori produk
-- 2. Total unit produk yang telah terjual untuk kategori tersebut (nama kolom: unit_terjual)
-- 3. Total pendapatan yang diperoleh dari penjualan kategori tersebut (nama kolom: total_pendapatan)
--
-- Urutkan laporan dari kategori dengan total pendapatan terbesar ke terkecil.
--
-- Tulis query Anda di sini:



-- ============================================
-- SOAL 3: Demografi Pelanggan Aktif per Kota
-- ============================================
-- Tim Marketing ingin memetakan persebaran pelanggan unik yang aktif berbelanja 
-- (pernah melakukan transaksi) dan terdaftar menggunakan email domain umum (berakhiran 'email.com').
-- Buatlah laporan yang menampilkan:
-- 1. Kota domisili pelanggan
-- 2. Jumlah pelanggan unik yang aktif melakukan transaksi dari kota tersebut (nama kolom: jumlah_pelanggan_aktif)
--
-- Urutkan hasil laporan berdasarkan jumlah pelanggan aktif terbanyak ke terendah.
--
-- Tulis query Anda di sini:



-- ============================================
-- SOAL 4: Produk Paling Sering Dibeli
-- ============================================
-- Tim Inventory ingin mengetahui produk mana saja yang memiliki frekuensi transaksi tertinggi
-- untuk mengatur tata letak gudang.
-- Buatlah laporan yang menampilkan:
-- 1. ID Produk
-- 2. Nama Produk
-- 3. Frekuensi berapa kali produk tersebut dibeli dalam transaksi berbeda (nama kolom: frekuensi_pembelian)
--
-- Urutkan laporan berdasarkan frekuensi pembelian terbanyak. Jika ada produk dengan frekuensi yang sama,
-- urutkan berdasarkan nama produk secara alfabetis (A-Z).
--
-- Tulis query Anda di sini:



-- ============================================
-- SOAL 5: Kategori Performa Tinggi (High-Performance Categories)
-- ============================================
-- Manajemen menetapkan target kinerja per kategori. Tampilkan kategori produk yang berhasil
-- mendatangkan total pendapatan di atas 1.000.000 rupiah.
-- Tampilkan informasi berikut:
-- 1. Kategori produk
-- 2. Total pendapatan dari kategori tersebut (nama kolom: total_pendapatan)
--
-- Urutkan laporan berdasarkan total pendapatan dari yang terbesar ke terkecil.
--
-- Tulis query Anda di sini:



-- ============================================
-- SOAL 6: Tren Nilai Transaksi Harian
-- ============================================
-- Tim Data Analyst ingin menganalisis tren fluktuasi transaksi harian untuk melihat pola belanja pelanggan.
-- Tampilkan laporan harian yang memuat:
-- 1. Tanggal transaksi pembelian (tanggal_beli)
-- 2. Jumlah transaksi yang terjadi pada tanggal tersebut (nama kolom: jumlah_transaksi)
-- 3. Total nilai transaksi pada tanggal tersebut (nama kolom: total_pendapatan_harian)
--
-- Urutkan laporan secara kronologis berdasarkan tanggal transaksi dari yang paling lama ke terbaru.
--
-- Tulis query Anda di sini:


