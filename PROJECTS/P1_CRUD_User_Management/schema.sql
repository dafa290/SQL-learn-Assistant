-- ============================================
-- PROJECT 1: CRUD USER MANAGEMENT
-- ============================================
-- Schema setup untuk user management system
-- Jalankan query ini terlebih dahulu!
-- ============================================

USE toko_online;

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    nama_lengkap VARCHAR(100),
    status ENUM('aktif', 'inactive') DEFAULT 'aktif',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert sample data (untuk simulate existing users)
INSERT INTO users (username, email, password, nama_lengkap) VALUES
('budi123', 'budi@email.com', 'hashed_password_1', 'Budi Santoso'),
('siti456', 'siti@email.com', 'hashed_password_2', 'Siti Nurhaliza'),
('ahmad789', 'ahmad@email.com', 'hashed_password_3', 'Ahmad Hidayat'),
('dewi_001', 'dewi@email.com', 'hashed_password_4', 'Dewi Lestari');

-- Verify data
SELECT * FROM users;
