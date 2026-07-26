# TOPIK 2: LATIHAN — Image & Container Hands-On

> ⚠️ **PENTING**: Pastikan Docker Desktop sudah **running** (ikon hijau) sebelum mulai latihan.
> Semua command diketik di **PowerShell**.

---

## LATIHAN 1: Pull dan Jalankan Nginx

### Langkah 1: Pull image Nginx
```powershell
docker pull nginx
```
**Verifikasi**: Jalankan `docker images` dan pastikan `nginx` ada di daftar.

### Langkah 2: Jalankan container Nginx di background dengan port mapping
```powershell
docker run -d -p 8080:80 --name latihan-web nginx
```

### Langkah 3: Verifikasi
1. Ketik `docker ps` — pastikan container `latihan-web` muncul dengan status **Up**
2. Buka browser → ketik **http://localhost:8080**
3. Anda harus melihat halaman **"Welcome to nginx!"**

**Tulis hasil Anda:**
- [ ] `docker ps` menunjukkan container berjalan?
- [ ] Browser menampilkan halaman Nginx?

---

## LATIHAN 2: Masuk ke Dalam Container

### Langkah 1: Masuk ke container Nginx
```powershell
docker exec -it latihan-web /bin/bash
```

### Langkah 2: Eksplorasi di dalam container
Ketik command berikut satu per satu:
```bash
hostname
pwd
ls
cat /etc/nginx/nginx.conf
exit
```

**Tulis hasil Anda:**
- Hostname container: _____________
- Folder aktif (pwd): _____________

---

## LATIHAN 3: Lihat Log Container

### Langkah 1: Buka browser dan akses http://localhost:8080 beberapa kali (refresh 3-4 kali)

### Langkah 2: Lihat log
```powershell
docker logs latihan-web
```

**Tulis hasil Anda:**
- Apakah Anda melihat log akses dari browser Anda? (contoh: `GET / HTTP/1.1` 200)
- [ ] Ya
- [ ] Tidak

---

## LATIHAN 4: Stop, Start, Remove

### Langkah 1: Stop container
```powershell
docker stop latihan-web
```

### Langkah 2: Verifikasi sudah berhenti
```powershell
docker ps
```
Container `latihan-web` seharusnya **TIDAK MUNCUL** di sini.

```powershell
docker ps -a
```
Container `latihan-web` seharusnya **MUNCUL** di sini dengan status **Exited**.

### Langkah 3: Start ulang
```powershell
docker start latihan-web
```
Cek `docker ps` — container harus **kembali Up**.

### Langkah 4: Hapus container
```powershell
docker stop latihan-web
docker rm latihan-web
```
Cek `docker ps -a` — container `latihan-web` seharusnya sudah **HILANG**.

**Tulis hasil Anda:**
- [ ] Container berhasil di-stop?
- [ ] Container muncul di `docker ps -a` setelah stop?
- [ ] Container berhasil di-start ulang?
- [ ] Container berhasil dihapus dengan `docker rm`?

---

## LATIHAN 5: Jalankan MySQL di Docker

### Langkah 1: Jalankan MySQL container
```powershell
docker run -d --name latihan-mysql -e MYSQL_ROOT_PASSWORD=belajar123 -p 3306:3306 mysql:8.0
```

### Langkah 2: Tunggu sekitar 15-30 detik (MySQL perlu waktu inisialisasi)
Cek log untuk memastikan MySQL siap:
```powershell
docker logs latihan-mysql
```
Cari baris: `ready for connections` atau `mysqld: ready for connections`

### Langkah 3: Masuk ke MySQL shell
```powershell
docker exec -it latihan-mysql mysql -u root -p
```
Ketik password: `belajar123`

### Langkah 4: Jalankan query SQL (pakai skill Anda dari belajar SQL!)
```sql
SHOW DATABASES;
CREATE DATABASE latihan_docker;
USE latihan_docker;
CREATE TABLE test (id INT PRIMARY KEY, pesan VARCHAR(100));
INSERT INTO test VALUES (1, 'Hello dari Docker!');
SELECT * FROM test;
```

### Langkah 5: Keluar
```sql
exit
```

**Tulis hasil Anda:**
- [ ] MySQL container berhasil berjalan?
- [ ] Bisa masuk ke MySQL shell?
- [ ] Query `SELECT * FROM test` menampilkan "Hello dari Docker!"?

---

## LATIHAN 6: Cleanup (Bersih-bersih)

### Hapus semua container yang sudah dibuat:
```powershell
docker stop latihan-mysql
docker rm latihan-mysql
```

### Lihat image yang sudah ter-download:
```powershell
docker images
```

### (Opsional) Bersihkan semua yang tidak terpakai:
```powershell
docker system prune
```
Ketik `y` saat diminta konfirmasi.

---

## 📝 Ringkasan Command yang Sudah Anda Pelajari

| Command | Fungsi |
|:---|:---|
| `docker pull image` | Download image |
| `docker run -d -p HOST:CONTAINER --name NAMA image` | Jalankan container |
| `docker ps` | Lihat container running |
| `docker ps -a` | Lihat semua container |
| `docker exec -it NAMA /bin/bash` | Masuk ke container |
| `docker logs NAMA` | Lihat log |
| `docker stop NAMA` | Hentikan container |
| `docker start NAMA` | Jalankan ulang |
| `docker rm NAMA` | Hapus container |
| `docker images` | Lihat semua image |
| `docker rmi IMAGE` | Hapus image |
| `docker system prune` | Bersihkan yang tidak terpakai |

> ✅ Jika semua latihan selesai → Lanjut ke **Topik 3: Dockerfile**!
