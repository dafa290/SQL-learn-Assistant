-- TOPIK 5: LATIHAN - UPDATE + DELETE

-- Database: toko_online
-- Tables: categories, inventori (dari TOPIK 4)
-- Gunakan UPDATE dan DELETE dengan WHERE!

-- ============================================
-- SOAL 1: Update single column
-- ============================================
-- Requirement:
-- Dari tabel categories, ubah nama kategori pada row dengan id=1
-- - Ubah dari: 'Elektronik' menjadi 'Elektronik Premium'
-- - Kondisi: HANYA row id=1 yang diubah, row lain tetap sama
-- Expected: categories id=1 nama berubah, id=2 (Fashion) dan id=3 (Makanan) tidak berubah
--
-- Tulis UPDATE statement:

-- (Tulis jawaban Anda di sini)
UPDATE categories 
SET nama_kategori = 'Elektronik Premium' 
WHERE id = 1;

-- ============================================
-- SOAL 2: Update multiple columns dengan WHERE
-- ============================================
-- Requirement:
-- Dari tabel inventori, update row dengan id=2:
-- - Ubah jumlah_stok menjadi 50
-- - Ubah lokasi menjadi 'Gudang A'
-- - Kondisi: HANYA row id=2 yang diubah, row lain tetap sama
-- Catatan: Kedua perubahan (stok dan lokasi) dalam 1 UPDATE statement
-- Expected: inventori id=2 berubah menjadi stok 50 dan lokasi Gudang A, id=1,3,4 tidak berubah
--
-- Tulis UPDATE statement:

-- (Tulis jawaban Anda di sini)
UPDATE inventori 
SET jumlah_stok = 50, lokasi = 'Gudang A' 
WHERE id = 2;

-- ============================================
-- SOAL 3: Update dengan arithmetic (kurangi stok)
-- ============================================
-- Requirement:
-- Dari tabel inventori, kurangi jumlah_stok sebanyak 20 untuk row dengan id_produk=3
-- - Kondisi: HANYA row id_produk=3 yang diubah
-- - Operasi: Stok dikurangi 20 (bukan fixed value, tapi berkurang dari current)
-- - Konteks: Simulasi pengambilan/pickup barang dari gudang (stok berkurang)
-- Expected: inventori id_produk=3 stok berkurang 20 (dari 100 menjadi 80), row lain tetap sama
--
-- Tulis UPDATE statement:

-- (Tulis jawaban Anda di sini)
UPDATE inventori 
SET jumlah_stok = jumlah_stok - 20 
WHERE id_produk = 3;

-- ============================================
-- SOAL 4: Soft Delete Pattern (Update status)
-- ============================================
-- Requirement:
-- Soft delete adalah production pattern: data tidak dihapus, hanya ditandai 'inactive'
-- Table categories sudah punya column `status ENUM('active', 'inactive')`
-- 
-- Update row id=2 (Fashion) untuk soft delete:
-- - Ubah status menjadi 'inactive' (tandai sebagai deleted, tapi data masih ada)
-- - Kondisi: HANYA row id=2 yang diubah
-- - Expected: Fashion masih ada di tabel, tapi status='inactive'
--
-- Tulis UPDATE statement untuk soft delete:

-- (Tulis jawaban Anda di sini)
UPDATE categories 
SET status = 'inactive' 
WHERE id = 2;

-- ============================================
-- SOAL 5: Hard Delete dengan WHERE condition
-- ============================================
-- Requirement:
-- Hard delete adalah permanent removal (data benar-benar hilang dari database)
-- Kasus: Hapus semua barang dengan stok = 0 (barang tidak tersedia atau sudah lama tidak ada)
-- 
-- Step 1: Update inventori dengan id_produk=4 untuk ubah stoknya menjadi 0
-- - Kondisi: HANYA row id_produk=4 yang diubah
-- 
-- Step 2: Delete dari inventori semua row yang punya jumlah_stok = 0
-- - Kondisi: WHERE jumlah_stok = 0
-- - Catatan: Ini akan menghapus row id_produk=4 (yang stoknya sudah diset 0 di step 1)
-- - PENTING: Selalu gunakan WHERE! Jangan delete tanpa kondisi (fatal!)
-- 
-- Expected: 
-- - Sebelum: inventori ada 4 row (id_produk 1,2,3,4)
-- - Sesudah: inventori ada 3 row (id_produk 1,2,3 saja; id_produk 4 dihapus permanent)
--
-- Tulis 2 statements:
-- 1. UPDATE untuk set id_produk=4 stoknya 0
-- 2. DELETE untuk hapus barang dengan stok 0

-- (Tulis jawaban Anda di sini)
UPDATE inventori 
SET jumlah_stok = 0 
WHERE id_produk = 4;
DELETE FROM inventori 
WHERE jumlah_stok = 0;

-- ============================================
-- VERIFICATION (jalankan query ini untuk cek)
-- ============================================
-- Query 1: Lihat categories setelah soal 1, 2, 4
SELECT * FROM categories;

-- Query 2: Lihat inventori setelah soal 2, 3, 5
SELECT * FROM inventori;
