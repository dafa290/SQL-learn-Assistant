-- ============================================
-- DATABASE SETUP UNTUK BELAJAR SQL
-- Database: toko_online
-- ============================================

-- Buat database
CREATE DATABASE IF NOT EXISTS toko_online;
USE toko_online;

-- ============================================
-- TABEL 1: PRODUK
-- ============================================
CREATE TABLE produk (
    id_produk INT PRIMARY KEY AUTO_INCREMENT,
    nama_produk VARCHAR(100) NOT NULL,
    kategori VARCHAR(50),
    harga INT,
    stok INT,
    tanggal_masuk DATE
);

INSERT INTO produk VALUES
(1, 'Laptop Dell', 'Elektronik', 8000000, 5, '2025-01-15'),
(2, 'Mouse Logitech', 'Aksesori', 250000, 20, '2025-02-01'),
(3, 'Keyboard Mechanical', 'Aksesori', 750000, 12, '2025-02-10'),
(4, 'Monitor LG 24 inch', 'Elektronik', 1500000, 8, '2025-03-05'),
(5, 'USB Cable', 'Kabel', 50000, 100, '2025-03-20'),
(6, 'Webcam HD', 'Elektronik', 600000, 3, '2025-04-01'),
(7, 'Headphone Sony', 'Audio', 1200000, 6, '2025-04-15'),
(8, 'Power Bank', 'Aksesori', 300000, 25, '2025-05-01'),
(9, 'T-Shirt Nike', 'Pakaian', 300000, 50, '2025-02-15'),
(10, 'Sepatu Adidas', 'Pakaian', 350000, 15, '2025-03-01'),
(11, 'Mousepad Gaming', 'Aksesori', 150000, 50, '2025-04-20');

-- ============================================
-- TABEL 2: PELANGGAN
-- ============================================
CREATE TABLE pelanggan (
    id_pelanggan INT PRIMARY KEY AUTO_INCREMENT,
    nama_pelanggan VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    kota VARCHAR(50),
    no_telp VARCHAR(15)
);

INSERT INTO pelanggan VALUES
(1, 'Budi Santoso', 'budi@email.com', 'Jakarta', '081234567890'),
(2, 'Siti Nurhaliza', 'siti@email.com', 'Surabaya', '082345678901'),
(3, 'Ahmad Hidayat', 'ahmad@email.com', 'Bandung', '083456789012'),
(4, 'Dewi Lestari', 'dewi@email.com', 'Jakarta', '084567890123'),
(5, 'Roni Hermawan', 'roni@email.com', 'Medan', '085678901234'),
(6, 'Lisa Manobal', 'lisa@email.com', 'Surabaya', '086789012345'),
(7, 'Sari Wijaya', 'sari@email.com', 'Jakarta', '087890123456');

-- ============================================
-- TABEL 3: PEMBELIAN
-- ============================================
CREATE TABLE pembelian (
    id_pembelian INT PRIMARY KEY AUTO_INCREMENT,
    id_pelanggan INT,
    id_produk INT,
    jumlah INT,
    total_harga INT,
    tanggal_beli DATE,
    FOREIGN KEY (id_pelanggan) REFERENCES pelanggan(id_pelanggan),
    FOREIGN KEY (id_produk) REFERENCES produk(id_produk)
);

INSERT INTO pembelian VALUES
(1, 1, 1, 1, 8000000, '2025-05-01'),
(2, 2, 3, 2, 1500000, '2025-05-02'),
(3, 3, 7, 1, 1200000, '2025-05-03'),
(4, 1, 2, 3, 750000, '2025-05-04'),
(5, 4, 4, 1, 1500000, '2025-05-05'),
(6, 2, 5, 5, 250000, '2025-05-06'),
(7, 5, 6, 1, 600000, '2025-05-07'),
(8, 6, 8, 2, 600000, '2025-05-08'),
(9, 3, 2, 1, 250000, '2025-05-09'),
(10, 4, 7, 1, 1200000, '2025-05-10'),
(11, 1, 9, 1, 300000, '2025-05-11'),
(12, 7, 10, 1, 350000, '2025-05-12');

-- ============================================
-- VERIFIKASI DATA
-- ============================================
SELECT * FROM produk;
SELECT * FROM pelanggan;
SELECT * FROM pembelian;
