# TOPIK 4: CREATE TABLE + INSERT

**Outcome**: Bisa bikin tabel dari nol dan insert data ke dalamnya.

---

## 1️⃣ CREATE TABLE SYNTAX

### Basic Syntax:
```sql
CREATE TABLE nama_tabel (
    kolom1 TIPE_DATA PRIMARY_KEY AUTO_INCREMENT,
    kolom2 TIPE_DATA,
    kolom3 TIPE_DATA NOT NULL,
    kolom4 TIPE_DATA DEFAULT 'nilai_default'
);
```

### Penjelasan:
- `CREATE TABLE` = bikin tabel baru
- `kolom1` = nama kolom
- `TIPE_DATA` = jenis data (INT, VARCHAR, DATETIME, etc)
- `PRIMARY KEY` = unique identifier, tidak boleh duplikat
- `AUTO_INCREMENT` = value auto +1 setiap insert baru
- `NOT NULL` = harus ada nilai (tidak boleh kosong)
- `DEFAULT` = nilai default jika tidak diberikan

---

## 2️⃣ TIPE DATA YANG SERING DIPAKAI

| Tipe Data | Contoh | Kegunaan |
|---|---|---|
| `INT` | `INT` | Angka bulat (id, jumlah) |
| `VARCHAR(n)` | `VARCHAR(50)` | Text maksimal 50 karakter |
| `TEXT` | `TEXT` | Text panjang (description) |
| `DATETIME` | `DATETIME` | Tanggal + jam (2026-06-12 14:30:00) |
| `ENUM` | `ENUM('aktif', 'inactive')` | Pilihan fixed (status) |
| `DECIMAL(10,2)` | `DECIMAL(10,2)` | Angka desimal (price: 99.99) |
| `BOOLEAN` | `BOOLEAN` | True/False (0/1) |

---

## 3️⃣ CONSTRAINT (ATURAN TABEL)

### CURRENT_TIMESTAMP (automatic timestamp)

```sql
-- Timestamp otomatis saat row dibuat
created_at DATETIME DEFAULT CURRENT_TIMESTAMP

-- Timestamp otomatis saat row dibuat, dan UPDATE otomatis saat data berubah
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
```

**Penjelasan**:
- `CURRENT_TIMESTAMP` = waktu sekarang (otomatis)
- `DEFAULT` = set otomatis saat INSERT
- `ON UPDATE CURRENT_TIMESTAMP` = ubah otomatis saat row di-UPDATE (audit trail)

**Contoh**:
```sql
-- Row dibuat jam 10:00
INSERT INTO inventori (id_produk, lokasi) VALUES (1, 'Gudang A')
-- created_at = 2026-06-12 10:00:00
-- updated_at = 2026-06-12 10:00:00

-- Row diupdate jam 15:00
UPDATE inventori SET jumlah_stok = 100 WHERE id = 1
-- created_at = masih 2026-06-12 10:00:00 (tidak berubah)
-- updated_at = 2026-06-12 15:00:00 (otomatis update!)
```

**Backend use case**: Track "kapan data terakhir dimodifikasi" tanpa manual update.

---

## 4️⃣ INSERT SYNTAX

### Basic INSERT:
```sql
INSERT INTO nama_tabel (kolom1, kolom2, kolom3) 
VALUES ('nilai1', 'nilai2', 'nilai3');
```

### Contoh:
```sql
INSERT INTO users (username, email, password, nama_lengkap) 
VALUES ('john_doe', 'john@email.com', 'hashed_pass123', 'John Doe');
```

### Insert Multiple Rows:
```sql
INSERT INTO users (username, email, password, nama_lengkap) 
VALUES 
('user1', 'user1@email.com', 'pass1', 'User 1'),
('user2', 'user2@email.com', 'pass2', 'User 2'),
('user3', 'user3@email.com', 'pass3', 'User 3');
```

---

## 5️⃣ CONTOH LENGKAP

### Topik 1-2 sudah pakai tabel `produk`, `pelanggan`, `pembelian` dari setup.sql

Sekarang kita bikin tabel sendiri:

```sql
-- Bikin tabel users
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    nama_lengkap VARCHAR(100),
    status ENUM('aktif', 'inactive') DEFAULT 'aktif',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert sample data
INSERT INTO users (username, email, password, nama_lengkap) 
VALUES 
('john_doe', 'john@email.com', 'hashed_pass123', 'John Doe'),
('jane_smith', 'jane@email.com', 'hashed_pass456', 'Jane Smith'),
('admin_user', 'admin@email.com', 'hashed_admin', 'Admin User');

-- Verify: lihat data yang baru diinsert
SELECT * FROM users;
```

Output:
```
id | username    | email           | password          | nama_lengkap | status | created_at          | updated_at
1  | john_doe    | john@email.com  | hashed_pass123    | John Doe     | aktif  | 2026-06-12 10:00:00 | 2026-06-12 10:00:00
2  | jane_smith  | jane@email.com  | hashed_pass456    | Jane Smith   | aktif  | 2026-06-12 10:00:00 | 2026-06-12 10:00:00
3  | admin_user  | admin@email.com | hashed_admin      | Admin User   | aktif  | 2026-06-12 10:00:00 | 2026-06-12 10:00:00
```

---

## ⚠️ COMMON MISTAKES

### ❌ Lupa comma antara kolom
```sql
CREATE TABLE users (
    id INT PRIMARY KEY  ← LUPA COMMA
    username VARCHAR(50)
);
```

### ❌ Jenis data tidak cocok dengan isi
```sql
-- Ini error - 'john' tipe VARCHAR tapi definisi INT
INSERT INTO users (id, username) VALUES ('john', 'smith');

-- Harus:
INSERT INTO users (id, username) VALUES (1, 'john');
```

### ❌ Insert ke kolom yang PRIMARY KEY + AUTO_INCREMENT
```sql
-- Ini tidak perlu, AUTO_INCREMENT handle sendiri
INSERT INTO users (id, username) VALUES (1, 'john');

-- Cukup:
INSERT INTO users (username) VALUES ('john');
```

---

## 🎯 TAKE-AWAYS

1. **CREATE TABLE** = define struktur tabel + constraints
2. **INSERT** = masukkan data ke tabel
3. **PRIMARY KEY** = unique identifier setiap row
4. **AUTO_INCREMENT** = ID otomatis naik
5. **UNIQUE** = tidak boleh duplikat
6. **DEFAULT** = nilai otomatis jika tidak diberikan
7. **FOREIGN KEY** = relasi ke tabel lain (akan pakai di Topik 6)

---

**Next**: Buka `latihan.sql` dan kerjakan 5 soal! 💪
