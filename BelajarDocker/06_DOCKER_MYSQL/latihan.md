# TOPIK 6: LATIHAN — Docker + MySQL (Auto-load)

> ⚠️ **PENTING**: Buka PowerShell. Pastikan tidak ada container MySQL yang berjalan. Jika ada, lakukan `docker compose down` di folder Topik 5 tadi.

---

## LATIHAN 1: Menyiapkan File Setup SQL

### Langkah 1: Buat Folder Latihan
1. Buka File Explorer
2. Buat folder `latihan` di dalam `06_DOCKER_MYSQL`
3. Masuk ke folder tersebut.

### Langkah 2: Copy File SQL Anda
1. Buka folder `C:\Users\Savira\OneDrive\Desktop\BLJRSQL\DATABASE_SETUP\`
2. Copy file `setup.sql` dari sana.
3. Paste ke dalam folder `latihan` (di dalam `06_DOCKER_MYSQL`) yang baru Anda buat tadi.

---

## LATIHAN 2: Membuat Docker Compose

### Langkah 1: Buat `docker-compose.yml`
Di folder `latihan` yang sama (bersebelahan dengan `setup.sql`), buat file `docker-compose.yml`:

```yaml
version: '3.8'

services:
  db_toko:
    image: mysql:8.0
    container_name: mysql_auto_toko
    ports:
      - "3306:3306"
    environment:
      MYSQL_ROOT_PASSWORD: password123
      MYSQL_DATABASE: toko_online
    volumes:
      - data-toko:/var/lib/mysql
      # Magic command: Mount setup.sql dari folder saat ini (./) 
      # ke folder docker-entrypoint di dalam container
      - ./setup.sql:/docker-entrypoint-initdb.d/01_setup.sql

volumes:
  data-toko:
```

*(Notice nama filenya jadi `01_setup.sql` di kanan? Angka `01_` berguna jika Anda punya banyak file SQL, Docker akan mengeksekusinya berurutan sesuai abjad/angka).*

---

## LATIHAN 3: Run & Buktikan Auto-load

### Langkah 1: Jalankan Compose
Buka PowerShell, pastikan berada di folder `latihan` Topik 6.
```powershell
docker compose up -d
```

### Langkah 2: Tunggu dan Cek Log!
Ini **SANGAT PENTING**. Proses eksekusi script `.sql` memakan waktu.
Cek log-nya:
```powershell
docker compose logs -f
```
Perhatikan log-nya. Anda akan melihat tulisan seperti:
`Executing /docker-entrypoint-initdb.d/01_setup.sql`
Tunggu sampai muncul tulisan `mysqld: ready for connections`.
Lalu tekan `Ctrl+C` untuk keluar dari log.

### Langkah 3: Verifikasi via Docker Exec
Mari masuk ke container untuk membuktikan data toko online Anda sudah ada!
```powershell
docker exec -it mysql_auto_toko mysql -u root -p
```
*(password: password123)*

Jalankan command SQL ini:
```sql
USE toko_online;
SHOW TABLES;
SELECT * FROM produk;
SELECT * FROM pelanggan;
exit
```

**Tulis hasil Anda:**
- [ ] Apakah tabel `produk`, `pelanggan`, `pembelian` sudah ada otomatis tanpa Anda ketik manual?
- [ ] Apakah isi data produknya ada (Laptop, Mouse, dll)?

> 🎉 **Selamat!** Anda berhasil membuat database environment development yang fully automated. Developer backend baru tinggal `docker compose up -d` dan database siap dengan data dummy!

---

## LATIHAN 4: Cleanup (Opsional)
Jika sudah selesai, jangan lupa dimatikan:
```powershell
docker compose down
```

> ✅ Update `progress.md` lalu lanjut ke **Topik 7: Docker Backend App** (Kita akan satukan MySQL ini dengan Backend App sungguhan!).
