-- TOPIK 5: JAWABAN - UPDATE + DELETE

-- ============================================
-- SOAL 1: Update single column
-- ============================================
UPDATE categories 
SET nama_kategori = 'Elektronik Premium' 
WHERE id = 1;

-- ============================================
-- SOAL 2: Update multiple columns
-- ============================================
UPDATE inventori 
SET jumlah_stok = 50, lokasi = 'Gudang A' 
WHERE id = 2;

-- ============================================
-- SOAL 3: Update dengan arithmetic
-- ============================================
UPDATE inventori 
SET jumlah_stok = jumlah_stok - 20 
WHERE id_produk = 3;

-- ============================================
-- SOAL 4: Soft Delete (Update status column)
-- ============================================
UPDATE categories 
SET status = 'inactive' 
WHERE id = 2;

-- ============================================
-- SOAL 5: Hard Delete dengan WHERE
-- ============================================
-- Step 1: Set stok 0 untuk id_produk = 4
UPDATE inventori 
SET jumlah_stok = 0 
WHERE id_produk = 4;

-- Step 2: Hard delete barang dengan stok 0
DELETE FROM inventori 
WHERE jumlah_stok = 0;

-- ============================================
-- EXPECTED OUTPUT
-- ============================================

-- categories (setelah soal 1, 2, 4):
-- id | nama_kategori         | created_at            | status
-- 1  | Elektronik Premium    | 2026-06-12 XX:XX:XX   | active
-- 2  | Fashion               | 2026-06-12 XX:XX:XX   | inactive  ← soft deleted
-- 3  | Makanan               | 2026-06-12 XX:XX:XX   | active

-- inventori (setelah soal 2, 3, 5):
-- id | id_produk | lokasi    | jumlah_stok | updated_at
-- 1  | 1         | Gudang A  | 50          | 2026-06-12 XX:XX:XX
-- 2  | 2         | Gudang A  | 50          | 2026-06-12 XX:XX:XX (updated by soal 2)
-- 3  | 3         | Gudang A  | 80          | 2026-06-12 XX:XX:XX (updated by soal 3: 100-20)
-- (id_produk 4 deleted by soal 5)

-- VERIFICATION:
SELECT * FROM categories;
SELECT * FROM inventori;
