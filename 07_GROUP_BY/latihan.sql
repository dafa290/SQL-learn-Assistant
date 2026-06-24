-- ============================================
-- TOPIK 7: LATIHAN - GROUP BY & AGGREGATE FUNCTIONS
-- ============================================
-- Database: toko_online
-- Tables: pelanggan, pembelian, produk
-- 
-- Tujuan: Latihan menggunakan fungsi agregasi (COUNT, SUM, AVG, MIN, MAX),
-- klausa GROUP BY, HAVING, serta menggabungkannya dengan JOIN.
--
-- Petunjuk:
-- 1. Tulis query Anda di bawah komentar masing-masing soal.
-- 2. Cek hasil query Anda dengan mencocokkannya dengan jawaban di jawaban.sql.
-- 3. Jika minimal 4 soal benar (>=80%), silakan lanjut ke ujian.sql.
-- ============================================

USE toko_online;

-- ============================================
-- SOAL 1: Statistik Dasar Produk
-- ============================================
-- Requirement:
-- Tampilkan rangkuman statistik dari seluruh produk yang ada di toko:
-- - Jumlah total jenis produk (alias: total_produk)
-- - Rata-rata harga produk (alias: rata_rata_harga)
-- - Harga produk paling murah (alias: harga_termurah)
-- - Harga produk paling mahal (alias: harga_termahal)
--
-- Tulis query Anda di sini:
SELECT COUNT(*) AS total_produk, AVG(harga) AS rata_rata_harga,
MIN(harga) AS harga_termurah, MAX(harga) AS harga_termahal FROM produk;


-- ============================================
-- SOAL 2: Total Stok per Kategori Produk
-- ============================================
-- Requirement:
-- Tampilkan kategori produk beserta total stok barang yang tersedia untuk masing-masing kategori.
-- Kolom yang ditampilkan:
-- - kategori
-- - total_stok (jumlah dari kolom stok produk)
-- 
-- Urutkan hasil laporan berdasarkan total_stok dari yang terbesar ke terkecil.
--
-- Tulis query Anda di sini:
SELECT kategori AS kategori_produk, SUM(stok) AS total_stok FROM produk
GROUP BY kategori_produk ORDER BY total_stok DESC;


-- ============================================
-- SOAL 3: Total Pengeluaran Belanja per Pelanggan
-- ============================================
-- Requirement:
-- Tampilkan nama pelanggan, kota asal mereka, dan total uang yang sudah mereka belanjakan.
-- Kolom yang ditampilkan:
-- - nama_pelanggan
-- - kota
-- - total_belanja (penjumlahan dari kolom total_harga pembelian)
--
-- Gunakan INNER JOIN untuk menghubungkan tabel pelanggan dengan pembelian.
-- Kelompokkan berdasarkan id_pelanggan dan kolom yang dipilih lainnya.
-- Urutkan berdasarkan total_belanja dari yang terbesar ke terkecil.
--
-- Tulis query Anda di sini:
SELECT pelanggan.nama_pelanggan, pelanggan.kota, pembelian.total_harga
FROM pembelian
INNER JOIN pelanggan ON pembelian.id_pelanggan = pelanggan.id_pelanggan
ORDER BY total_harga DESC;


-- ============================================
-- SOAL 4: Jumlah Transaksi Pembelian per Kota
-- ============================================
-- Requirement:
-- Tim Sales ingin mengetahui persebaran transaksi berdasarkan kota domisili pelanggan.
-- Tampilkan kota domisili pelanggan beserta jumlah transaksi pembelian yang 
--dilakukan oleh pelanggan dari kota tersebut.
-- Kolom yang ditampilkan:
-- - kota
-- - jumlah_transaksi (jumlah baris transaksi pembelian)
--
-- Petunjuk: Hubungkan tabel pelanggan dengan pembelian, kelompokkan berdasarkan kota, 
-- dan urutkan berdasarkan jumlah_transaksi terbanyak.
--
-- Tulis query Anda di sini:
SELECT pelanggan.nama_pelanggan, pelanggan.kota, SUM(pembelian.total_harga) AS total_pembelian
FROM pelanggan
INNER JOIN pembelian ON pelanggan.id_pelanggan = pembelian.id_pelanggan
GROUP BY pelanggan.id_pelanggan, pelanggan.nama_pelanggan, pelanggan.kota
ORDER BY total_pembelian DESC;


-- ============================================
-- SOAL 5: Pelanggan Premium (Total Belanja > 1.000.000)
-- ============================================
-- Requirement:
-- Tampilkan nama pelanggan dan total belanja mereka (total_belanja), tetapi HANYA untuk
-- pelanggan yang total belanjanya di atas 1.000.000 rupiah.
-- Kolom yang ditampilkan:
-- - nama_pelanggan
-- - total_belanja
--
-- Petunjuk: Gunakan JOIN, GROUP BY, dan HAVING clause untuk memfilter hasil agregasi.
-- Urutkan berdasarkan total_belanja dari yang terbesar ke terkecil.
--
-- Tulis query Anda di sini:
SELECT pelanggan.nama_pelanggan, SUM(pembelian.total_harga) AS total_belanja
FROM pelanggan
INNER JOIN pembeliaan ON pelanggan.id_pelanggan = pembelian.id_pelanggan 
GROUP BY pelanggan.id_pelanggan, pelanggan.nama_pelanggan
HAVING total_belanja > 1000000;

