-- ============================================
-- PROJECT 1 TASKS: CRUD USER MANAGEMENT
-- ============================================
-- INSTRUKSI:
-- 1. Jalankan schema.sql dulu untuk create table + sample data
-- 2. Baca scenario.md untuk understand konteks
-- 3. Kerjakan 8 task di bawah
-- 4. Setiap task adalah simulated backend endpoint
-- 5. Test query di MySQL, pastikan output sesuai expected
-- 6. Self-check dengan jawaban.sql
-- ============================================

USE toko_online;

-- ============================================
-- TASK 1: LIST USERS (Endpoint: GET /users)
-- ============================================
-- Backend API endpoint yang menampilkan semua user AKTIF
-- Requirement: Tampilkan username, email, nama_lengkap, created_at
-- Urut berdasarkan created_at (paling baru dulu)
-- Expected output: 4 users, 4 kolom
--
-- Tulis query Anda di sini:

SELECT username,email, nama_lengkap,created_at FROM users 
WHERE status='aktif'
ORDER BY created_at DESC LIMIT 4;




-- ============================================
-- TASK 2: GET USER BY ID (Endpoint: GET /users/{id})
-- ============================================
-- Backend API untuk mendapatkan detail user spesifik (misal user ID=2)
-- Requirement: Tampilkan SEMUA data user dengan ID 2
-- Kasus bisnis: Frontend butuh tampil profil user saat di-klik
-- Expected output: 1 user, semua kolom
--
-- Tulis query Anda di sini:
SELECT * FROM users WHERE id=2;



-- ============================================
-- TASK 3: SEARCH USERS BY NAME (Endpoint: GET /users?search=ahmad)
-- ============================================
-- Backend filter untuk search user by name
-- Requirement: Cari user dengan nama mengandung 'ahmad' (case-insensitive bisa LIKE atau LOWER)
-- Tampilkan: username, nama_lengkap, email, status
-- Expected output: 1 user (Ahmad Hidayat)
-- TIP: Gunakan WHERE + LIKE atau WHERE + nama_lengkap
--
-- Tulis query Anda di sini:
SELECT username,nama_lengkap,email,status FROM users
WHERE nama_lengkap LIKE '%ahmad%';



-- ============================================
-- TASK 4: INSERT NEW USER (Endpoint: POST /users)
-- ============================================
-- Backend register endpoint: menambah user baru
-- Data baru: username='lisa_m', email='lisa@email.com', password='hashed_pwd_5', nama_lengkap='Lisa Manobal'
-- Expected: Insert berhasil, user otomatis status='aktif', created_at=sekarang
-- VERIFY: Jalankan SELECT * FROM users; untuk lihat user baru
--
-- Tulis query Anda di sini:
INSERT INTO users (username, email, password, nama_lengkap)
VALUES ('lisa_m', 'lisa@email.com', 'hashed_pwd_5', 'Lisa Manobal');


-- ============================================
-- TASK 5: SOFT DELETE USER (Endpoint: DELETE /users/{id})
-- ============================================
-- Backend soft delete: user tidak benar-benar dihapus, hanya di-deactivate
-- Kasus: User ID=3 (Ahmad) mau delete account
-- Requirement: Update status user ID 3 menjadi 'inactive'
-- Expected: User masih ada di database, tapi status='inactive'
-- VERIFY: SELECT * FROM users WHERE id=3;
--
-- Tulis query Anda di sini:
UPDATE users SET status='inactive' WHERE id=3;



-- ============================================
-- TASK 6: LIST ACTIVE USERS ONLY (Endpoint: GET /users?status=aktif)
-- ============================================
-- Backend filter: tampilkan HANYA user yang masih aktif
-- Requirement: Tampilkan username, nama_lengkap, status
-- Filter: status = 'aktif' saja
-- Order: berdasarkan created_at (paling lama dulu)
-- Limit: tampilkan max 3 user
-- Expected output: 3 users (Budi, Siti, Lisa - Ahmad sudah inactive)
-- TIP: Gunakan WHERE + ORDER BY + LIMIT
--
-- Tulis query Anda di sini:
SELECT username,nama_lengkap,status FROM users 
WHERE status='aktif' ORDER BY created_at ASC LIMIT 3;



-- ============================================
-- TASK 7: UPDATE USER PROFILE (Endpoint: PUT /users/{id})
-- ============================================
-- Backend update endpoint: user mau update email
-- Kasus: User ID=1 (Budi) mau ubah email dari 'budi@email.com' menjadi 'budi.santoso@email.com'
-- Requirement: Update email user ID 1
-- Expected: Email berubah, updated_at otomatis update ke waktu sekarang
-- VERIFY: SELECT * FROM users WHERE id=1;
--
-- Tulis query Anda di sini:
UPDATE users
 SET email='budi.santoso@email.com' 
WHERE id=1;




-- ============================================
-- TASK 8: HARD DELETE USER (Endpoint: DELETE /users/{id} - permanent)
-- ============================================
-- Backend permanent delete: benar-benar hapus record dari database
-- Kasus: Admin mau hapus semua user dengan status 'inactive' (permanent)
-- Requirement: DELETE user yang sudah inactive
-- Expected: User inactive hilang dari database
-- VERIFY: SELECT * FROM users; (seharusnya tinggal 3-4 user aktif)
-- WARNING: Hard delete berbahaya! Di real production jarang dilakukan
--
-- Tulis query Anda di sini:
DELETE FROM users WHERE status='inactive';



-- ============================================
-- FINAL VERIFICATION
-- ============================================
-- Jalankan untuk lihat final state data
-- Expected: mix dari user aktif (Budi-updated, Siti, Lisa), Ahmad sudah inactive
--
SELECT * FROM users;
