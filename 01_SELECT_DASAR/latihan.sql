-- ============================================
-- LATIHAN TOPIK 1: SELECT DASAR
-- ============================================
-- INSTRUKSI:
-- 1. Baca materi.md dulu
-- 2. Tulis jawaban SQL di bawah soal masing-masing
-- 3. Jalankan query di MySQL
-- 4. Chat Copilot untuk validasi jawaban
-- ============================================

USE toko_online;

-- ============================================
-- SOAL NO. 1
-- ============================================
-- Tampilkan SEMUA data dari tabel produk
-- Expected: 8 baris dengan semua kolom
-- 
-- Tulis query Anda di sini: SELECT * FROM produk;



-- ============================================
-- SOAL NO. 2
-- ============================================
-- Tampilkan HANYA nama_produk dan harga dari tabel produk
-- Expected: 8 baris, 2 kolom (nama_produk, harga)
--
-- Tulis query Anda di sini:





-- ============================================
-- SOAL NO. 3
-- ============================================
-- Tampilkan id_produk, nama_produk, dan kategori dari tabel produk
-- Expected: 8 baris, 3 kolom
--
-- Tulis query Anda di sini:
SELECT id_produk,nama_produk,kategori FROM produk;z



-- ============================================
-- SOAL NO. 4
-- ============================================
-- Tampilkan nama_pelanggan dan email dari tabel pelanggan
-- Expected: 6 baris, 2 kolom
--
-- Tulis query Anda di sini:
SELECT nama_pelanggan, email FROM pelanggan;



-- ============================================
-- SOAL NO. 5 (Challenge)
-- ============================================
-- Tampilkan SEMUA data dari tabel pembelian
-- Expected: 10 baris dengan semua kolom
--
-- Tulis query Anda di sini:
SELECT * FROM pembelian;