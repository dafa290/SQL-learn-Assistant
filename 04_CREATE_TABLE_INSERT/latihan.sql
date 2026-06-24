-- TOPIK 4: LATIHAN - CREATE TABLE + INSERT

-- Database: toko_online
-- Pastikan sudah setup.sql sebelumnya!

-- ============================================
-- SOAL 1: Buat tabel `categories`
-- ============================================
-- Requirement:
-- - id (PRIMARY KEY, AUTO_INCREMENT)
-- - nama_kategori (VARCHAR 50, UNIQUE, NOT NULL)
-- - created_at (DATETIME, default CURRENT_TIMESTAMP) - otomatis set waktu sekarang saat INSERT
-- 
-- Tulis CREATE TABLE statement di bawah:

-- (Tulis jawaban Anda di sini)
CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nama_kategori VARCHAR(50) UNIQUE NOT NULL,
    status ENUM('active', 'inactive') DEFAULT 'active',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);


-- ============================================
-- SOAL 2: Buat tabel `inventori`
-- ============================================
-- Requirement:
-- - id (PRIMARY KEY, AUTO_INCREMENT)
-- - id_produk (INT, NOT NULL) - dari tabel produk
-- - lokasi (VARCHAR 100) - tempat penyimpanan
-- - jumlah_stok (INT DEFAULT 0)
-- - updated_at (DATETIME dengan 2 properties):
--   * DEFAULT CURRENT_TIMESTAMP = set waktu INSERT otomatis
--   * ON UPDATE CURRENT_TIMESTAMP = update waktu otomatis saat row diubah
--   → Ini untuk "track kapan data terakhir dimodifikasi" (audit trail)
-- 
-- Tulis CREATE TABLE statement:

-- (Tulis jawaban Anda di sini)

CREATE TABLE inventori (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_produk INT NOT NULL,
    lokasi VARCHAR(100),
    jumlah_stok INT DEFAULT 0,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ============================================
-- SOAL 3: Insert sample data ke `categories`
-- ============================================
-- Insert 3 kategori baru:
-- 1. Elektronik
-- 2. Fashion
-- 3. Makanan
-- 
-- Tulis INSERT statement:

-- (Tulis jawaban Anda di sini)
INSERT INTO categories (nama_kategori) 
VALUES 
('Elektronik'),
('Fashion'),
('Makanan');


-- ============================================
-- SOAL 4: Insert sample data ke `inventori`
-- ============================================
-- Insert 4 records:
-- - id_produk 1, lokasi 'Gudang A', jumlah_stok 50
-- - id_produk 2, lokasi 'Gudang B', jumlah_stok 30
-- - id_produk 3, lokasi 'Gudang A', jumlah_stok 100
-- - id_produk 4, lokasi 'Gudang C', jumlah_stok 15
-- 
-- Tulis INSERT statement:

-- (Tulis jawaban Anda di sini)
INSERT INTO inventori (id_produk, lokasi, jumlah_stok) 
VALUES 
(1, 'Gudang A', 50),
(2, 'Gudang B', 30),
(3, 'Gudang A', 100),
(4, 'Gudang C', 15);

-- ============================================
-- SOAL 5: Query verification
-- ============================================
-- Verify hasil INSERT:
-- - SELECT dari categories (harus 3 rows)
-- - SELECT dari inventori (harus 4 rows)
-- 
-- Tulis SELECT statement (2 queries):

-- Query 1 - dari categories:
-- (Tulis jawaban Anda di sini)

-- Query 2 - dari inventori:
-- (Tulis jawaban Anda di sini)
-- Query 1 - dari categories:
SELECT * FROM categories;

-- Query 2 - dari inventori:
SELECT * FROM inventori;
-- ============================================
-- HINTS
-- ============================================
-- Tabel categories sudah ada? Cek dengan: SHOW TABLES;
-- Data sudah insert? Cek dengan: SELECT COUNT(*) FROM categories;
-- Struktur tabel? Cek dengan: DESCRIBE categories;
