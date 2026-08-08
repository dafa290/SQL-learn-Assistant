# TOPIK 4: LATIHAN — Volume & Network

> ⚠️ **PENTING**: Buka PowerShell. Pastikan tidak ada container MySQL yang sedang running dari latihan sebelumnya. (Bisa cek dengan `docker ps`).

---

## LATIHAN 1: Buktikan Data Hilang TANPA Volume

Kita akan melihat langsung betapa ngerinya kehilangan data jika tidak pakai volume.

### Langkah 1: Jalankan MySQL tanpa volume
```powershell
docker run -d --name mysql-no-volume -e MYSQL_ROOT_PASSWORD=123 mysql:8.0
```

### Langkah 2: Buat data di dalam container
Tunggu 15 detik. Masuk ke MySQL shell:
```powershell
docker exec -it mysql-no-volume mysql -u root -p
```
*(Masukkan password: `123`)*

Ketik query SQL ini:
```sql
CREATE DATABASE penting;
USE penting;
CREATE TABLE user (nama VARCHAR(50));
INSERT INTO user VALUES ('Budi'), ('Andi');
SELECT * FROM user;
exit
```

### Langkah 3: Hapus Container (Bencana!)
Anda menekan command `rm` secara tidak sengaja:
```powershell
docker stop mysql-no-volume
docker rm mysql-no-volume
```

### Langkah 4: Cek Data
Coba jalankan container MySQL dengan nama yang sama lagi:
```powershell
docker run -d --name mysql-no-volume -e MYSQL_ROOT_PASSWORD=123 mysql:8.0
```
Tunggu 15 detik, masuk lagi:
```powershell
docker exec -it mysql-no-volume mysql -u root -p
```
*(password: 123)*

Cek database:
```sql
SHOW DATABASES;
exit
```

**Tulis hasil Anda:**
- [ ] Apakah database `penting` yang tadi dibuat masih ada? (Ya / Tidak) ________

*(Hapus container ini agar bersih: `docker stop mysql-no-volume` lalu `docker rm mysql-no-volume`)*

---

## LATIHAN 2: Menyelamatkan Data DENGAN Named Volume

Sekarang kita pakai **Named Volume** seperti yang sering dipakai Backend Developer.

### Langkah 1: Buat Named Volume
```powershell
docker volume create volume-mysql-saya
```

### Langkah 2: Jalankan MySQL DENGAN volume
Kita mount (pasangkan) volume tersebut ke `/var/lib/mysql` (folder data default MySQL).
```powershell
docker run -d --name mysql-aman -v volume-mysql-saya:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123 mysql:8.0
```

### Langkah 3: Buat data
Tunggu 15 detik. Masuk ke MySQL shell:
```powershell
docker exec -it mysql-aman mysql -u root -p
```
*(password: 123)*

Ketik query SQL ini:
```sql
CREATE DATABASE database_aman;
USE database_aman;
CREATE TABLE produk (nama VARCHAR(50));
INSERT INTO produk VALUES ('Laptop'), ('Mouse');
SELECT * FROM produk;
exit
```

### Langkah 4: Hapus Container!
```powershell
docker stop mysql-aman
docker rm mysql-aman
```
*(Container hancur, tapi apakah data aman? Mari kita buktikan!)*

### Langkah 5: Buat Container BARU dengan Volume LAMA
Kita buat container baru dengan nama beda (`mysql-baru`), tapi kita colokkan **volume yang sama** (`volume-mysql-saya`).
```powershell
docker run -d --name mysql-baru -v volume-mysql-saya:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123 mysql:8.0
```

### Langkah 6: Buktikan!
Tunggu 15 detik, masuk ke container baru:
```powershell
docker exec -it mysql-baru mysql -u root -p
```
*(password: 123)*

Cek data:
```sql
SHOW DATABASES;
USE database_aman;
SELECT * FROM produk;
exit
```

**Tulis hasil Anda:**
- [ ] Apakah `database_aman` berhasil diselamatkan meskipun container lamanya dihapus?

---

## LATIHAN 3: Bind Mount (Hot Reload Code)

Kita akan hubungkan folder lokal ke container Nginx. Apapun yang di-edit di laptop, akan langsung berubah di browser.

### Langkah 1: Buat file lokal
Buat folder `html` di Desktop Anda (atau di mana saja yang mudah).
Di dalamnya, buat file `index.html`:
```html
<h1>Ini Bind Mount!</h1>
```

### Langkah 2: Jalankan Container Nginx dengan Bind Mount
Sesuaikan path `C:\...` dengan lokasi folder `html` Anda (harus absolute path / full path dari `C:\`).

```powershell
docker run -d --name web-bind -p 8888:80 -v C:\Users\Savira\OneDrive\Desktop\html:/usr/share/nginx/html nginx
```
*(Ganti path di atas dengan lokasi folder `html` Anda yang sebenarnya).*

### Langkah 3: Test Hot Reload
1. Buka browser: **http://localhost:8888** (Lihat tulisan "Ini Bind Mount!")
2. Buka file `index.html` di laptop Anda pakai Notepad / VS Code.
3. Ubah menjadi `<h1>Wow! Berubah tanpa rebuild image!</h1>` lalu Save.
4. Refresh browser!

**Tulis hasil Anda:**
- [ ] Apakah tulisan di browser langsung berubah seketika tanpa perlu restart/rebuild Docker?

---

## LATIHAN 4: Bersih-bersih

```powershell
docker stop mysql-baru web-bind
docker rm mysql-baru web-bind
docker volume rm volume-mysql-saya
```

> ✅ Jika semua selesai → Update `progress.md` lalu lanjut ke **Topik 5: Docker Compose**!

<!-- rev-7432 -->
