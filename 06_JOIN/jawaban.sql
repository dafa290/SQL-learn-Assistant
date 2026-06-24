-- ============================================
-- TOPIK 6: JAWABAN - JOIN (REFERENCE ANSWERS)
-- ============================================
-- Struktur: 
-- - LATIHAN: Jawaban untuk 5 soal di latihan.sql
-- - UJIAN: Jawaban untuk 5 soal di ujian.sql (tanpa hint teknis, fokus bisnis)
-- 
-- Gunakan file ini untuk verifikasi setelah mengerjakan soal.

USE toko_online;

-- ============================================
-- ========== BAGIAN 1: JAWABAN LATIHAN ==========
-- ============================================

-- ============================================
-- JAWABAN LATIHAN - SOAL 1: Tampilkan Pembelian dengan Info Pelanggan
-- ============================================
SELECT 
    pelanggan.nama_pelanggan,
    pelanggan.email,
    pembelian.id_pembelian,
    pembelian.total_harga
FROM pembelian
INNER JOIN pelanggan ON pembelian.id_pelanggan = pelanggan.id_pelanggan;

-- Expected Output (12 baris):
-- Budi Santoso     | budi@email.com      | 1    | 8000000
-- Siti Nurhaliza   | siti@email.com      | 2    | 1500000
-- Ahmad Hidayat    | ahmad@email.com     | 3    | 1200000
-- Budi Santoso     | budi@email.com      | 4    | 750000
-- Dewi Lestari     | dewi@email.com      | 5    | 1500000
-- Siti Nurhaliza   | siti@email.com      | 6    | 250000
-- Roni Hermawan    | roni@email.com      | 7    | 600000
-- Lisa Manobal     | lisa@email.com      | 8    | 600000
-- Ahmad Hidayat    | ahmad@email.com     | 9    | 250000
-- Dewi Lestari     | dewi@email.com      | 10   | 1200000
-- Budi Santoso     | budi@email.com      | 11   | 300000
-- Sari Wijaya      | sari@email.com      | 12   | 350000

---

-- ============================================
-- JAWABAN LATIHAN - SOAL 2: Detail Transaksi Lengkap
-- ============================================
SELECT 
    pelanggan.nama_pelanggan,
    produk.nama_produk,
    pembelian.jumlah,
    pembelian.total_harga,
    pembelian.tanggal_beli
FROM pembelian
INNER JOIN pelanggan ON pembelian.id_pelanggan = pelanggan.id_pelanggan
INNER JOIN produk ON pembelian.id_produk = produk.id_produk
ORDER BY pembelian.tanggal_beli DESC;

-- Expected Output (12 baris - diurutkan dari tanggal terbaru):
-- Sari Wijaya     | Sepatu Adidas       | 1 | 350000  | 2025-05-12
-- Budi Santoso    | T-Shirt Nike        | 1 | 300000  | 2025-05-11
-- Dewi Lestari    | Headphone Sony      | 1 | 1200000 | 2025-05-10
-- Ahmad Hidayat   | Mouse Logitech      | 1 | 250000  | 2025-05-09
-- Lisa Manobal    | Power Bank          | 2 | 600000  | 2025-05-08
-- Roni Hermawan   | Webcam HD           | 1 | 600000  | 2025-05-07
-- Siti Nurhaliza  | USB Cable           | 5 | 250000  | 2025-05-06
-- Dewi Lestari    | Monitor LG 24 inch  | 1 | 1500000 | 2025-05-05
-- Budi Santoso    | Mouse Logitech      | 3 | 750000  | 2025-05-04
-- Ahmad Hidayat   | Headphone Sony      | 1 | 1200000 | 2025-05-03
-- Siti Nurhaliza  | Keyboard Mechanical | 2 | 1500000 | 2025-05-02
-- Budi Santoso    | Laptop Dell         | 1 | 8000000 | 2025-05-01

---

-- ============================================
-- JAWABAN LATIHAN - SOAL 3: Semua Pelanggan Beserta Pembelian Mereka
-- ============================================
SELECT 
    pelanggan.nama_pelanggan,
    pelanggan.email,
    pembelian.id_pembelian AS pembelian_id,
    pembelian.total_harga
FROM pelanggan
LEFT JOIN pembelian ON pelanggan.id_pelanggan = pembelian.id_pelanggan;

-- Expected Output (12 baris):
-- Menampilkan semua pelanggan. Jika suatu saat ada pelanggan yang belum pernah beli, 
-- nama mereka akan tetap muncul di daftar dengan kolom pembelian_id & total_harga berisi NULL.
-- (Karena saat ini semua pelanggan 1-7 di mock data memiliki transaksi, semua baris terisi).

---

-- ============================================
-- JAWABAN LATIHAN - SOAL 4: Transaksi High-Value (>1 Juta)
-- ============================================
SELECT 
    pelanggan.nama_pelanggan,
    produk.nama_produk,
    pembelian.total_harga,
    pembelian.tanggal_beli
FROM pembelian
INNER JOIN pelanggan ON pembelian.id_pelanggan = pelanggan.id_pelanggan
INNER JOIN produk ON pembelian.id_produk = produk.id_produk
WHERE pembelian.total_harga > 1000000
ORDER BY pembelian.total_harga DESC;

-- Expected Output (5 baris):
-- Budi Santoso   | Laptop Dell        | 8000000 | 2025-05-01
-- Siti Nurhaliza | Keyboard Mechanical| 1500000 | 2025-05-02
-- Dewi Lestari   | Monitor LG 24 inch | 1500000 | 2025-05-05
-- Ahmad Hidayat  | Headphone Sony     | 1200000 | 2025-05-03
-- Dewi Lestari   | Headphone Sony     | 1200000 | 2025-05-10

---

-- ============================================
-- JAWABAN LATIHAN - SOAL 5: Transaksi Kategori Elektronik
-- ============================================
SELECT 
    pelanggan.nama_pelanggan,
    produk.nama_produk,
    produk.kategori,
    pembelian.total_harga,
    pembelian.tanggal_beli
FROM pembelian
INNER JOIN pelanggan ON pembelian.id_pelanggan = pelanggan.id_pelanggan
INNER JOIN produk ON pembelian.id_produk = produk.id_produk
WHERE produk.kategori = 'Elektronik'
ORDER BY pembelian.total_harga DESC;

-- Expected Output (3 baris):
-- Budi Santoso | Laptop Dell        | Elektronik | 8000000 | 2025-05-01
-- Dewi Lestari | Monitor LG 24 inch | Elektronik | 1500000 | 2025-05-05
-- Roni Hermawan| Webcam HD          | Elektronik | 600000  | 2025-05-07

---


-- ============================================
-- ========== BAGIAN 2: JAWABAN UJIAN ==========
-- ============================================

-- ============================================
-- JAWABAN UJIAN - SOAL 1: Daily Sales Report
-- ============================================
-- Analisis Bisnis: 
-- Laporan hanya menampilkan pelanggan yang benar-benar bertransaksi -> gunakan INNER JOIN
-- Diurutkan dari transaksi terbaru -> gunakan ORDER BY tanggal_beli DESC
SELECT 
    pelanggan.nama_pelanggan,
    pelanggan.email,
    pembelian.id_pembelian,
    pembelian.total_harga
FROM pembelian
INNER JOIN pelanggan ON pembelian.id_pelanggan = pelanggan.id_pelanggan
ORDER BY pembelian.tanggal_beli DESC;

-- Expected Output (12 baris, terurut dari transaksi terbaru):
-- Sari Wijaya     | sari@email.com      | 12   | 350000
-- Budi Santoso    | budi@email.com      | 11   | 300000
-- Dewi Lestari    | dewi@email.com      | 10   | 1200000
-- Ahmad Hidayat   | ahmad@email.com     | 9    | 250000
-- ... dst

---

-- ============================================
-- JAWABAN UJIAN - SOAL 2: Transaction Detail Report
-- ============================================
-- Analisis Bisnis:
-- Memerlukan informasi dari 3 tabel (pelanggan, produk, pembelian) -> gunakan 2 INNER JOIN
-- Diurutkan berdasarkan tanggal terbaru ke terlama, jika tanggal sama urutkan nama produk A-Z -> gunakan ORDER BY tanggal_beli DESC, nama_produk ASC
SELECT 
    pelanggan.nama_pelanggan,
    produk.nama_produk,
    pembelian.jumlah,
    pembelian.total_harga,
    pembelian.tanggal_beli
FROM pembelian
INNER JOIN pelanggan ON pembelian.id_pelanggan = pelanggan.id_pelanggan
INNER JOIN produk ON pembelian.id_produk = produk.id_produk
ORDER BY pembelian.tanggal_beli DESC, produk.nama_produk ASC;

-- Expected Output (12 baris):
-- Sari Wijaya     | Sepatu Adidas       | 1 | 350000  | 2025-05-12
-- Budi Santoso    | T-Shirt Nike        | 1 | 300000  | 2025-05-11
-- Dewi Lestari    | Headphone Sony      | 1 | 1200000 | 2025-05-10
-- ... dst

---

-- ============================================
-- JAWABAN UJIAN - SOAL 3: Customer Activity Audit
-- ============================================
-- Analisis Bisnis:
-- Menampilkan SELURUH pelanggan baik yang sudah bertransaksi maupun belum -> gunakan LEFT JOIN dari tabel pelanggan ke tabel pembelian
SELECT 
    pelanggan.nama_pelanggan,
    pelanggan.email,
    pembelian.id_pembelian,
    pembelian.total_harga
FROM pelanggan
LEFT JOIN pembelian ON pelanggan.id_pelanggan = pembelian.id_pelanggan;

-- Expected Output (12 baris):
-- Menampilkan daftar lengkap semua pelanggan beserta transaksi mereka. 
-- Pelanggan yang belum pernah membeli akan tetap muncul dengan nilai NULL pada kolom transaksi.

---

-- ============================================
-- JAWABAN UJIAN - SOAL 4: High Value Transaction Analysis
-- ============================================
-- Analisis Bisnis:
-- Menampilkan detail transaksi (pelanggan + produk) bernilai di atas Rp 1.000.000 -> gunakan INNER JOIN dengan filter WHERE total_harga > 1000000
-- Diurutkan dari nilai transaksi terbesar -> gunakan ORDER BY total_harga DESC
SELECT 
    pelanggan.nama_pelanggan,
    produk.nama_produk,
    pembelian.total_harga,
    pembelian.tanggal_beli
FROM pembelian
INNER JOIN pelanggan ON pembelian.id_pelanggan = pelanggan.id_pelanggan
INNER JOIN produk ON pembelian.id_produk = produk.id_produk
WHERE pembelian.total_harga > 1000000
ORDER BY pembelian.total_harga DESC;

-- Expected Output (5 baris):
-- Budi Santoso   | Laptop Dell        | 8000000 | 2025-05-01
-- Siti Nurhaliza | Keyboard Mechanical| 1500000 | 2025-05-02
-- Dewi Lestari   | Monitor LG 24 inch | 1500000 | 2025-05-05
-- Ahmad Hidayat  | Headphone Sony     | 1200000 | 2025-05-03
-- Dewi Lestari   | Headphone Sony     | 1200000 | 2025-05-10

---

-- ============================================
-- JAWABAN UJIAN - SOAL 5: Product Category Sales Report
-- ============================================
-- Analisis Bisnis:
-- Menampilkan detail transaksi untuk kategori produk 'Pakaian' -> gunakan JOIN dengan WHERE kategori = 'Pakaian'
-- Diurutkan dari transaksi terbaru -> gunakan ORDER BY tanggal_beli DESC
SELECT 
    pelanggan.nama_pelanggan,
    produk.nama_produk,
    produk.kategori,
    pembelian.total_harga,
    pembelian.tanggal_beli
FROM pembelian
INNER JOIN pelanggan ON pembelian.id_pelanggan = pelanggan.id_pelanggan
INNER JOIN produk ON pembelian.id_produk = produk.id_produk
WHERE produk.kategori = 'Pakaian'
ORDER BY pembelian.tanggal_beli DESC;

-- Expected Output (2 baris):
-- Sari Wijaya  | Sepatu Adidas | Pakaian | 350000 | 2025-05-12
-- Budi Santoso | T-Shirt Nike  | Pakaian | 300000 | 2025-05-11

---

-- ============================================
-- JAWABAN UJIAN - SOAL 6: Target City Logistics Report
-- ============================================
-- Analisis Bisnis:
-- Menampilkan data dari 3 tabel (pelanggan, produk, pembelian) untuk pelanggan di kota 'Jakarta' -> gunakan 2 INNER JOIN
-- Filter: pelanggan.kota = 'Jakarta'
-- Urutan: produk.nama_produk secara alfabetis (A-Z)
SELECT 
    pelanggan.nama_pelanggan,
    pelanggan.kota,
    produk.nama_produk,
    pembelian.jumlah
FROM pembelian
INNER JOIN pelanggan ON pembelian.id_pelanggan = pelanggan.id_pelanggan
INNER JOIN produk ON pembelian.id_produk = produk.id_produk
WHERE pelanggan.kota = 'Jakarta'
ORDER BY produk.nama_produk ASC;

-- Expected Output (6 baris):
-- Dewi Lestari   | Jakarta | Headphone Sony     | 1
-- Budi Santoso   | Jakarta | Laptop Dell        | 1
-- Dewi Lestari   | Jakarta | Monitor LG 24 inch | 1
-- Budi Santoso   | Jakarta | Mouse Logitech     | 3
-- Sari Wijaya    | Jakarta | Sepatu Adidas      | 1
-- Budi Santoso   | Jakarta | T-Shirt Nike       | 1

---

-- ============================================
-- JAWABAN UJIAN - SOAL 7: Product Performance Audit
-- ============================================
-- Analisis Bisnis:
-- Menampilkan SELURUH produk yang terdaftar, bahkan yang belum pernah terjual -> gunakan LEFT JOIN dari produk ke pembelian
-- Urutan: produk.kategori A-Z, kemudian produk.nama_produk A-Z
SELECT 
    produk.id_produk,
    produk.nama_produk,
    produk.kategori,
    pembelian.id_pembelian,
    pembelian.jumlah
FROM produk
LEFT JOIN pembelian ON produk.id_produk = pembelian.id_produk
ORDER BY produk.kategori ASC, produk.nama_produk ASC;

-- Expected Output (13 baris):
-- Menampilkan semua 11 produk. Produk 'Mousepad Gaming' (kategori Aksesori, ID 11) 
-- akan tampil di daftar dengan id_pembelian dan jumlah bernilai NULL karena belum pernah terjual.

---

-- ============================================
-- JAWABAN UJIAN - SOAL 8: Transaction Integrity Audit
-- ============================================
-- Analisis Bisnis:
-- Harus menempatkan pelanggan di sebelah kiri (FROM pelanggan) namun menampilkan seluruh data transaksi (pembelian) -> gunakan RIGHT JOIN
-- Urutan: total_harga dari terbesar ke terkecil (total_harga DESC)
SELECT 
    pembelian.id_pembelian,
    pembelian.tanggal_beli,
    pembelian.total_harga,
    pelanggan.nama_pelanggan,
    pelanggan.email
FROM pelanggan
RIGHT JOIN pembelian ON pelanggan.id_pelanggan = pembelian.id_pelanggan
ORDER BY pembelian.total_harga DESC;

-- Expected Output (12 baris):
-- Seluruh 12 transaksi akan muncul lengkap, diurutkan dari transaksi terbesar (8.000.000) ke terkecil (250.000).

---

-- ============================================
-- VERIFICATION QUERIES - Gunakan untuk double-check data Anda
-- ============================================
-- 1. Total transaksi di sistem
SELECT COUNT(*) as total_transaksi FROM pembelian;

-- 2. Tampilkan semua produk pakaian
SELECT * FROM produk WHERE kategori = 'Pakaian';

-- 3. Tampilkan semua pelanggan terdaftar
SELECT * FROM pelanggan;
