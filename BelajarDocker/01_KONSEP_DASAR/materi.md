# TOPIK 1: KONSEP DASAR DOCKER

---

## 🎯 Tujuan
Setelah topik ini, Anda **paham KENAPA Docker ada**, **apa masalah yang diselesaikan**, dan **istilah-istilah kunci** yang akan dipakai di semua topik selanjutnya.

> ⚠️ Topik ini **100% teori**. Belum ada command yang diketik (selain yang sudah dilakukan di Topik 0). Tapi JANGAN skip — pemahaman konsep ini kritis untuk semua topik berikutnya.

---

## 1️⃣ MASALAH YANG DOCKER SELESAIKAN

### Skenario: "Works on My Machine" Problem

Bayangkan Anda bekerja sebagai backend developer:

```
Anda  : "App saya jalan di laptop saya!"
Teman : "Di laptop saya kok error ya?"
Server: "Di server production juga error."
```

**Kenapa ini terjadi?**
- Versi Java di laptop Anda: 17, di server: 11
- Versi MySQL di laptop Anda: 8.0, di teman: 5.7
- OS Anda: Windows 11, server: Ubuntu 22.04
- Library yang terinstall berbeda-beda

**Intinya**: Lingkungan (environment) di setiap komputer **berbeda-beda**, jadi app yang jalan di satu tempat belum tentu jalan di tempat lain.

### Solusi Docker:

Docker membungkus aplikasi Anda **beserta seluruh environment-nya** (OS, library, konfigurasi, versi) ke dalam satu **container** yang bisa dijalankan di **mana saja** dengan hasil yang **identik**.

```
Tanpa Docker:
  App → tergantung OS, library, versi masing-masing komputer → BEDA-BEDA

Dengan Docker:
  App + Semua dependency → dibungkus dalam Container → SAMA DI MANA SAJA
```

---

## 2️⃣ APA ITU DOCKER?

**Docker** adalah platform yang memungkinkan Anda **membungkus, mendistribusikan, dan menjalankan** aplikasi di dalam **container**.

### Analogi: Container Pengiriman Barang (Shipping Container) 🚢

Sebelum container pengiriman ditemukan:
- Barang dikirim dengan cara berbeda-beda: karung, kotak kayu, drum
- Setiap pelabuhan punya cara bongkar muat yang berbeda
- Sering rusak, hilang, dan tidak efisien

Setelah container pengiriman ditemukan:
- **Semua barang** dibungkus dalam container **ukuran standar**
- **Semua kapal, truk, kereta** bisa mengangkut container yang sama
- Tidak peduli isinya apa — dari luar bentuknya sama

**Docker = container pengiriman untuk software.**
- Tidak peduli app-nya pakai bahasa apa (Java, Python, Node.js)
- Tidak peduli dijalankan di mana (laptop Anda, laptop teman, server AWS)
- Dari luar, container-nya **standar dan identik**

---

## 3️⃣ DOCKER vs VIRTUAL MACHINE (VM)

Anda mungkin pernah dengar Virtual Machine (VM). Docker sering dibandingkan dengan VM. Bedanya:

### Analogi: Apartemen vs Rumah 🏠

| | **Virtual Machine (VM)** | **Docker Container** |
|:---|:---|:---|
| **Analogi** | Membangun **rumah** di atas tanah (termasuk fondasi, atap, listrik, air sendiri) | Menyewa **unit apartemen** (sharing fondasi, listrik, air dari gedung) |
| **Apa yang dibawa** | Seluruh OS lengkap + App | Hanya App + library yang dibutuhkan |
| **Ukuran** | Besar (GB) | Kecil (MB) |
| **Startup** | Lambat (menit) | Cepat (detik) |
| **Resource** | Boros (RAM, CPU) | Hemat |
| **Isolasi** | Sangat terisolasi | Cukup terisolasi |

### Visualisasi:

```
Virtual Machine:                    Docker Container:
┌─────────────┐                     ┌──────┐ ┌──────┐ ┌──────┐
│   App A     │                     │App A │ │App B │ │App C │
├─────────────┤                     ├──────┤ ├──────┤ ├──────┤
│  Guest OS   │  ← OS lengkap!     │ Libs │ │ Libs │ │ Libs │
├─────────────┤                     └──┬───┘ └──┬───┘ └──┬───┘
│ Hypervisor  │                        │        │        │
├─────────────┤                     ┌──┴────────┴────────┴──┐
│   Host OS   │                     │    Docker Engine       │
├─────────────┤                     ├────────────────────────┤
│  Hardware   │                     │      Host OS           │
└─────────────┘                     ├────────────────────────┤
                                    │     Hardware           │
                                    └────────────────────────┘
```

**Kesimpulan**: Docker lebih **ringan, cepat, dan efisien** dibanding VM. Untuk kebutuhan backend development, Docker sudah **lebih dari cukup**.

---

## 4️⃣ ISTILAH KUNCI DOCKER (Wajib Hafal!)

Ada 5 istilah yang akan Anda temui di **semua topik** selanjutnya:

### 1. Image (Cetakan/Blueprint)
**Analogi**: Cetakan kue 🧁

- Image adalah **template read-only** yang berisi instruksi untuk membuat container
- Seperti cetakan kue — dari 1 cetakan, bisa buat banyak kue
- Contoh: Image `mysql:8.0` berisi MySQL versi 8.0 yang siap dijalankan
- Image **tidak bisa diubah** setelah dibuat (immutable)

### 2. Container (Instance yang Berjalan)
**Analogi**: Kue yang sudah jadi dari cetakan 🎂

- Container adalah **instance dari image** yang sedang berjalan
- Seperti kue — dibuat dari cetakan, bisa dibuat banyak, masing-masing independen
- Dari 1 image `mysql:8.0`, Anda bisa buat 5 container MySQL yang berbeda
- Container bisa di-start, stop, delete — tapi image-nya tetap ada

```
Image (cetakan)     →  Container 1 (kue #1, sedang berjalan)
  mysql:8.0         →  Container 2 (kue #2, sedang berjalan)
                    →  Container 3 (kue #3, sedang stopped)
```

### 3. Dockerfile (Resep Membuat Image)
**Analogi**: Resep masakan 📝

- Dockerfile adalah **file teks** yang berisi instruksi step-by-step untuk membuat image
- Seperti resep masakan: "Ambil tepung, tambah telur, aduk, panggang"
- Docker membaca Dockerfile lalu menghasilkan image
- Contoh isi Dockerfile:
  ```
  FROM node:18          ← "Mulai dari dapur yang sudah ada Node.js"
  COPY . /app           ← "Taruh semua bahan ke folder /app"
  RUN npm install       ← "Install semua dependency"
  CMD ["node", "app.js"] ← "Jalankan app-nya"
  ```

### 4. Registry (Toko Image)
**Analogi**: App Store / Play Store, tapi untuk Docker images 🏪

- Registry adalah tempat menyimpan dan membagikan image
- **Docker Hub** = registry publik paling populer (seperti GitHub untuk code)
- Anda bisa `pull` (download) image dari registry, atau `push` (upload) image Anda
- Contoh image populer di Docker Hub: `mysql`, `nginx`, `node`, `python`, `postgres`

### 5. Volume (Penyimpanan Permanen)
**Analogi**: Hard disk eksternal 💾

- Data di dalam container **hilang** saat container dihapus
- Volume = penyimpanan yang **tetap ada** walaupun container dihapus
- Dipakai untuk data yang harus persistent: database, file upload, log
- Bayangkan: Container = laptop pinjaman (dikembalikan = data hilang), Volume = hard disk eksternal Anda (data tetap aman)

---

## 5️⃣ BAGAIMANA DOCKER BEKERJA? (Arsitektur Sederhana)

```
┌────────────────────────────────────────────────┐
│                   ANDA (User)                  │
│         ketik command di Terminal              │
└──────────────────┬─────────────────────────────┘
                   │
                   ▼
┌──────────────────────────────────┐
│        Docker Client (CLI)       │  ← Menerima command Anda
│  docker run, docker build, dll   │
└──────────────────┬───────────────┘
                   │
                   ▼
┌──────────────────────────────────┐
│       Docker Engine (Daemon)     │  ← Otak Docker, mengerjakan tugas
│  Mengelola image, container,     │
│  volume, network                 │
└──────────────────┬───────────────┘
                   │
          ┌────────┴────────┐
          ▼                 ▼
┌──────────────┐   ┌──────────────┐
│  Container 1 │   │  Container 2 │  ← App Anda berjalan di sini
│  (MySQL)     │   │  (Node.js)   │
└──────────────┘   └──────────────┘
```

**Alur kerja sederhana:**
1. Anda ketik `docker run mysql` di terminal
2. **Docker Client** mengirim perintah ke **Docker Engine**
3. Docker Engine cek apakah image `mysql` sudah ada di lokal
4. Jika belum → Docker Engine **pull** (download) dari **Docker Hub**
5. Docker Engine membuat **container** dari image tersebut
6. Container MySQL **berjalan** dan siap digunakan!

---

## 6️⃣ KENAPA BACKEND DEVELOPER PERLU DOCKER?

Sebagai backend developer, Anda akan menggunakan Docker untuk:

### 1. Development Environment yang Konsisten
```
Tanpa Docker:
  - Install MySQL 8.0 di laptop → belum tentu versinya sama dengan production
  - Install Redis, RabbitMQ, Elasticsearch → ribet, conflict version

Dengan Docker:
  - docker compose up → MySQL, Redis, semua jalan dalam hitungan detik
  - Versi PASTI sama karena semua pakai image yang sama
```

### 2. Onboarding Tim Baru Jadi Cepat
```
Tanpa Docker:
  - Developer baru masuk → setup environment 1-2 hari
  - "Install Java 17, MySQL 8.0, Redis 7.0, set environment variable..."

Dengan Docker:
  - Developer baru masuk → git clone → docker compose up → SELESAI!
  - Waktu setup: 5 menit (download image) → langsung coding
```

### 3. Testing dengan Database Bersih
```
Tanpa Docker:
  - Test butuh database bersih → truncate manual, ribet
  
Dengan Docker:
  - docker compose down → docker compose up → database bersih!
  - Setiap test run = fresh environment
```

---

## 📝 Checklist Selesai Topik 1

Anda harus bisa menjawab pertanyaan-pertanyaan ini (jawab di `latihan.md`):

- [ ] Apa masalah utama yang Docker selesaikan?
- [ ] Apa perbedaan utama Docker vs Virtual Machine?
- [ ] Apa bedanya Image vs Container?
- [ ] Apa fungsi Dockerfile?
- [ ] Apa itu Docker Hub?
- [ ] Kenapa backend developer perlu Docker?

**Jika semua ✅ → Lanjut ke Topik 2: Image & Container!**

<!-- rev-1717 -->
