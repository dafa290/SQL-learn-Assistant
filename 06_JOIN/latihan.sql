-- ============================================
-- TOPIK 6: LATIHAN - JOIN (PEMBELAJARAN TANPA TIP)
-- ============================================
-- Database: toko_online
-- Tables: pelanggan, pembelian, produk
-- 
-- Tujuan: Latihan JOIN dengan requirement JELAS tapi TANPA TIP
-- (Challenge diri sendiri: no hints = prepare untuk ujian & interview)
-- 
-- Alur Pembelajaran:
-- 1. Baca materi.md untuk pahami konsep (INNER JOIN, LEFT JOIN, ON, WHERE)
-- 2. Kerjakan 5 soal di bawah - HANYA requirement, figure out sendiri
-- 3. Determine: table mana? JOIN apa? WHERE kondisi? ORDER BY apa?
-- 4. Cek jawaban di jawaban.sql bagian LATIHAN
-- 5. Jika >80% benar, lanjut ke ujian.sql
-- 
-- Catatan: Tidak ada TIP = same approach dengan ujian.sql nanti
-- Learning dari materi + challenge dengan soal = effective learning!

USE toko_online;

-- ============================================
-- SOAL 1: Tampilkan Pembelian dengan Info Pelanggan
-- ============================================
-- Requirement:
-- Tampilkan semua pembelian dengan informasi pelanggan
-- Kolom: nama_pelanggan, email, pembelian.id_pembelian, total_harga
-- Expected output: 12 baris (setelah update mock data)
--
-- Tulis query Anda di sini:
select 
pelanggan.nama_pelanggan,
pelanggan.email,
pembelian.id_pembelian,
pembelian.total_harga
from pembelian
inner join pelanggan on pembelian.id_pelanggan = pelanggan.id_pelanggan;


-- ============================================
-- SOAL 2: Detail Transaksi Lengkap
-- ============================================
-- Requirement:
-- Tampilkan detail transaksi lengkap: siapa beli apa
-- Kolom: nama_pelanggan, nama_produk, jumlah, total_harga, tanggal_beli
-- Urut: tanggal_beli DESC (terbaru dulu)
-- Expected output: 12 baris transaksi lengkap
--
-- Tulis query Anda di sini:
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


-- ============================================
-- SOAL 3: Semua Pelanggan Beserta Pembelian Mereka
-- ============================================
-- Requirement:
-- Tampilkan semua pelanggan beserta pembelian mereka
-- Termasuk pelanggan yang BELUM pernah beli
-- Kolom: nama_pelanggan, email, pembelian.id_pembelian AS pembelian_id, total_harga
-- Expected output: Semua pelanggan (termasuk yang belum beli dengan NULL values jika ada)
--
-- Tulis query Anda di sini:
SELECT 
    pelanggan.nama_pelanggan,
    pelanggan.email,
    pembelian.id_pembelian AS pembelian_id,
    pembelian.total_harga
FROM pelanggan
LEFT JOIN pembelian ON pelanggan.id_pelanggan = pembelian.id_pelanggan;


-- ============================================
-- SOAL 4: Transaksi High-Value (>1 Juta)
-- ============================================
-- Requirement:
-- Cari transaksi dengan total harga > 1.000.000
-- Tampilkan: nama_pelanggan, nama_produk, total_harga, tanggal_beli
-- Urut: total_harga DESC (transaksi besar dulu)
-- Expected output: Hanya transaksi > 1 juta
--
-- Tulis query Anda di sini:
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


-- ============================================
-- SOAL 5: Transaksi Kategori Elektronik
-- ============================================
-- Requirement:
-- Cari semua transaksi untuk produk kategori 'Elektronik'
-- Tampilkan: nama_pelanggan, nama_produk, kategori, total_harga, tanggal_beli
-- Urut: total_harga DESC (transaksi besar dulu)
-- Expected output: Transaksi produk Elektronik saja
--
-- Tulis query Anda di sini:
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


-- ============================================
-- NEXT: Setelah >80% BENAR
-- ============================================
-- Jika sudah paham 5 soal di atas, lanjut ke ujian.sql
-- ujian.sql = skenario real-world yang lebih kompleks
