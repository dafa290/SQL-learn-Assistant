# 🏆 PROJECT FINAL: Full-Stack Deployment 

---

## 🎯 Objektif Ujian
Skenario ini adalah ujian akhir untuk mengukur pemahaman Anda mengenai semua materi Docker (Topik 0 - 7). Anda akan diminta untuk mendeploy sebuah aplikasi lengkap hanya bermodalkan file-file source code.

---

## 🏢 Skenario: Hari Pertama Magang

Selamat! Anda baru saja diterima magang sebagai Junior Backend Developer. Di hari pertama kerja, Senior Developer Anda memberi tugas:

> *"Hi! Selamat datang. Tolong bantu saya set up environment development untuk aplikasi internal baru kita, **Inventory System**. Saya sudah buat source code backend-nya dan file SQL untuk database-nya."*
> 
> *"Tugas kamu adalah **membuat file Dockerfile dan docker-compose.yml** agar aplikasi ini bisa dijalankan dalam 1 kali klik (`docker compose up -d`). Database-nya pakai MySQL ya. Kalau sudah jalan, kabari saya."*

---

## 📦 File Source Code (Bahan Baku)

### Langkah 1: Persiapan Folder
Buat folder `PROJECT_FINAL` di dalam folder `BelajarDocker`. Masuk ke folder tersebut.
Buat folder `src` di dalamnya.

### Langkah 2: Buat File Backend (Node.js)
Di dalam folder `src`, buat file `package.json`:
```json
{
  "name": "inventory-api",
  "version": "1.0.0",
  "main": "server.js",
  "dependencies": {
    "express": "^4.18.2",
    "mysql2": "^3.6.0"
  }
}
```

Lalu, di dalam folder `src` juga, buat `server.js`:
```javascript
const express = require('express');
const mysql = require('mysql2');

const app = express();
const port = 8080; // PERHATIKAN: port ini berbeda dengan latihan sebelumnya!

const pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

app.get('/', (req, res) => {
  res.send('API Inventory System - Status: ONLINE');
});

app.get('/stock', (req, res) => {
  pool.query('SELECT * FROM stock_items', (err, results) => {
    if (err) res.status(500).send('DB Error');
    else res.json(results);
  });
});

app.listen(port, () => console.log(`API jalan di port ${port}`));
```

### Langkah 3: Buat File Database
Kembali ke folder utama `PROJECT_FINAL` (di luar folder `src`).
Buat file `inventory.sql`:
```sql
CREATE DATABASE inventory_db;
USE inventory_db;

CREATE TABLE stock_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama_barang VARCHAR(100),
    jumlah INT
);

INSERT INTO stock_items (nama_barang, jumlah) VALUES 
('Keyboard Mechanical', 15),
('Mouse Wireless', 30),
('Monitor 24 inch', 5);
```

---

## 📝 TUGAS ANDA

Berdasarkan file-file di atas, Anda harus membuat **DUA FILE** di folder `PROJECT_FINAL` (bukan di dalam `src`):

1. **`Dockerfile`**
   - Buat instruksi untuk membungkus kode backend yang ada di folder `src`.
   - Perhatikan port berapa yang di-expose oleh aplikasi `server.js`!

2. **`docker-compose.yml`**
   - Buat service `mysql_db` (pakai image `mysql:8.0`).
   - Buat service `backend_api` (di-build dari `Dockerfile`).
   - Gunakan environment variables agar backend bisa connect ke MySQL.
   - Atur agar password MySQL adalah `magang123`.
   - Atur agar file `inventory.sql` otomatis dieksekusi oleh MySQL.
   - Map port backend agar bisa diakses dari browser laptop Anda di **http://localhost:5000**.

> 💡 **Kunci Keberhasilan**: Buka materi Topik 7 jika Anda lupa syntax-nya. Bedakan nama file dan port dengan teliti!

---

## ✅ CARA VERIFIKASI

Jika Anda yakin file `Dockerfile` dan `docker-compose.yml` sudah benar, buktikan dengan:

1. Jalankan `docker compose up -d` di PowerShell.
2. Buka browser: **http://localhost:5000/stock**
3. Apakah Anda melihat data Keyboard, Mouse, dan Monitor dalam format JSON?

Jika **YA**, Anda telah BERHASIL menyelesaikan project final ini! 
Selamat, Anda sudah memiliki skill Docker dasar yang solid dan siap magang! 👏

*(Silakan kerjakan sendiri. Kunci jawaban ada di materi selanjutnya, tapi berusahalah mandiri dulu!)*
