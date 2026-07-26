# TOPIK 7: CONTAINERIZE BACKEND APP

---

## 🎯 Tujuan
Di topik ini, Anda akan belajar skill utama seorang Backend Dev terkait Docker: **Membungkus aplikasi backend ke dalam Docker image** dan **menghubungkannya dengan container database**.

---

## 1️⃣ MENGAPA APLIKASI BACKEND PERLU DI-CONTAINERIZE?

```
Skenario: Anda selesai menulis kode Java Spring Boot / Node.js.
Laptop Anda sudah terinstall Java 17 atau Node.js 18.
Bagaimana cara Anda men-deploy (merilis) aplikasi ini ke server?
```

**Cara Lama (Tanpa Docker):**
1. Server harus di-install Java / Node.js versi yang sama persis.
2. Server harus diatur environment variables-nya.
3. Kalau di server jalan versi Java yang berbeda (misal Java 11), aplikasi Anda bisa error!

**Cara Modern (Dengan Docker):**
1. Anda bungkus aplikasi (source code) + Runtime (Java/Node) ke dalam Docker Image menggunakan `Dockerfile`.
2. Di server, tidak perlu install Java/Node sama sekali! Cukup install Docker.
3. Server tinggal menjalankan image tersebut menjadi container. Dijamin 100% jalan karena runtime-nya dibawa di dalam image.

---

## 2️⃣ STRUKTUR PROJECT BACKEND BERSAMA DOCKER

Umumnya, di dalam repository Git sebuah project backend, terdapat struktur seperti ini:

```
project-backend/
├── src/                  ← Source code aplikasi Anda
├── package.json          ← Dependency list (atau pom.xml jika Java)
├── Dockerfile            ← Resep membuat image aplikasi INI
└── docker-compose.yml    ← Playlist untuk jalankan App + Database sekaligus
```

---

## 3️⃣ MEMBUAT DOCKERFILE UNTUK BACKEND APP

Mari kita ingat kembali anatomi Dockerfile (Topik 3). Kali ini kita aplikasikan untuk Backend API.

*(Catatan: Untuk latihan ini, kita gunakan Node.js Express karena jauh lebih ringan dan cepat dibuild dibanding Java Spring Boot, cocok untuk fokus belajar konsep Docker-nya).*

Contoh Dockerfile untuk Backend Node.js:
```dockerfile
# 1. Base image: Kita butuh komputer yang punya Node.js versi 18
FROM node:18-alpine

# 2. Set folder kerja di dalam container
WORKDIR /app

# 3. Copy file dependency DULU (Best practice caching!)
COPY package.json ./

# 4. Install dependency
RUN npm install

# 5. Baru copy sisa source code aplikasi
COPY . .

# 6. Expose port yang dipakai oleh aplikasi kita
EXPOSE 3000

# 7. Command untuk menjalankan app
CMD ["node", "app.js"]
```

---

## 4️⃣ MENGHUBUNGKAN APP KE DATABASE (ENVIRONMENT VARIABLES)

Di kode backend, Anda butuh konfigurasi koneksi database (URL, Username, Password).
**JANGAN PERNAH** me-hardcode konfigurasi ini di dalam kode, karena:
1. Di komputer Anda databasenya `localhost`, di server production beda lagi.
2. Hardcode password = Security flaw!

Gunakan **Environment Variables** (seperti yang Anda pelajari di Topik 2).

Contoh pemanggilan di kode backend (Node.js):
```javascript
const connection = mysql.createConnection({
  host: process.env.DB_HOST,           // akan diisi nama container DB
  user: process.env.DB_USER,           // akan diisi 'root'
  password: process.env.DB_PASSWORD,   // akan diisi 'password123'
  database: process.env.DB_NAME        // akan diisi 'toko_online'
});
```

---

## 5️⃣ MENJALANKAN APP + DB DENGAN DOCKER COMPOSE

Kita buat `docker-compose.yml` untuk menjalankan **MySQL** DAN **Backend App** buatan kita sekaligus!

```yaml
version: '3.8'

services:
  db:                   # Service Database
    image: mysql:8.0
    container_name: mysql_toko
    environment:
      MYSQL_ROOT_PASSWORD: password123
      MYSQL_DATABASE: toko_online
    volumes:
      - ./setup.sql:/docker-entrypoint-initdb.d/init.sql

  api:                  # Service Backend API (Buatan Kita)
    build: .            # "Tolong build image dari Dockerfile di folder ini (.)"
    container_name: backend_api_toko
    ports:
      - "3000:3000"
    environment:
      # Inject variabel ke dalam container backend
      DB_HOST: db       # NAMA SERVICE DATABASE (Keajaiban Docker Network!)
      DB_USER: root
      DB_PASSWORD: password123
      DB_NAME: toko_online
    depends_on:
      - db              # Tunggu database jalan dulu baru jalankan API
```

### Penjelasan Magic Docker Compose:

1. **`build: .`** 
   Tadi di Topik 5 kita pakai `image: mysql`. Kalau kita pakai `build: .`, Docker Compose akan **otomatis melakukan `docker build`** (membuat image dari Dockerfile) sebelum me-run container-nya! Anda tidak perlu `docker build` manual.

2. **`DB_HOST: db`**
   Di sini, API app Anda akan mencoba konek ke URL `db` (bukan `localhost`). Karena Docker Compose membuat custom network, container API bisa mengenali IP container MySQL cukup dari nama service-nya (`db`).

---

> ✅ Konsep sudah paham? Lanjut ke **latihan.md** untuk langsung men-deploy Full-Stack (Backend API + MySQL) di laptop Anda!
