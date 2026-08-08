# TOPIK 0: INSTALASI DOCKER DESKTOP (Windows)

---

## 🎯 Tujuan
Setelah topik ini selesai, Docker Desktop sudah terinstall di komputer Anda dan siap digunakan.

---

## 📋 PRASYARAT (Cek Dulu Sebelum Install!)

Docker Desktop di Windows **membutuhkan WSL 2** (Windows Subsystem for Linux versi 2).

### Cek Apakah WSL Sudah Terinstall:
Buka **PowerShell** (Run as Administrator), lalu ketik:
```powershell
wsl --version
```

**Jika muncul versi** → WSL sudah ada, lanjut ke langkah install Docker.

**Jika error / tidak dikenali** → Anda perlu install WSL dulu. Ketik:
```powershell
wsl --install
```
> ⚠️ Setelah install WSL, **RESTART komputer Anda** sebelum lanjut.

Setelah restart, buka PowerShell lagi dan verifikasi:
```powershell
wsl --version
```
Pastikan muncul output seperti:
```
WSL version: 2.x.x.x
Kernel version: 5.x.x.x
...
```

---

## 📥 LANGKAH 1: Download Docker Desktop

1. Buka browser, pergi ke: **https://www.docker.com/products/docker-desktop/**
2. Klik tombol **"Download for Windows"**
3. File yang ter-download: `Docker Desktop Installer.exe` (sekitar ~500MB)

---

## 📥 LANGKAH 2: Install Docker Desktop

1. **Double-click** file `Docker Desktop Installer.exe`
2. Pada layar konfigurasi:
   - ✅ Centang **"Use WSL 2 instead of Hyper-V"** (WAJIB!)
   - ✅ Centang **"Add shortcut to desktop"** (opsional)
3. Klik **"OK"** dan tunggu proses instalasi selesai
4. Klik **"Close and restart"** → Komputer akan **restart**

---

## 📥 LANGKAH 3: Setup Pertama Kali

1. Setelah restart, **Docker Desktop** akan otomatis terbuka (atau buka manual dari Start Menu)
2. Anda mungkin diminta:
   - **Accept Terms** → Klik Accept
   - **Sign in** → Anda bisa **skip** (tidak wajib login untuk belajar)
3. Tunggu sampai status di pojok kiri bawah Docker Desktop berubah menjadi **"Engine running"** (ikon hijau)

> 💡 **Tips**: Docker Desktop harus dalam keadaan **running** setiap kali Anda ingin menggunakan Docker. Jika belum jalan, buka Docker Desktop dari Start Menu.

---

## ✅ LANGKAH 4: Verifikasi Instalasi

Buka **PowerShell** (tidak perlu admin), lalu ketik command-command berikut **satu per satu**:

### 4.1 Cek versi Docker:
```powershell
docker version
```
**Expected output** (kurang lebih):
```
Client:
 Version:           27.x.x
 ...

Server:
 Engine:
  Version:          27.x.x
  ...
```
> Jika muncul **Client DAN Server**, berarti Docker Engine sudah berjalan. ✅

### 4.2 Cek info Docker:
```powershell
docker info
```
**Expected output**: Banyak informasi teknis. Yang penting cari baris ini:
```
Server Version: 27.x.x
Operating System: Docker Desktop
```

### 4.3 Jalankan Container Pertama Anda! 🎉
```powershell
docker run hello-world
```
**Expected output**:
```
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
...
Hello from Docker!
This message shows that your installation appears to be working correctly.
...
```

> 🎉 **Selamat!** Jika Anda melihat pesan "Hello from Docker!", berarti Docker sudah 100% siap digunakan.

---

## ❓ TROUBLESHOOTING (Jika Ada Masalah)

### Masalah 1: "docker: command not found"
**Solusi**: Tutup PowerShell, buka ulang. Jika masih error, restart komputer.

### Masalah 2: "Error: Cannot connect to the Docker daemon"
**Solusi**: Docker Desktop belum running. Buka Docker Desktop dari Start Menu, tunggu sampai status "Engine running" (ikon hijau).

### Masalah 3: "WSL 2 installation is incomplete"
**Solusi**: 
1. Buka PowerShell sebagai Admin
2. Ketik: `wsl --update`
3. Restart komputer
4. Buka Docker Desktop lagi

### Masalah 4: "Hardware assisted virtualization and data execution protection must be enabled in the BIOS"
**Solusi**: Anda perlu masuk ke BIOS komputer dan enable Virtualization Technology (VT-x/AMD-V). Caranya berbeda-beda tergantung merek laptop:
- Restart → tekan F2/F10/Del (tergantung laptop) saat booting
- Cari menu "Virtualization" → Enable
- Save & Exit

> ⚠️ Jika Anda menemui masalah yang tidak ada di daftar ini, screenshot error-nya dan tanya saya.

---

## 📝 Checklist Selesai Topik 0

- [ ] WSL 2 terinstall (`wsl --version` berhasil)
- [ ] Docker Desktop terinstall dan running (ikon hijau)
- [ ] `docker version` menampilkan Client DAN Server
- [ ] `docker run hello-world` berhasil menampilkan "Hello from Docker!"

**Jika semua ✅ → Lanjut ke Topik 1: Konsep Dasar Docker!**

<!-- rev-5521 -->
