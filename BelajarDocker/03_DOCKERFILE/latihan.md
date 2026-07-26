# TOPIK 3: LATIHAN — Dockerfile

> ⚠️ **PENTING**: Semua command diketik di **PowerShell**. Pastikan Docker Desktop sedang berjalan.

---

## LATIHAN 1: Build Custom Image Pertama Anda

### Langkah 1: Buat Folder Latihan
1. Buka File Explorer
2. Buat folder baru `latihan` di dalam folder `03_DOCKERFILE`
3. Masuk ke folder `latihan` tersebut

### Langkah 2: Buat File `index.html`
Di dalam folder `latihan`, buat file baru bernama `index.html` dan isi dengan kode berikut:
```html
<!DOCTYPE html>
<html>
<head>
    <title>Web Saya di Docker</title>
</head>
<body>
    <h1>Berhasil Build Image Sendiri!</h1>
    <p>Ini adalah website custom pertama saya yang berjalan di Docker.</p>
</body>
</html>
```

### Langkah 3: Buat File `Dockerfile`
Di folder yang **sama**, buat file bernama `Dockerfile` (tanpa ekstensi .txt atau apapun).
Isi dengan instruksi berikut (sesuai materi):
```dockerfile
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
EXPOSE 80
```

### Langkah 4: Build Image!
Buka PowerShell, masuk ke folder `latihan` tersebut:
```powershell
cd C:\Users\Savira\OneDrive\Desktop\BLJRSQL\BelajarDocker\03_DOCKERFILE\latihan
```
Jalankan command build:
```powershell
docker build -t web-saya .
```
*(Jangan lupa tanda titik `.` di akhir!)*

**Tulis hasil Anda:**
- [ ] Build berhasil tanpa error?
- [ ] Berapa lama waktu build (terlihat di log)? ________

---

## LATIHAN 2: Menjalankan Custom Image

### Langkah 1: Verifikasi Image
```powershell
docker images
```
Cari image dengan nama `web-saya`.

### Langkah 2: Jalankan Container
Jalankan container dari image `web-saya` di port 7070:
```powershell
docker run -d -p 7070:80 --name container-web-saya web-saya
```

### Langkah 3: Test di Browser
Buka browser → ketik **http://localhost:7070**

**Tulis hasil Anda:**
- [ ] Apakah tulisan "Berhasil Build Image Sendiri!" muncul di browser?

---

## LATIHAN 3: Buktikan Caching (Layer System) Bekerja

### Langkah 1: Ubah isi `index.html`
Ubah teks `<h1>` di `index.html` menjadi:
```html
<h1>Build Ulang Ternyata Cepat!</h1>
```
Simpan file.

### Langkah 2: Build Ulang (Rebuild)
Kembali ke PowerShell (pastikan masih di folder `latihan`), jalankan build lagi:
```powershell
docker build -t web-saya-v2 .
```

Perhatikan log output-nya. Seharusnya jauh lebih cepat dan ada tulisan `CACHED` pada langkah `FROM nginx:alpine`.

**Tulis hasil Anda:**
- [ ] Apakah build kedua terasa lebih cepat?
- [ ] Apakah Anda melihat tulisan `CACHED`?

---

## LATIHAN 4: Jalankan Image Versi 2

### Langkah 1: Jalankan container dari image V2
```powershell
docker run -d -p 7071:80 --name container-web-v2 web-saya-v2
```
*(Perhatikan kita pakai port 7071 agar tidak bentrok dengan container sebelumnya yang pakai 7070)*

### Langkah 2: Test di Browser
Buka tab baru di browser → ketik **http://localhost:7071**

**Tulis hasil Anda:**
- [ ] Apakah tulisan "Build Ulang Ternyata Cepat!" muncul di port 7071?
- Coba buka lagi **http://localhost:7070** (tab lama). Tulisan mana yang muncul? _________

> 💡 **Inti Latihan**: Anda membuktikan bahwa Image adalah *blueprint*. Perubahan pada resep (Dockerfile/file sumber) baru akan berlaku jika Anda men-**build ulang** (menjadi image baru) lalu me-**run** container baru. Container lama (`container-web-saya`) tetap berjalan dengan isi dari image lama (`web-saya`).

---

## LATIHAN 5: Bersih-bersih (Cleanup)

### Hapus container dan image latihan ini:
```powershell
docker stop container-web-saya container-web-v2
docker rm container-web-saya container-web-v2
docker rmi web-saya web-saya-v2
```

> ✅ Jika semua selesai → Update `progress.md` lalu lanjut ke **Topik 4: Volume & Network**!
