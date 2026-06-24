-- ============================================
-- JAWABAN TOPIK 2: WHERE - FILTER DATA
-- ============================================
-- File ini berisi jawaban resmi untuk soal 1-5
-- Gunakan untuk self-check
-- ============================================

USE toko_online;

-- ============================================
-- SOAL NO. 1 - JAWABAN
-- ============================================
-- Tampilkan SEMUA data produk dengan harga LEBIH DARI 500.000
SELECT * FROM produk WHERE harga > 500000;


-- ============================================
-- SOAL NO. 2 - JAWABAN
-- ============================================
-- Tampilkan nama_produk dan harga untuk kategori 'Aksesori'
SELECT nama_produk, harga FROM produk WHERE kategori = 'Aksesori';


-- ============================================
-- SOAL NO. 3 - JAWABAN
-- ============================================
-- Tampilkan nama_pelanggan dan kota dari tabel pelanggan yang BERASAL dari kota 'Jakarta' atau 'Surabaya'
SELECT nama_pelanggan, kota FROM pelanggan WHERE kota = 'Jakarta' OR kota = 'Surabaya';


-- ============================================
-- SOAL NO. 4 - JAWABAN
-- ============================================
-- Tampilkan id_pembelian, jumlah, dan total_harga dari tabel pembelian 
-- dimana total_harga LEBIH BESAR dari 1.000.000 (1 juta)
SELECT id_pembelian, jumlah, total_harga FROM pembelian WHERE total_harga > 1000000;


-- ============================================
-- SOAL NO. 5 - JAWABAN
-- ============================================
-- Tampilkan nama_produk, kategori, harga dari tabel produk
-- WHERE: kategori = 'Elektronik' AND harga < 1.500.000
SELECT nama_produk, kategori, harga FROM produk WHERE kategori = 'Elektronik' AND harga < 1500000;
