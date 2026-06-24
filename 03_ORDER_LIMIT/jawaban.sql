-- ============================================
-- TOPIK 3: ORDER BY + LIMIT + LIKE
-- JAWABAN (REFERENCE ANSWERS)
-- ============================================

USE toko_online;

-- ============================================
-- SOAL 1: ORDER BY Dasar
-- ============================================
-- ✅ JAWABAN:
SELECT nama_produk, harga, kategori, stok FROM produk ORDER BY harga DESC;

-- Expected Output:
-- nama_produk         | harga     | kategori   | stok
-- Laptop Dell         | 1500000   | Elektronik | 5
-- Monitor LG          | 1200000   | Elektronik | 8
-- Keyboard Mech       | 750000    | Aksesori   | 15
-- Headphone           | 500000    | Audio      | 20
-- Webcam              | 500000    | Aksesori   | 12
-- Smartphone          | 3000000   | Elektronik | 3
-- Mouse               | 200000    | Aksesori   | 25
-- SSD Samsung         | 800000    | Storage    | 10

-- Urutan: Termahal dulu (1500000 → 200000)

---

-- ============================================
-- SOAL 2: LIMIT - Top 3 Produk
-- ============================================
-- ✅ JAWABAN:
SELECT nama_produk, harga FROM produk ORDER BY harga DESC LIMIT 3;

-- Expected Output:
-- nama_produk         | harga
-- Smartphone          | 3000000
-- Laptop Dell         | 1500000
-- Monitor LG          | 1200000

-- Penjelasan: Top 3 termahal

---

-- ============================================
-- SOAL 3: LIKE - Search Produk
-- ============================================
-- ✅ JAWABAN:
SELECT nama_produk, kategori, harga FROM produk WHERE nama_produk LIKE '%phone%';

-- Expected Output:
-- nama_produk         | kategori   | harga
-- Headphone           | Audio      | 500000
-- Smartphone          | Elektronik | 3000000

-- Penjelasan: Nama mengandung "phone" (case-insensitive)

---

-- ============================================
-- SOAL 4: WHERE + LIKE + ORDER BY
-- ============================================
-- ✅ JAWABAN:
SELECT nama_pelanggan, email, kota FROM pelanggan WHERE nama_pelanggan LIKE '%a%' ORDER BY nama_pelanggan ASC;

-- Expected Output:
-- nama_pelanggan      | email                  | kota
-- Ahmad Hidayat       | ahmad@mail.com         | Jakarta
-- Budi Santoso        | budi@mail.com          | Surabaya
-- Rahma Wijaya        | rahma@mail.com         | Bandung
-- Sari Maulida        | sari@mail.com          | Jakarta
-- Sita Nurhaliza      | sita@mail.com          | Medan

-- Penjelasan: 
-- - Filter: nama mengandung 'a' atau 'A'
-- - Urut: A-Z (ascending)
-- - 5 pelanggan match

---

-- ============================================
-- SOAL 5: LIMIT + OFFSET - Pagination
-- ============================================
-- ✅ JAWABAN:
SELECT nama_pelanggan, email FROM pelanggan ORDER BY nama_pelanggan ASC LIMIT 2 OFFSET 2;

-- Expected Output:
-- nama_pelanggan      | email
-- Budi Santoso        | budi@mail.com
-- Rahma Wijaya        | rahma@mail.com

-- Penjelasan:
-- - Semua pelanggan urut A-Z:
--   1. Ahmad Hidayat
--   2. Hendra Kusuma
--   3. Budi Santoso         ← MULAI DARI SINI (OFFSET 2)
--   4. Rahma Wijaya         ← AMBIL 2 (LIMIT 2)
--   5. Sari Maulida
--   6. Sita Nurhaliza
-- - OFFSET 2 = skip 2 baris pertama
-- - LIMIT 2 = ambil 2 baris berikutnya
-- - Ini adalah HALAMAN 2 (2 item per halaman)
