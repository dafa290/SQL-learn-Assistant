# TOPIK 5: LATIHAN — Docker Compose

> ⚠️ **PENTING**: Semua command dijalankan di PowerShell. Pastikan semua container MySQL dari latihan sebelumnya sudah di-stop dan di-remove agar port 3306 tidak bentrok.

---

## LATIHAN 1: Membuat "Playlist" (File Compose)

Kita akan membuat environment yang terdiri dari **MySQL Database** dan **phpMyAdmin** (aplikasi berbasis web untuk mengatur database MySQL, mirip DBeaver/HeidiSQL tapi via browser).

### Langkah 1: Buat Folder
1. Buka File Explorer
2. Buat folder `latihan` di dalam `05_DOCKER_COMPOSE`
3. Masuk ke folder tersebut.

### Langkah 2: Buat file `docker-compose.yml`
Buat file baru bernama `docker-compose.yml` (pastikan ekstensinya `.yml`, bukan `.txt`).
Copy-paste kode persis dari materi tadi:

```yaml
version: '3.8'

services:
  database:
    image: mysql:8.0
    container_name: db_toko
    ports:
      - "3306:3306"
    environment:
      MYSQL_ROOT_PASSWORD: password123
      MYSQL_DATABASE: toko_online
    volumes:
      - data-mysql:/var/lib/mysql

  admin_db:
    image: phpmyadmin:latest
    container_name: pma_toko
    ports:
      - "8080:80"
    environment:
      PMA_HOST: database
    depends_on:
      - database

volumes:
  data-mysql:
```

---

## LATIHAN 2: Menjalankan "Playlist" (Up)

### Langkah 1: Navigasi via Terminal
Buka PowerShell, masuk ke folder latihan tadi:
```powershell
cd C:\Users\Savira\OneDrive\Desktop\BLJRSQL\BelajarDocker\05_DOCKER_COMPOSE\latihan
```

### Langkah 2: Magic Command! ✨
Ketik SATU command ini:
```powershell
docker compose up -d
```

**Perhatikan Output-nya!**
Docker otomatis:
1. Membuat network (`latihan_default`)
2. Membuat volume (`latihan_data-mysql`)
3. Menjalankan container `db_toko`
4. Menjalankan container `pma_toko` setelah db jalan.

### Langkah 3: Verifikasi Status
```powershell
docker compose ps
```
Pastikan kedua container berstatus **Up**.

---

## LATIHAN 3: Test Koneksi Antar Container

Kita akan buktikan bahwa phpMyAdmin bisa mengakses MySQL tanpa IP address, murni menggunakan Docker Compose Network.

### Langkah 1: Buka Web UI
Buka browser → ketik **http://localhost:8080**
*(Jika belum bisa, tunggu 15 detik. MySQL kadang butuh waktu untuk startup)*

### Langkah 2: Login
Di halaman login phpMyAdmin, masukkan:
- Username: `root`
- Password: `password123`

### Langkah 3: Eksplorasi
Lihat di sidebar kiri, apakah database `toko_online` (yang kita definisikan di `docker-compose.yml`) sudah otomatis terbuat?

**Tulis hasil Anda:**
- [ ] Apakah halaman phpMyAdmin terbuka di port 8080?
- [ ] Apakah berhasil login pakai password `password123`?
- [ ] Apakah database `toko_online` sudah ada?

*(Bayangkan betapa mudahnya ini dibanding harus install MySQL installer dan phpMyAdmin XAMPP manual!)*

---

## LATIHAN 4: Melihat Log dari Multi-Container

Terkadang ada error, dan Anda butuh mengecek log. 

### Langkah 1: Lihat log SEMUA container
Ketik di PowerShell (pastikan masih di folder yang sama):
```powershell
docker compose logs -f
```
Perhatikan ada label warnanya! (Misal: `db_toko` warnanya beda dengan `pma_toko`).

### Langkah 2: Generate log baru
Buka browser phpMyAdmin Anda, refresh halamannya. Lalu buat database baru lewat UI phpMyAdmin.
Lihat di PowerShell Anda, log-nya akan berjalan realtime (hot!).

Tekan `Ctrl+C` di PowerShell untuk berhenti melihat log.

---

## LATIHAN 5: Mematikan Environment (Down)

Kerja hari ini selesai? Waktunya mematikan environment agar laptop tidak berat.

### Langkah 1: Matikan dan Hapus Container
```powershell
docker compose down
```

**Output:**
Docker otomatis meng-stop lalu menghapus (`rm`) kedua container, serta menghapus custom network yang tadi dibuat. 
*TAPI TENANG, ingat materi Volume: data Anda di Named Volume AMAN!*

### Langkah 2: Buktikan Data Aman
Jalankan lagi!
```powershell
docker compose up -d
```
Cek browser `localhost:8080`, database yang Anda buat di Langkah 2 tadi masih ada kan? Inilah kekuatan Volume + Compose!

### Langkah 3: Cleanup Total (Hancurkan Data juga)
Jika Anda benar-benar ingin mereset semuanya (termasuk menghapus data database), gunakan flag `-v` (volumes):
```powershell
docker compose down -v
```

**Tulis hasil Anda:**
- [ ] Berhasil melakukan `docker compose down`?
- [ ] Berhasil menghapus volume pakai `docker compose down -v`?

> ✅ Jika semua selesai → Update `progress.md` lalu lanjut ke **Topik 6: Docker MySQL** (Kita akan satukan dengan project SQL Anda!).
