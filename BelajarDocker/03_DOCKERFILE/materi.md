# TOPIK 3: DOCKERFILE — Build Image Sendiri

---

## 🎯 Tujuan
Setelah topik ini, Anda bisa **menulis Dockerfile** dan **build custom image** sendiri, bukan hanya pull image dari Docker Hub.

---

## 1️⃣ KENAPA PERLU BUILD IMAGE SENDIRI?

Di Topik 2, Anda hanya **menggunakan image yang sudah ada** (nginx, mysql) dari Docker Hub. Tapi di dunia kerja:

```
Skenario: Anda membuat backend API dengan Java Spring Boot.
Image "Java Spring Boot API untuk toko_online" TIDAK ADA di Docker Hub.
Anda harus BUILD image sendiri yang berisi app Anda.
```

**Dockerfile** = file yang berisi instruksi untuk membuat image custom.

---

## 2️⃣ APA ITU DOCKERFILE?

### Analogi: Resep Masakan 📝

Bayangkan Anda ingin membuat nasi goreng:

```
Resep Nasi Goreng:
1. MULAI DARI dapur yang sudah ada kompor dan panci    ← FROM
2. TARUH bahan-bahan ke meja dapur                     ← COPY
3. PINDAH ke area memasak                              ← WORKDIR
4. MASAK: tumis bawang, masukkan nasi, aduk            ← RUN
5. SAJIKAN: taruh di piring, siap dimakan              ← CMD
```

**Dockerfile adalah resep untuk membuat Docker image:**
```dockerfile
FROM node:18           # 1. Mulai dari image yang sudah ada Node.js
COPY . /app            # 2. Salin semua file project ke folder /app
WORKDIR /app           # 3. Pindah ke folder /app
RUN npm install        # 4. Install dependency
CMD ["node", "app.js"] # 5. Jalankan app saat container dimulai
```

---

## 3️⃣ INSTRUKSI DOCKERFILE (Yang Wajib Tahu)

| Instruksi | Fungsi | Analogi |
|:---|:---|:---|
| `FROM` | Base image (titik awal) | "Mulai dari dapur yang sudah ada kompor" |
| `COPY` | Salin file dari laptop ke image | "Taruh bahan-bahan ke meja dapur" |
| `WORKDIR` | Set folder kerja di dalam image | "Pindah ke area memasak" |
| `RUN` | Jalankan command saat **build** image | "Masak: tumis, aduk, goreng" |
| `EXPOSE` | Deklarasi port yang digunakan | "Buka jendela dapur agar aroma keluar" |
| `CMD` | Command yang dijalankan saat container **start** | "Sajikan: taruh di piring" |

### Perbedaan Penting: `RUN` vs `CMD`

| | `RUN` | `CMD` |
|:---|:---|:---|
| **Kapan dijalankan** | Saat **build image** | Saat **container start** |
| **Berapa kali** | Bisa banyak kali | Hanya **1 kali** (yang terakhir yang berlaku) |
| **Contoh** | Install dependency, compile code | Jalankan app |

```dockerfile
# RUN = dijalankan saat build (hasil-nya masuk ke image)
RUN npm install        # install dependency → disimpan di image

# CMD = dijalankan saat container start
CMD ["node", "app.js"] # jalankan app → hanya saat container jalan
```

---

## 4️⃣ PRAKTIK: Build Image Website Sederhana

Kita akan membuat image custom yang berisi **website HTML** yang di-serve oleh Nginx.

### Langkah 1: Buat File HTML

Buat file `index.html` di folder `BelajarDocker/03_DOCKERFILE/latihan/`:

```html
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Website Docker Pertama Saya</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .container {
            text-align: center;
            padding: 40px;
            background: rgba(255,255,255,0.1);
            border-radius: 20px;
        }
        h1 { font-size: 2.5em; }
        p { font-size: 1.2em; opacity: 0.9; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🐳 Hello dari Docker!</h1>
        <p>Website ini berjalan di dalam Docker container.</p>
        <p>Image ini saya build sendiri dari Dockerfile!</p>
    </div>
</body>
</html>
```

### Langkah 2: Buat Dockerfile

Buat file bernama `Dockerfile` (tanpa ekstensi!) di folder yang **sama** (`03_DOCKERFILE/latihan/`):

```dockerfile
# 1. Mulai dari image Nginx (sudah ada web server-nya)
FROM nginx:alpine

# 2. Salin file index.html kita ke folder default Nginx
COPY index.html /usr/share/nginx/html/index.html

# 3. Expose port 80 (port default Nginx)
EXPOSE 80

# 4. CMD tidak perlu ditulis karena image nginx:alpine 
#    sudah punya CMD default untuk menjalankan Nginx
```

> 💡 **Kenapa `nginx:alpine`?** Alpine adalah versi Linux yang sangat ringan (~5MB vs ~100MB). Image `nginx:alpine` jauh lebih kecil dari `nginx` biasa. Ini best practice untuk memperkecil ukuran image.

### Langkah 3: Build Image

Buka **PowerShell**, navigasi ke folder latihan, lalu build:

```powershell
cd C:\Users\Savira\OneDrive\Desktop\BLJRSQL\BelajarDocker\03_DOCKERFILE\latihan
docker build -t website-pertama .
```

**Penjelasan:**
- `docker build` = perintah untuk build image dari Dockerfile
- `-t website-pertama` = beri nama (tag) image: `website-pertama`
- `.` = titik di akhir = **"cari Dockerfile di folder saat ini"** (JANGAN LUPA titik ini!)

**Output yang diharapkan:**
```
[+] Building 2.5s (7/7) FINISHED
 => [1/2] FROM docker.io/library/nginx:alpine
 => [2/2] COPY index.html /usr/share/nginx/html/index.html
 => exporting to image
 => => naming to docker.io/library/website-pertama
```

### Langkah 4: Verifikasi Image Terbuat
```powershell
docker images
```
Anda harus melihat `website-pertama` di daftar image.

### Langkah 5: Jalankan Container dari Image Anda
```powershell
docker run -d -p 9090:80 --name web-custom website-pertama
```

### Langkah 6: Test di Browser
Buka browser → **http://localhost:9090**

Anda harus melihat website dengan tulisan **"🐳 Hello dari Docker!"**

> 🎉 **Selamat!** Anda baru saja build Docker image pertama Anda!

---

## 5️⃣ LAYER SYSTEM — Bagaimana Docker Build Bekerja

Setiap instruksi di Dockerfile menghasilkan **satu layer** (lapisan). Docker menyimpan setiap layer secara terpisah dan melakukan **caching**.

```
Dockerfile                        Layers
┌─────────────────────┐          ┌──────────────┐
│ FROM nginx:alpine   │    →     │ Layer 1: OS  │  ← cached (sudah ada)
├─────────────────────┤          ├──────────────┤
│ COPY index.html ... │    →     │ Layer 2: HTML│  ← baru dibuat
└─────────────────────┘          └──────────────┘
```

### Kenapa Layer Penting?

**Caching!** Jika Anda mengubah `index.html` dan build ulang:
- Layer 1 (`FROM nginx:alpine`) → **sudah di-cache**, tidak perlu download ulang
- Layer 2 (`COPY index.html`) → **berubah**, perlu dibuat ulang

Ini membuat build ulang jauh **lebih cepat** karena Docker hanya rebuild layer yang berubah.

### Best Practice: Taruh yang Jarang Berubah di Atas

```dockerfile
# ✅ BAIK: dependency install (jarang berubah) di atas
FROM node:18
WORKDIR /app
COPY package.json .        # jarang berubah → di-cache
RUN npm install            # jarang berubah → di-cache
COPY . .                   # sering berubah → rebuild dari sini saja
CMD ["node", "app.js"]
```

```dockerfile
# ❌ BURUK: semua di-copy dulu, install setelahnya
FROM node:18
WORKDIR /app
COPY . .                   # sering berubah → SEMUA layer di bawah ini rebuild!
RUN npm install            # harus install ulang setiap kali code berubah!
CMD ["node", "app.js"]
```

---

## 6️⃣ .dockerignore — File yang Tidak Perlu Masuk Image

Sama seperti `.gitignore`, file `.dockerignore` memberitahu Docker **file mana yang TIDAK perlu di-COPY** ke dalam image.

Buat file `.dockerignore` di folder yang sama dengan Dockerfile:

```
node_modules
.git
.env
*.log
README.md
```

**Kenapa penting?**
- Mengurangi ukuran image (tidak perlu copy `node_modules` yang besar)
- Keamanan (tidak copy `.env` yang berisi secret/password)
- Kecepatan build (lebih sedikit file yang di-copy)

---

## 📝 Checklist Selesai Topik 3

- [ ] Paham fungsi setiap instruksi: FROM, COPY, WORKDIR, RUN, EXPOSE, CMD
- [ ] Bisa menulis Dockerfile sederhana
- [ ] Bisa `docker build -t nama .` untuk build image
- [ ] Bisa menjalankan container dari image yang di-build sendiri
- [ ] Paham konsep layer dan caching
- [ ] Paham kegunaan `.dockerignore`

**Jika semua ✅ → Kerjakan latihan.md lalu lanjut ke Topik 4: Volume & Network!**
