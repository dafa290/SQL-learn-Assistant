# TOPIK 7: LATIHAN — Containerize Backend App

> ⚠️ **PENTING**: Kita akan membuat **full-stack app sederhana** (Backend Node.js + MySQL). Ikuti langkah ini pelan-pelan. Anda akan mengetik kode nyata!

---

## LATIHAN 1: Menyiapkan Folder & Source Code Backend

### Langkah 1: Buat Folder Latihan
1. Buat folder `latihan` di dalam `07_DOCKER_BACKEND_APP`
2. Masuk ke folder tersebut.

### Langkah 2: Copy setup.sql
Ambil file `setup.sql` dari project SQL Anda (atau dari folder latihan Topik 6), lalu paste ke dalam folder `latihan` ini.

### Langkah 3: Buat Source Code Backend
Di dalam folder `latihan`, buat file baru bernama `package.json` dan isi dengan kode ini:

```json
{
  "name": "backend-toko",
  "version": "1.0.0",
  "main": "app.js",
  "dependencies": {
    "express": "^4.18.2",
    "mysql2": "^3.6.0"
  }
}
```

Lalu, buat file bernama `app.js` dan isi kode Node.js berikut:

```javascript
const express = require('express');
const mysql = require('mysql2');

const app = express();
const port = 3000;

// Konfigurasi koneksi dari Environment Variables (di-set oleh Docker Compose)
const db = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

// Route Utama
app.get('/', (req, res) => {
  res.send('🐳 Backend API Toko Online Running in Docker!');
});

// Route GET Produk (Ambil data dari MySQL)
app.get('/api/produk', (req, res) => {
  db.query('SELECT * FROM produk', (err, results) => {
    if (err) {
      console.error(err);
      res.status(500).send('Database error');
    } else {
      res.json(results);
    }
  });
});

app.listen(port, () => {
  console.log(`🚀 API berjalan di port ${port}`);
});
```
*(Jangan hiraukan detail JS-nya. Fokus bahwa app ini akan konek ke DB dan nge-query tabel `produk` yang sudah Anda buat di SQL dulu).*

---

## LATIHAN 2: Menulis Dockerfile untuk Backend

Di folder `latihan` yang sama, buat file bernama `Dockerfile` (tanpa ekstensi). Ketik resep berikut:

```dockerfile
FROM node:18-alpine

WORKDIR /app

# Copy daftar dependensi lalu install
COPY package.json ./
RUN npm install

# Copy sisa kode (app.js)
COPY . .

EXPOSE 3000

# Jalankan app
CMD ["node", "app.js"]
```

---

## LATIHAN 3: Merakit Semuanya dengan Docker Compose

Buat file `docker-compose.yml` di folder `latihan`:

```yaml
version: '3.8'

services:
  database_toko:
    image: mysql:8.0
    container_name: db_toko_final
    ports:
      - "3306:3306"
    environment:
      MYSQL_ROOT_PASSWORD: belajar123
      MYSQL_DATABASE: toko_online
    volumes:
      - ./setup.sql:/docker-entrypoint-initdb.d/init.sql

  api_toko:
    build: .                 # Build image dari Dockerfile di folder ini
    container_name: api_toko_final
    ports:
      - "3000:3000"          # Akses API di port 3000
    environment:
      DB_HOST: database_toko # NAMA SERVICE MYSQL di atas!
      DB_USER: root
      DB_PASSWORD: belajar123
      DB_NAME: toko_online
    depends_on:
      - database_toko
```

---

## LATIHAN 4: RUN FULL STACK APP! 🚀

### Langkah 1: Jalankan Compose
Buka PowerShell di folder `latihan`, lalu ketik:
```powershell
docker compose up -d
```
*(Tunggu agak lama karena Docker Compose akan mem-build image Node.js Anda dulu sebelum menjalankan).*

### Langkah 2: Pantau Log
```powershell
docker compose logs -f
```
Tunggu sampai MySQL selesai inisialisasi, dan pastikan Anda melihat log: `🚀 API berjalan di port 3000`. Tekan `Ctrl+C`.

### Langkah 3: Test API di Browser!
1. Buka browser: **http://localhost:3000** 
   *(Seharusnya muncul tulisan "Backend API Toko Online Running...")*
2. Buka rute API: **http://localhost:3000/api/produk**

**Tulis hasil Anda:**
- [ ] Apakah URL pertama berhasil terbuka?
- [ ] Apakah URL kedua (`/api/produk`) mengembalikan data produk dalam format JSON (bisa melihat ada Laptop, Mouse, dll yang diambil dari MySQL)?

> 🎉 **SELAMAT!** Anda baru saja men-deploy aplikasi backend yang terkoneksi dengan database menggunakan Docker! Ini persis apa yang dilakukan Backend/DevOps di industri nyata.

---

## LATIHAN 5: Bersih-bersih
```powershell
docker compose down
```

> ✅ Silakan lanjut ke **Project Final** untuk ujian akhir Anda!
