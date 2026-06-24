-- ============================================
-- LATIHAN TOPIK 2: WHERE - FILTER DATA
-- ============================================
-- INSTRUKSI:
-- 1. Baca materi.md dulu
-- 2. Tulis jawaban SQL di bawah soal masing-masing
-- 3. Jalankan query di MySQL
-- 4. Self-check dengan jawaban.sql
-- 5. Chat Copilot jika ada perbedaan
-- ============================================

USE toko_online;

-- ============================================
-- SOAL NO. 1
-- ============================================
-- Tampilkan SEMUA data produk dengan harga LEBIH DARI 500.000
-- Expected: 6 baris (Laptop, Keyboard, Monitor, Webcam, Headphone, tidak termasuk Mouse dan Power Bank)
--
-- Tulis query Anda di sini:
select * from produk where harga>500000;



-- ============================================
-- SOAL NO. 2
-- ============================================
-- Tampilkan nama_produk dan harga untuk kategori 'Aksesori'
-- Expected: 3 baris (Mouse, Keyboard, Power Bank)
--
-- Tulis query Anda di sini:
select nama_produk, harga from produk where kategori = 'aksesori';



-- ============================================
-- SOAL NO. 3
-- ============================================
-- Tampilkan nama_pelanggan dan kota dari tabel pelanggan yang BERASAL dari kota 'Jakarta' atau 'Surabaya'
-- Expected: 4 baris (Budi, Siti, Dewi, Lisa)
-- Gunakan OR untuk multiple kondisi kota
--
-- Tulis query Anda di sini:

select nama_pelanggan, kota from pelanggan where kota='jakarta' or kota='surabaya';


-- ============================================
-- SOAL NO. 4
-- ============================================
-- Tampilkan id_pembelian, jumlah, dan total_harga dari tabel pembelian 
-- dimana total_harga LEBIH BESAR dari 1.000.000 (1 juta)
-- Expected: 6 baris
--
-- Tulis query Anda di sini:
SELECT id_pembelian, jumlah, total_harga FROM pembelian WHERE total_harga > 1000000;



-- ============================================
-- SOAL NO. 5 (Challenge - Kombinasi)
-- ============================================
-- Tampilkan nama_produk, kategori, harga dari tabel produk
-- WHERE: kategori = 'Elektronik' AND harga < 1.500.000
-- Expected: 2 baris (Webcam, Headphone) - tidak termasuk Laptop dan Monitor
--
-- Tulis query Anda di sini:
select nama_produk, kategori, harga where kategori='elektronik'and harga<1500000;