-- ============================================
-- PROJECT 1 JAWABAN: CRUD USER MANAGEMENT
-- ============================================
-- Jawaban resmi untuk 8 tasks
-- ============================================

USE toko_online;

-- ============================================
-- TASK 1 JAWABAN: LIST USERS
-- ============================================
SELECT username, email, nama_lengkap, created_at FROM users WHERE status = 'aktif' ORDER BY created_at DESC;


-- ============================================
-- TASK 2 JAWABAN: GET USER BY ID
-- ============================================
SELECT * FROM users WHERE id = 2;


-- ============================================
-- TASK 3 JAWABAN: SEARCH USERS BY NAME
-- ============================================
SELECT username, nama_lengkap, email, status FROM users WHERE nama_lengkap LIKE '%ahmad%' OR nama_lengkap LIKE '%Ahmad%';
-- ATAU (lebih clean):
-- SELECT username, nama_lengkap, email, status FROM users WHERE LOWER(nama_lengkap) LIKE '%ahmad%';


-- ============================================
-- TASK 4 JAWABAN: INSERT NEW USER
-- ============================================
INSERT INTO users (username, email, password, nama_lengkap) VALUES ('lisa_m', 'lisa@email.com', 'hashed_pwd_5', 'Lisa Manobal');


-- ============================================
-- TASK 5 JAWABAN: SOFT DELETE USER
-- ============================================
UPDATE users SET status = 'inactive' WHERE id = 3;


-- ============================================
-- TASK 6 JAWABAN: LIST ACTIVE USERS ONLY
-- ============================================
SELECT username, nama_lengkap, status FROM users WHERE status = 'aktif' ORDER BY created_at ASC LIMIT 3;


-- ============================================
-- TASK 7 JAWABAN: UPDATE USER PROFILE
-- ============================================
UPDATE users SET email = 'budi.santoso@email.com' WHERE id = 1;


-- ============================================
-- TASK 8 JAWABAN: HARD DELETE USER
-- ============================================
DELETE FROM users WHERE status = 'inactive';


-- ============================================
-- FINAL VERIFICATION
-- ============================================
SELECT * FROM users;
