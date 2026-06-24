-- TOPIK 4: JAWABAN - CREATE TABLE + INSERT

-- ============================================
-- SOAL 1: Buat tabel `categories`
-- ============================================
CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nama_kategori VARCHAR(50) UNIQUE NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- SOAL 2: Buat tabel `inventori`
-- ============================================
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
INSERT INTO categories (nama_kategori) 
VALUES 
('Elektronik'),
('Fashion'),
('Makanan');

-- ============================================
-- SOAL 4: Insert sample data ke `inventori`
-- ============================================
INSERT INTO inventori (id_produk, lokasi, jumlah_stok) 
VALUES 
(1, 'Gudang A', 50),
(2, 'Gudang B', 30),
(3, 'Gudang A', 100),
(4, 'Gudang C', 15);

-- ============================================
-- SOAL 5: Query verification
-- ============================================
-- Query 1 - dari categories:
SELECT * FROM categories;

-- Query 2 - dari inventori:
SELECT * FROM inventori;

-- ============================================
-- EXPECTED OUTPUT
-- ============================================

-- categories:
-- id | nama_kategori | created_at
-- 1  | Elektronik    | 2026-06-12 XX:XX:XX
-- 2  | Fashion       | 2026-06-12 XX:XX:XX
-- 3  | Makanan       | 2026-06-12 XX:XX:XX

-- inventori:
-- id | id_produk | lokasi    | jumlah_stok | updated_at
-- 1  | 1         | Gudang A  | 50          | 2026-06-12 XX:XX:XX
-- 2  | 2         | Gudang B  | 30          | 2026-06-12 XX:XX:XX
-- 3  | 3         | Gudang A  | 100         | 2026-06-12 XX:XX:XX
-- 4  | 4         | Gudang C  | 15          | 2026-06-12 XX:XX:XX
