# TOPIK 2: IMAGE & CONTAINER

---

## 🎯 Tujuan
Setelah topik ini, Anda bisa **pull image**, **menjalankan container**, **mengelola lifecycle container** (start, stop, remove), dan **mengakses container yang sedang berjalan**.

> 💡 Ini adalah topik **hands-on pertama** Anda. Semua command di sini harus Anda ketik sendiri di terminal (PowerShell).

---

## 1️⃣ DOCKER HUB — Toko Image

Sebelum menjalankan container, Anda perlu **image**. Image bisa didapatkan dari **Docker Hub**.

**Docker Hub** = https://hub.docker.com

Bayangkan Docker Hub seperti **Google Play Store**, tapi isinya bukan app Android — isinya **Docker image** yang siap dipakai.

### Image Populer yang Akan Anda Gunakan:

| Image | Kegunaan |
|:---|:---|
| `mysql` | Database MySQL |
| `nginx` | Web server |
| `node` | Runtime Node.js |
| `python` | Runtime Python |
| `hello-world` | Image test (sudah Anda coba di Topik 0!) |

### Naming Convention Image:
```
nama_image:tag

Contoh:
  mysql:8.0       ← MySQL versi 8.0
  mysql:latest    ← MySQL versi terbaru
  nginx:alpine    ← Nginx versi ringan (berbasis Alpine Linux)
  node:18         ← Node.js versi 18
```

> 💡 **Tips**: Jika Anda tidak menulis tag, Docker otomatis menggunakan `:latest`.  
> `docker pull mysql` = `docker pull mysql:latest`

---

## 2️⃣ PULL IMAGE — Download Image dari Docker Hub

### Syntax:
```powershell
docker pull nama_image:tag
```

### Contoh:
```powershell
docker pull nginx
```

**Output yang diharapkan:**
```
Using default tag: latest
latest: Pulling from library/nginx
...
Status: Downloaded newer image for nginx:latest
docker.io/library/nginx:latest
```

### Melihat Semua Image yang Sudah Di-download:
```powershell
docker images
```

**Output:**
```
REPOSITORY    TAG       IMAGE ID       CREATED        SIZE
nginx         latest    a8758716bb6a   2 days ago     187MB
hello-world   latest    d2c94e258dcb   14 months ago  13.3kB
```

> **Analogi**: `docker pull` = download app dari Play Store. `docker images` = lihat daftar app yang sudah ter-install.

---

## 3️⃣ RUN CONTAINER — Menjalankan Container dari Image

### Syntax Dasar:
```powershell
docker run nama_image
```

### Contoh 1: Jalankan Nginx (Web Server)
```powershell
docker run nginx
```

Setelah dijalankan, terminal Anda akan "terkunci" (karena Nginx berjalan di foreground).  
Tekan `Ctrl+C` untuk menghentikan.

### Menjalankan di Background (Detached Mode):
Agar terminal tidak terkunci, gunakan flag `-d`:
```powershell
docker run -d nginx
```

**Output:**
```
a1b2c3d4e5f6g7h8i9j0...   ← ini adalah Container ID
```

> 💡 **Tips**: Flag `-d` = **detached** = jalan di background. Anda bisa lanjut pakai terminal untuk command lain.

### Memberi Nama Container:
Secara default, Docker memberi nama random seperti `quirky_einstein`. Agar lebih mudah dikelola, beri nama sendiri:
```powershell
docker run -d --name webserver nginx
```

Sekarang container Anda punya nama `webserver` (bukan nama random).

---

## 4️⃣ PORT MAPPING — Mengakses Container dari Browser

Bayangkan container seperti **kamar hotel** — setiap kamar punya nomor kamar sendiri (port internal). Tapi Anda di luar hotel (laptop Anda) perlu tahu **nomor kamar mana yang harus dituju**.

**Port mapping** = menghubungkan port di laptop Anda ke port di dalam container.

### Syntax:
```powershell
docker run -d -p PORT_LAPTOP:PORT_CONTAINER nama_image
```

### Contoh: Jalankan Nginx dan Akses dari Browser
```powershell
docker run -d -p 8080:80 --name web nginx
```

**Penjelasan:**
- `-p 8080:80` → Port `8080` di laptop Anda dihubungkan ke port `80` di dalam container
- Nginx secara default listen di port `80` (di dalam container)
- Anda bisa akses dari browser di: **http://localhost:8080**

```
Laptop Anda                    Container Nginx
┌──────────────┐              ┌──────────────┐
│              │   8080 ←→ 80 │              │
│  Browser     │──────────────│  Nginx       │
│  localhost:  │              │  (port 80)   │
│  8080        │              │              │
└──────────────┘              └──────────────┘
```

> 🎯 Buka browser → ketik `http://localhost:8080` → Anda akan melihat halaman **"Welcome to nginx!"**

### Port Mapping Beberapa Container:
Setiap container harus pakai port laptop yang BERBEDA:
```powershell
docker run -d -p 8080:80 --name web1 nginx
docker run -d -p 8081:80 --name web2 nginx
```
- `http://localhost:8080` → web1
- `http://localhost:8081` → web2

---

## 5️⃣ MELIHAT CONTAINER — Docker PS

### Melihat Container yang Sedang Berjalan:
```powershell
docker ps
```

**Output:**
```
CONTAINER ID   IMAGE   COMMAND                  CREATED          STATUS          PORTS                  NAMES
a1b2c3d4e5f6   nginx   "/docker-entrypoint.…"   2 minutes ago    Up 2 minutes    0.0.0.0:8080->80/tcp   web
```

### Melihat SEMUA Container (termasuk yang sudah berhenti):
```powershell
docker ps -a
```

> 💡 **Tips**: Ingat `-a` = **all**. Tanpa `-a`, hanya container yang sedang running yang ditampilkan.

---

## 6️⃣ STOP, START, RESTART CONTAINER

### Menghentikan Container:
```powershell
docker stop nama_container
```
Contoh:
```powershell
docker stop web
```

### Menjalankan Ulang Container yang Sudah Berhenti:
```powershell
docker start web
```

### Restart Container (stop + start):
```powershell
docker restart web
```

> 💡 **Penting**: `docker stop` hanya **menghentikan** container, TIDAK menghapusnya. Container masih ada dan bisa di-`start` lagi. Data di dalam container masih ada selama container belum di-remove.

---

## 7️⃣ MASUK KE DALAM CONTAINER — Docker Exec

Kadang Anda perlu "masuk" ke dalam container untuk debug atau inspeksi. Ini seperti **SSH ke server**, tapi untuk container.

### Syntax:
```powershell
docker exec -it nama_container /bin/bash
```

**Penjelasan flag:**
- `-i` = interactive (menerima input dari Anda)
- `-t` = terminal (membuka terminal session)
- `-it` = biasanya digabung, artinya "buka terminal interaktif"
- `/bin/bash` = jalankan shell bash di dalam container

### Contoh: Masuk ke Container Nginx
```powershell
docker exec -it web /bin/bash
```

Setelah masuk, Anda berada **di dalam container**. Anda bisa ketik command Linux:
```bash
ls                    # lihat isi folder
cat /etc/nginx/nginx.conf   # lihat konfigurasi Nginx
exit                  # keluar dari container
```

> 💡 **Tips**: Jika `/bin/bash` error, coba `/bin/sh` (beberapa image ringan tidak punya bash).

### Menjalankan Command Tanpa Masuk (One-Shot):
```powershell
docker exec web cat /etc/hostname
```
Ini langsung menjalankan `cat /etc/hostname` di dalam container dan menampilkan hasilnya, tanpa membuka terminal interaktif.

---

## 8️⃣ MELIHAT LOG CONTAINER

Saat container berjalan di background (`-d`), Anda bisa melihat log-nya:

```powershell
docker logs nama_container
```

### Contoh:
```powershell
docker logs web
```

### Melihat Log Secara Realtime (Follow):
```powershell
docker logs -f web
```
Tekan `Ctrl+C` untuk berhenti follow.

> **Analogi**: `docker logs` seperti membaca buku catatan harian container — semua aktivitas tercatat di sana.

---

## 9️⃣ MENGHAPUS CONTAINER DAN IMAGE

### Menghapus Container:
Container harus di-**stop** dulu sebelum dihapus:
```powershell
docker stop web
docker rm web
```

Atau force remove (tanpa stop dulu):
```powershell
docker rm -f web
```

### Menghapus Image:
```powershell
docker rmi nginx
```

> ⚠️ Image hanya bisa dihapus jika **tidak ada container** (running atau stopped) yang menggunakan image tersebut.

### Membersihkan Semua yang Tidak Terpakai:
```powershell
docker system prune
```
Ini menghapus:
- Semua stopped container
- Semua unused network
- Semua dangling image (image tanpa tag)

---

## 🔄 RINGKASAN LIFECYCLE CONTAINER

```
docker pull     → Download image dari Docker Hub
      ↓
docker run      → Buat + jalankan container dari image
      ↓
docker ps       → Lihat container yang berjalan
      ↓
docker stop     → Hentikan container
      ↓
docker start    → Jalankan ulang container yang berhenti
      ↓
docker rm       → Hapus container (permanen)
      ↓
docker rmi      → Hapus image
```

---

## 🌡️ ENVIRONMENT VARIABLES

Beberapa image membutuhkan **konfigurasi** saat dijalankan. Ini dilakukan lewat **environment variables** dengan flag `-e`.

### Contoh: Menjalankan MySQL Container
MySQL membutuhkan password root saat pertama kali dijalankan:
```powershell
docker run -d --name mydb -e MYSQL_ROOT_PASSWORD=password123 -p 3306:3306 mysql:8.0
```

**Penjelasan:**
- `-e MYSQL_ROOT_PASSWORD=password123` → set password root MySQL
- `-p 3306:3306` → port mapping MySQL (port default MySQL = 3306)

> 💡 **Analogi**: Environment variable seperti **formulir pendaftaran** yang harus diisi saat check-in hotel. MySQL tidak mau jalan kalau Anda belum isi password-nya.

### Masuk ke MySQL Container:
```powershell
docker exec -it mydb mysql -u root -p
```
Lalu ketik password: `password123`

Sekarang Anda berada di dalam **MySQL shell** yang berjalan di Docker! Coba:
```sql
SHOW DATABASES;
```

> 🎉 Ini artinya Anda sudah bisa menjalankan MySQL **tanpa install MySQL native** di laptop Anda!

Ketik `exit` untuk keluar dari MySQL shell.

---

## 📝 Checklist Selesai Topik 2

- [ ] Bisa `docker pull` image dari Docker Hub
- [ ] Bisa `docker run` container di background (`-d`)
- [ ] Bisa mengakses container via browser (port mapping `-p`)
- [ ] Bisa melihat container berjalan (`docker ps`)
- [ ] Bisa `docker exec -it` masuk ke dalam container
- [ ] Bisa `docker logs` melihat log container
- [ ] Bisa `docker stop` + `docker rm` mengelola container
- [ ] Bisa menjalankan MySQL di Docker dan masuk ke MySQL shell

**Jika semua ✅ → Kerjakan latihan.md lalu lanjut ke Topik 3: Dockerfile!**
