# TOPIK 4: VOLUME & NETWORK

---

## 🎯 Tujuan
Setelah topik ini, Anda paham **kenapa data hilang saat container dihapus**, cara **menyimpan data permanen (Volume)**, dan cara **menghubungkan container (Network)** agar bisa saling komunikasi.

---

## 1️⃣ MASALAH: "Di mana data database saya?!"

Coba bayangkan skenario ini:
1. Anda jalankan container MySQL: `docker run -d mysql`
2. Anda masuk ke MySQL shell, lalu create table `users` dan insert 100 data.
3. Anda matikan laptop. Besoknya, Anda merasa butuh container baru yang fresh, jadi container yang kemarin di-`rm` dan diganti baru.
4. Anda cek table `users`. **Data hilang semua!**

### Kenapa Data Hilang?
Secara default, semua file yang dibuat/diubah *di dalam* container akan disimpan di **container layer** (lapisan tipis yang nempel di container). 
**Sifat layer ini: Jika container dihapus (`rm`), layer ini ikut TERHAPUS permanen!**

**Analogi:** Container itu seperti **komputer sewaan di warnet**. Anda bisa ngetik tugas di sana, tapi begitu waktu sewa habis dan komputer di-restart oleh abang warnet, semua file Anda di Desktop hilang!

---

## 2️⃣ SOLUSI: VOLUME (Data Persistence)

Untuk menyimpan tugas Anda dari warnet, Anda pakai **Flashdisk**. Di Docker, flashdisk ini disebut **Volume**.

Volume adalah ruang penyimpanan yang **berada di luar lifecycle container**. Walaupun container dihancurkan 1000 kali, data di volume akan tetap aman.

Ada 2 tipe Volume di Docker:

### A. Named Volume (Dikelola oleh Docker)
- Docker yang membuat dan mengatur lokasi file-nya (biasanya tersembunyi di dalam folder sistem Docker).
- **Kapan dipakai?** Untuk database (MySQL, PostgreSQL). Kita tidak peduli *di mana* file-nya disimpan di laptop kita, yang penting data tidak hilang.

**Cara Pakai (Named Volume):**
Gunakan flag `-v nama_volume:path_di_container`

```powershell
docker run -d --name mydb -v data-mysql:/var/lib/mysql mysql:8.0
```
*Artinya: "Tolong mount volume bernama `data-mysql` ke folder `/var/lib/mysql` di dalam container. (Note: `/var/lib/mysql` adalah tempat MySQL menyimpan datanya secara default).*

Jika `mydb` dihapus, lalu Anda buat container `mydb-v2` dan pakai `-v data-mysql:/var/lib/mysql` lagi, data lama akan langsung muncul di `mydb-v2`!

### B. Bind Mount (Menghubungkan Folder Lokal)
- Anda yang menentukan **folder spesifik di laptop Anda** untuk dihubungkan ke container.
- **Kapan dipakai?** Untuk **development backend/frontend**. Anda mengubah code di VS Code (laptop), dan perubahan langsung (hot reload) terlihat di container tanpa perlu rebuild image.

**Cara Pakai (Bind Mount):**
Gunakan flag `-v path_lokal:path_di_container`

```powershell
# Contoh di Windows (harus pakai absolute path lengkap)
docker run -d --name web -v C:\Users\Savira\Website:/usr/share/nginx/html nginx
```
*Artinya: "Hubungkan folder `Website` di laptop saya dengan folder web server Nginx di container. Apa yang saya edit di laptop akan langsung mengubah website di container."*

---

## 3️⃣ DOCKER NETWORK (Komunikasi Antar Container)

Sebagai Backend Dev, Anda membuat REST API pakai Java Spring Boot, dan databasenya MySQL.
Jika keduanya di-containerize:
- Container 1: Backend App
- Container 2: MySQL

**Bagaimana Container 1 bisa ngobrol dengan Container 2?**
Mereka butuh jalan/kabel yang menghubungkan mereka. Di Docker, ini disebut **Network**.

### Default Network (Bridge)
Secara default, saat Anda `run` container, Docker menaruhnya di jaringan bernama `bridge`. Container di jaringan ini *bisa* ngobrol, tapi harus pakai **IP Address**.
*(Ini ribet, karena IP Address container bisa berubah-ubah tiap kali di-restart).*

### Custom Network (User-Defined)
Best practice-nya adalah: **Buat jaringan Anda sendiri.**

**Keuntungannya:** Container yang berada di custom network yang sama bisa saling memanggil menggunakan **Nama Container** sebagai URL (DNS Resolution)!

**Analogi:** Seperti menyimpan kontak di HP. Daripada menghafal nomor telepon (IP Address), Anda tinggal ketik "Budi" (Nama Container).

### Step-by-step menghubungkan 2 Container:

1. **Buat Jaringan Baru:**
   ```powershell
   docker network create jaringan-toko
   ```

2. **Jalankan Database di jaringan tersebut:**
   Gunakan flag `--network`
   ```powershell
   docker run -d --name db-toko --network jaringan-toko -e MYSQL_ROOT_PASSWORD=rahasia mysql:8.0
   ```

3. **Jalankan Backend App di jaringan yang SAMA:**
   ```powershell
   docker run -d --name app-backend --network jaringan-toko image-backend-saya
   ```

Sekarang, dari dalam kode Java Backend Anda, URL koneksi databasenya BUKAN `localhost`, melainkan nama containernya:
`jdbc:mysql://db-toko:3306/toko_online`

> 🚨 **KESALAHAN PEMULA:** Container yang berkomunikasi dengan container lain di Docker menggunakan **nama container** (`db-toko`), bukan `localhost`. Kata `localhost` di dalam container merujuk pada dirinya sendiri!

---

## 📝 Ringkasan

1. **Named Volume** → Menyimpan data database agar tidak hilang saat container dihapus (di-manage Docker).
2. **Bind Mount** → Menghubungkan folder coding di laptop ke container agar perubahan langsung terlihat (di-manage Anda).
3. **Custom Network** → Agar container (misal: App dan Database) bisa saling memanggil menggunakan **nama container**, bukan IP address.

---

> ✅ Lanjut ke **latihan.md** untuk membuktikan bahwa data database benar-benar tidak hilang walau container dihapus!

<!-- rev-9840 -->
