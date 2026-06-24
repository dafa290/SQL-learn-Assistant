-- ============================================
-- JAWABAN TOPIK 1: SELECT DASAR
-- ============================================
-- File ini berisi jawaban resmi untuk soal 1-5
-- Gunakan untuk:
-- 1. Self-check: bandingkan dengan jawaban Anda
-- 2. Cek koreksi: minta saya review kalau ada perbedaan
-- ============================================

USE toko_online;

-- ============================================
-- SOAL NO. 1 - JAWABAN
-- ============================================
-- Tampilkan SEMUA data dari tabel produk
select * from produk;


-- ============================================
-- SOAL NO. 2 - JAWABAN
-- ============================================
-- Tampilkan HANYA nama_produk dan harga dari tabel produk
select nama_produk, harga from produk;


-- ============================================
-- SOAL NO. 3 - JAWABAN
-- ============================================
-- Tampilkan id_produk, nama_produk, dan kategori dari tabel produk
select id_produk, nama_produk, 


-- ============================================
-- SOAL NO. 4 - JAWABAN
-- ============================================
-- Tampilkan nama_pelanggan dan email dari tabel pelanggan
SELECT nama_pelanggan, email FROM pelanggan;


-- ============================================
-- SOAL NO. 5 - JAWABAN
-- ============================================
-- Tampilkan SEMUA data dari tabel pembelian
SELECT * FROM pembelian;
