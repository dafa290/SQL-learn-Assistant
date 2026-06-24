-- ============================================
-- TOPIK 6: UJIAN - JOIN (LEVEL 2 - TESTING REAL-WORLD SCENARIOS)
-- ============================================
-- Database: toko_online
-- Tables: pelanggan, pembelian, produk
-- 
-- Tujuan: Validasi pemahaman JOIN dalam skenario kerja nyata (business-driven requirements)
-- 
-- Alur Testing:
-- 1. Pastikan sudah 80% benar di latihan.sql sebelum mulai
-- 2. Kerjakan 5 soal di bawah TANPA referensi ke latihan.sql
-- 3. Gunakan HANYA requirement bisnis yang ada - tanpa petunjuk teknis SQL!
-- 4. Cek jawaban di jawaban.sql bagian UJIAN
-- 5. Jika >80% benar → Topik 6 SELESAI ✅
-- 
-- Catatan: Soal-soal di bawah merefleksikan kondisi nyata di dunia kerja.
-- Atasan atau client tidak akan memberi tahu Anda jenis JOIN atau syntax mana yang harus dipakai.
-- Anda sendiri yang harus menganalisis relasi data dan menerjemahkan kebutuhan bisnis ke query SQL yang tepat.

USE toko_online;

-- ============================================
-- SOAL 1 – Daily Sales Report
-- ============================================
-- Manager ingin melihat daftar pelanggan yang melakukan transaksi untuk kebutuhan monitoring penjualan harian.
--
-- Buat laporan yang menampilkan:
-- - Nama pelanggan
-- - Email pelanggan
-- - ID transaksi
-- - Total transaksi
--
-- Laporan hanya perlu menampilkan pelanggan yang benar-benar melakukan transaksi dan diurutkan dari transaksi terbaru.

-- Tulis query Anda di sini:
select 
pelanggan.nama_pelanggan,
pelanggan.email,
pembelian.id_pembelian,
pembelian.total_harga
from pelanggan
inner join pembelian on pembelian.id_pelanggan = pelanggan.id_pelanggan;




-- ============================================
-- SOAL 2 – Transaction Detail Report
-- ============================================
-- Tim Finance membutuhkan laporan detail seluruh transaksi yang terjadi di sistem.
--
-- Setiap baris laporan harus menunjukkan:
-- - Nama pelanggan
-- - Nama produk
-- - Jumlah unit yang dibeli
-- - Total nilai transaksi
-- - Tanggal transaksi
--
-- Urutkan laporan dari transaksi terbaru ke terlama.
-- Jika terdapat beberapa transaksi pada tanggal yang sama, urutkan berdasarkan nama produk secara alfabetis.

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
ORDER BY pembelian.tanggal_beli DESC, produk.nama_produk ASC ;



-- ============================================
-- SOAL 3 – Customer Activity Audit
-- ============================================
-- Tim Administrasi ingin mengevaluasi tingkat aktivitas pelanggan.
--
-- Buat laporan yang menampilkan seluruh pelanggan yang terdaftar di sistem,
-- baik yang sudah pernah bertransaksi maupun yang belum.
--
-- Informasi yang dibutuhkan:
-- - Nama pelanggan
-- - Email
-- - ID transaksi
-- - Total transaksi
--
-- Laporan ini akan digunakan untuk mengidentifikasi pelanggan yang belum pernah melakukan pembelian.

-- Tulis query Anda di sini:
SELECT
pelanggan.nama_pelanggan,
pelanggan.email,
pembelian.id_pembelian,
pembelian.total_harga
FROM pelanggan
LEFT JOIN pembelian  ON pelanggan.id_pelanggan = pembelian.id_pelanggan;




-- ============================================
-- SOAL 4 – High Value Transaction Analysis
-- ============================================
-- Manajemen ingin memberikan apresiasi kepada pelanggan yang melakukan transaksi bernilai besar.
--
-- Buat laporan yang menampilkan:
-- - Nama pelanggan
-- - Nama produk
-- - Nilai transaksi
-- - Tanggal transaksi
--
-- Fokus hanya pada transaksi dengan nilai di atas Rp1.000.000 dan tampilkan dari nilai transaksi terbesar ke terkecil.

-- Tulis query Anda di sini:
SELECT
pelanggan.nama_pelanggan,
produk.nama_produk,
pembelian.total_harga AS Nilai_transaksi,
pembelian.tanggal_beli
FROM pembelian
INNER JOIN pelanggan ON pembelian.id_pelanggan = pelanggan.id_pelanggan
INNER JOIN produk ON pembelian.id_produk = produk.id_produk
WHERE pembelian.total_harga > 1000000
ORDER BY pembelian.total_harga DESC;



-- ============================================
-- SOAL 5 – Product Category Sales Report
-- ============================================
-- Tim Marketing sedang melakukan evaluasi penjualan untuk kategori produk tertentu.
--
-- Buat laporan yang menampilkan:
-- - Nama pelanggan
-- - Nama produk
-- - Kategori produk
-- - Total transaksi
-- - Tanggal transaksi
--
-- Laporan hanya perlu menampilkan transaksi yang melibatkan 
--produk dalam kategori **Pakaian** dan diurutkan berdasarkan transaksi terbaru.

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
WHERE produk.kategori='pakaian'
ORDER BY pembelian.tanggal_beli DESC;



-- ============================================
-- SOAL 6 – Target City Logistics Report
-- ============================================
-- Tim Logistik ingin merencanakan rute pengiriman barang untuk pelanggan di kota **Jakarta**.
-- Buat laporan yang menampilkan detail pengiriman bagi
-- pelanggan asal Jakarta yang melakukan transaksi pembelian.
-- 
-- Informasi yang dibutuhkan:
-- - Nama pelanggan
-- - Kota domisili pelanggan
-- - Nama produk
-- - Jumlah unit yang dibeli
-- 
-- Urutkan laporan berdasarkan nama produk secara alfabetis (A-Z).

-- Tulis query Anda di sini:
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



-- ============================================
-- SOAL 7 – Product Performance Audit
-- ============================================
-- Tim Marketing sedang mengidentifikasi produk "dead stock" (stok mati) yang tidak laku terjual.
-- Buat laporan yang menampilkan **seluruh produk** yang terdaftar 
--di sistem beserta detail transaksinya jika produk tersebut pernah dibeli.
-- Produk yang sama sekali belum pernah terjual harus tetap tampil di laporan.
-- 
-- Informasi yang dibutuhkan:
-- - ID produk
-- - Nama produk
-- - Kategori produk
-- - ID transaksi
-- - Jumlah unit yang terjual
-- 
-- Urutkan laporan berdasarkan kategori produk secara alfabetis (A-Z), 
--lalu berdasarkan nama produk secara alfabetis (A-Z).

-- Tulis query Anda di sini:
SELECT
produk.id_produk,
produk.nama_produk,
produk.kategori,
pembelian.id_pembelian,
pembelian.jumlah
FROM produk
LEFT JOIN pembelian ON produk.id_produk= pembelian.id_produk
ORDER BY produk.kategori ASC, produk.nama_produk ASC;



-- ============================================
-- SOAL 8 – Transaction Integrity Audit
-- ============================================
-- Tim Keuangan ingin mencocokkan transaksi dengan data pelanggan. Untuk melatih teknik kueri alternatif, 
-- buat laporan yang menampilkan **seluruh data transaksi (pembelian)**
-- di database dengan memosisikan tabel **`pelanggan` di sebelah kiri** (`FROM pelanggan`), 
-- namun pastikan seluruh transaksi tetap tampil lengkap.
-- 
-- Informasi yang dibutuhkan:
-- - ID transaksi
-- - Tanggal transaksi
-- - Total harga transaksi
-- - Nama pelanggan
-- - Email pelanggan
-- 
-- Urutkan laporan berdasarkan nilai total transaksi dari yang terbesar ke terkecil.

-- Tulis query Anda di sini:
SELECT 
    pembelian.id_pembelian,
    pembelian.tanggal_beli,
    pembelian.total_harga,
    pelanggan.nama_pelanggan,
    pelanggan.email
FROM pelanggan
RIGHT JOIN pembelian ON pelanggan.id_pelanggan = pembelian.id_pelanggan
ORDER BY pembelian.total_harga DESC;



-- ============================================
-- VERIFICATION & COMPLETION
-- ============================================
-- Setelah menyelesaikan 8 soal:
-- 1. Cek jawaban di jawaban.sql bagian UJIAN
-- 2. Bandingkan logic Anda dengan jawaban
-- 3. Jika >80% soal BENAR (logic + hasil sama) → Topik 6 SELESAI ✅
-- 4. Catat learning: konsep apa yang masih perlu diperkuat?
-- 5. Siap untuk Topik 7: GROUP BY + AGGREGATE Functions
