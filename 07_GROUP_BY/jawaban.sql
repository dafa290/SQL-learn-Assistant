-- ============================================
-- TOPIK 7: JAWABAN - GROUP BY & AGGREGATE FUNCTIONS
-- ============================================
-- Struktur:
-- - BAGIAN 1: Jawaban Latihan (latihan.sql)
-- - BAGIAN 2: Jawaban Ujian (ujian.sql)
--
-- Gunakan file ini sebagai acuan pencocokan mandiri.
-- ============================================

USE toko_online;

-- ============================================
-- ========== BAGIAN 1: JAWABAN LATIHAN ==========
-- ============================================

-- ============================================
-- JAWABAN LATIHAN - SOAL 1: Statistik Dasar Produk
-- ============================================
SELECT 
    COUNT(*) AS total_produk,
    AVG(harga) AS rata_rata_harga,
    MIN(harga) AS harga_termurah,
    MAX(harga) AS harga_termahal
FROM produk;

-- Expected Output (1 baris):
-- total_produk | rata_rata_harga | harga_termurah | harga_termahal
-- 11           | 1295454.5455    | 50000          | 8000000


-- ============================================
-- JAWABAN LATIHAN - SOAL 2: Total Stok per Kategori Produk
-- ============================================
SELECT 
    kategori,
    SUM(stok) AS total_stok
FROM produk
GROUP BY kategori
ORDER BY total_stok DESC;

-- Expected Output (5 baris):
-- kategori   | total_stok
-- Aksesori   | 107
-- Kabel      | 100
-- Pakaian    | 65
-- Elektronik | 16
-- Audio      | 6


-- ============================================
-- JAWABAN LATIHAN - SOAL 3: Total Pengeluaran Belanja per Pelanggan
-- ============================================
SELECT 
    pelanggan.nama_pelanggan,
    pelanggan.kota,
    SUM(pembelian.total_harga) AS total_belanja
FROM pelanggan
INNER JOIN pembelian ON pelanggan.id_pelanggan = pembelian.id_pelanggan
GROUP BY pelanggan.id_pelanggan, pelanggan.nama_pelanggan, pelanggan.kota
ORDER BY total_belanja DESC;

-- Expected Output (7 baris):
-- nama_pelanggan | kota     | total_belanja
-- Budi Santoso   | Jakarta  | 9050000
-- Dewi Lestari   | Jakarta  | 2700000
-- Siti Nurhaliza | Surabaya | 1750000
-- Ahmad Hidayat  | Bandung  | 1450000
-- Roni Hermawan  | Medan    | 600000
-- Lisa Manobal   | Surabaya | 600000
-- Sari Wijaya    | Jakarta  | 350000


-- ============================================
-- JAWABAN LATIHAN - SOAL 4: Jumlah Transaksi Pembelian per Kota
-- ============================================
SELECT 
    pelanggan.kota,
    COUNT(pembelian.id_pembelian) AS jumlah_transaksi
FROM pelanggan
INNER JOIN pembelian ON pelanggan.id_pelanggan = pembelian.id_pelanggan
GROUP BY pelanggan.kota
ORDER BY jumlah_transaksi DESC;

-- Expected Output (4 baris):
-- kota     | jumlah_transaksi
-- Jakarta  | 6
-- Surabaya | 3
-- Bandung  | 2
-- Medan    | 1


-- ============================================
-- JAWABAN LATIHAN - SOAL 5: Pelanggan Premium
-- ============================================
SELECT 
    pelanggan.nama_pelanggan,
    SUM(pembelian.total_harga) AS total_belanja
FROM pelanggan
INNER JOIN pembelian ON pelanggan.id_pelanggan = pembelian.id_pelanggan
GROUP BY pelanggan.id_pelanggan, pelanggan.nama_pelanggan
HAVING total_belanja > 1000000
ORDER BY total_belanja DESC;

-- Expected Output (4 baris):
-- nama_pelanggan | total_belanja
-- Budi Santoso   | 9050000
-- Dewi Lestari   | 2700000
-- Siti Nurhaliza | 1750000
-- Ahmad Hidayat  | 1450000



-- ============================================
-- ========== BAGIAN 2: JAWABAN UJIAN ==========
-- ============================================

-- ============================================
-- JAWABAN UJIAN - SOAL 1: Pendapatan dan Volume Penjualan Toko
-- ============================================
SELECT 
    SUM(total_harga) AS total_pendapatan,
    SUM(jumlah) AS total_unit_terjual,
    AVG(total_harga) AS rata_rata_transaksi,
    MAX(total_harga) AS transaksi_terbesar
FROM pembelian;

-- Expected Output (1 baris):
-- total_pendapatan | total_unit_terjual | rata_rata_transaksi | transaksi_terbesar
-- 16500000         | 20                 | 1375000.0000        | 8000000


-- ============================================
-- JAWABAN UJIAN - SOAL 2: Kontribusi Penjualan per Kategori
-- ============================================
SELECT 
    produk.kategori,
    SUM(pembelian.jumlah) AS unit_terjual,
    SUM(pembelian.total_harga) AS total_pendapatan
FROM pembelian
INNER JOIN produk ON pembelian.id_produk = produk.id_produk
GROUP BY produk.kategori
ORDER BY total_pendapatan DESC;

-- Expected Output (5 baris):
-- kategori   | unit_terjual | total_pendapatan
-- Elektronik | 3            | 10100000
-- Audio      | 2            | 2400000
-- Aksesori   | 8            | 3100000
-- Pakaian    | 2            | 650000
-- Kabel      | 5            | 250000


-- ============================================
-- JAWABAN UJIAN - SOAL 3: Demografi Pelanggan Aktif per Kota
-- ============================================
SELECT 
    pelanggan.kota,
    COUNT(DISTINCT pelanggan.id_pelanggan) AS jumlah_pelanggan_aktif
FROM pelanggan
INNER JOIN pembelian ON pelanggan.id_pelanggan = pembelian.id_pelanggan
WHERE pelanggan.email LIKE '%email.com'
GROUP BY pelanggan.kota
ORDER BY jumlah_pelanggan_aktif DESC;

-- Expected Output (4 baris):
-- kota     | jumlah_pelanggan_aktif
-- Jakarta  | 3
-- Surabaya | 2
-- Bandung  | 1
-- Medan    | 1


-- ============================================
-- JAWABAN UJIAN - SOAL 4: Produk Paling Sering Dibeli
-- ============================================
SELECT 
    produk.id_produk,
    produk.nama_produk,
    COUNT(pembelian.id_pembelian) AS frekuensi_pembelian
FROM pembelian
INNER JOIN produk ON pembelian.id_produk = produk.id_produk
GROUP BY produk.id_produk, produk.nama_produk
ORDER BY frekuensi_pembelian DESC, produk.nama_produk ASC;

-- Expected Output (8 baris):
-- id_produk | nama_produk         | frekuensi_pembelian
-- 2         | Mouse Logitech      | 2
-- 7         | Headphone Sony      | 2
-- 1         | Laptop Dell         | 1
-- 3         | Keyboard Mechanical | 1
-- 4         | Monitor LG 24 inch  | 1
-- 5         | USB Cable           | 1
-- 6         | Webcam HD           | 1
-- 8         | Power Bank          | 1
-- 9         | T-Shirt Nike        | 1
-- 10        | Sepatu Adidas       | 1


-- ============================================
-- JAWABAN UJIAN - SOAL 5: Kategori Performa Tinggi (Pendapatan > 1.000.000)
-- ============================================
SELECT 
    produk.kategori,
    SUM(pembelian.total_harga) AS total_pendapatan
FROM pembelian
INNER JOIN produk ON pembelian.id_produk = produk.id_produk
GROUP BY produk.kategori
HAVING total_pendapatan > 1000000
ORDER BY total_pendapatan DESC;

-- Expected Output (3 baris):
-- kategori   | total_pendapatan
-- Elektronik | 10100000
-- Aksesori   | 3100000
-- Audio      | 2400000


-- ============================================
-- JAWABAN UJIAN - SOAL 6: Tren Nilai Transaksi Harian
-- ============================================
SELECT 
    pembelian.tanggal_beli,
    COUNT(pembelian.id_pembelian) AS jumlah_transaksi,
    SUM(pembelian.total_harga) AS total_pendapatan_harian
FROM pembelian
GROUP BY pembelian.tanggal_beli
ORDER BY pembelian.tanggal_beli ASC;

-- Expected Output (12 baris):
-- tanggal_beli | jumlah_transaksi | total_pendapatan_harian
-- 2025-05-01   | 1                | 8000000
-- 2025-05-02   | 1                | 1500000
-- 2025-05-03   | 1                | 1200000
-- 2025-05-04   | 1                | 750000
-- 2025-05-05   | 1                | 1500000
-- 2025-05-06   | 1                | 250000
-- 2025-05-07   | 1                | 600000
-- 2025-05-08   | 1                | 600000
-- 2025-05-09   | 1                | 250000
-- 2025-05-10   | 1                | 1200000
-- 2025-05-11   | 1                | 300000
-- 2025-05-12   | 1                | 350000
