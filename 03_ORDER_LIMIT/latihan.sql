-- ============================================
-- TOPIK 3: ORDER BY + LIMIT + LIKE
-- LATIHAN (EXERCISES)
-- ============================================
-- Database: toko_online
-- Tables: produk, pelanggan, pembelian

USE toko_online;

-- ============================================
-- SOAL 1: ORDER BY Dasar (Harga Termahal Dulu)
-- ============================================
-- Requirement: Tampilkan nama produk dan harga dari SEMUA produk
-- Urut berdasarkan harga (termahal dulu)
-- Tampilkan 4 kolom: nama_produk, harga, kategori, stok
-- Expected output: 8 produk, urut harga DESC
--
-- Tulis query Anda di sini:
SELECT nama_produk,harga, kategori, stok
FROM produk
 ORDER BY harga DESC;



-- ============================================
-- SOAL 2: LIMIT - Top 3 Produk
-- ============================================
-- Requirement: Tampilkan top 3 produk dengan harga termahal
-- Kolom: nama_produk, harga
-- Expected output: 3 produk (Laptop Dell, Monitor LG, Keyboard Mech)
-- TIP: Kombinasi ORDER BY DESC + LIMIT 3
--
-- Tulis query Anda di sini:
SELECT nama_produk, harga FROM produk
 ORDER BY harga 
 DESC LIMIT 3;



-- ============================================
-- SOAL 3: LIKE - Search Produk
-- ============================================
-- Requirement: Cari produk dengan nama mengandung 'phone' (case-insensitive)
-- Tampilkan: nama_produk, kategori, harga
-- Expected output: 2 produk (Headphone, Smartphone)
--
-- Tulis query Anda di sini:
select nama_produk, kategori, harga from produk where nama_produk kategori, like '%phone%';



-- ============================================
-- SOAL 4: WHERE + LIKE + ORDER BY
-- ============================================
-- Requirement: Cari pelanggan yang namanya mengandung 'a' atau 'A'
-- Tampilkan: nama_pelanggan, email, kota
-- Urut berdasarkan nama A-Z (ascending)
-- Expected output: 5 pelanggan (Ahmad, Sari, Budi, Rahma, Sita - filter hanya yang ada 'a')
-- TIP: LIKE '%a%' case-insensitive, ORDER BY ASC
--
-- Tulis query Anda di sini:
select nama_pelanggan, email, kota
where nama_pelanggan  like '%a%'
order by nama_pelanggan asc;


-- ============================================
-- SOAL 5: LIMIT + OFFSET - Pagination
-- ============================================
-- Requirement: Pagination untuk daftar pelanggan
-- Scenario: Halaman 2, 2 pelanggan per halaman
-- Tampilkan: nama_pelanggan, email
-- Urut: nama A-Z
-- Expected output: 2 pelanggan (dari pelanggan ke-3 dan ke-4)
-- TIP: LIMIT 2 OFFSET 2 (skip 2 baris pertama, ambil 2 berikutnya)
--
-- Tulis query Anda di sini:
SELECT nama_pelanggan, email FROM pelanggan
ORDER BY nama_pelanggan ASC LIMIT 2 OFFSET 2;