# 🐳 BELAJAR DOCKER — Backend Developer Edition

**Tujuan**: Memahami Docker yang **dibutuhkan backend developer** untuk development & magang.

**Learner Profile**: Backend Java developer yang mau paham Docker untuk kebutuhan kerja sehari-hari.

**BUKAN** untuk: DevOps Engineer (itu nanti setelah 2-3 tahun pengalaman backend).

---

## ⚠️ SCOPE: Apa yang Backend Dev Perlu Tahu tentang Docker?

### ✅ YANG DIPELAJARI (Backend Dev Daily Use):
1. **Menjalankan database di Docker** (MySQL, PostgreSQL) — biar gak install native
2. **Menulis Dockerfile** untuk containerize aplikasi backend sendiri
3. **Docker Compose** untuk jalankan app + database bersamaan
4. **Volume** untuk data persistence (database gak hilang saat restart)
5. **Network** dasar agar app bisa connect ke database container
6. **Push/pull image** dari Docker Hub

### ❌ YANG TIDAK DIPELAJARI (DevOps Scope — nanti saja):
- ❌ Kubernetes / Docker Swarm (orchestration)
- ❌ CI/CD Pipeline dengan Docker
- ❌ Nginx reverse proxy (ops task)
- ❌ Docker dalam production server
- ❌ Container monitoring & alerting
- ❌ Multi-stage build yang kompleks

---

## 🏗️ STRUKTUR FOLDER

```
BelajarDocker/
├── README.md                          ← File ini
├── 00_INSTALASI/
│   └── materi.md                      ← Install Docker Desktop + verifikasi
├── 01_KONSEP_DASAR/
│   ├── materi.md                      ← Apa itu Docker, kenapa perlu, analogi
│   └── latihan.md                     ← Quiz konseptual
├── 02_IMAGE_DAN_CONTAINER/
│   ├── materi.md                      ← Pull, run, stop, rm, exec, port mapping
│   └── latihan.md                     ← Latihan hands-on
├── 03_DOCKERFILE/
│   ├── materi.md                      ← Menulis Dockerfile, build image
│   ├── latihan.md                     ← Instruksi step-by-step
│   └── latihan/                       ← File project (Dockerfile, index.html)
├── 04_VOLUME_DAN_NETWORK/
│   ├── materi.md                      ← Data persistence + container networking
│   └── latihan.md                     ← Latihan volume & network
├── 05_DOCKER_COMPOSE/
│   ├── materi.md                      ← Multi-container dengan docker-compose.yml
│   ├── latihan.md                     ← Latihan compose
│   └── latihan/                       ← docker-compose.yml
├── 06_DOCKER_MYSQL/
│   ├── materi.md                      ← MySQL di Docker (koneksi ke skill SQL Anda!)
│   ├── latihan.md                     ← Latihan MySQL container
│   └── latihan/                       ← docker-compose.yml + init.sql
├── 07_DOCKER_BACKEND_APP/
│   ├── materi.md                      ← Containerize backend app + connect ke DB
│   ├── latihan.md                     ← Latihan full stack
│   └── latihan/                       ← Dockerfile + docker-compose.yml + app/
├── PROJECT_FINAL/
│   ├── scenario.md                    ← Ujian akhir: deploy Backend + MySQL
│   └── jawaban/                       ← Kunci jawaban
└── REPORT/
    └── progress.md                    ← Progress tracking (WAJIB!)
```

---

## 📚 ROADMAP

| No | Topik | Fokus | Estimasi |
|:---|:---|:---|:---|
| 0 | Instalasi | Docker Desktop + WSL 2 | 30 menit |
| 1 | Konsep Dasar | Apa itu Docker, analogi, arsitektur | 45 menit |
| 2 | Image & Container | pull, run, stop, exec, port mapping | 1-2 jam |
| 3 | Dockerfile | Build custom image | 1-2 jam |
| 4 | Volume & Network | Data persistence + container networking | 1-2 jam |
| 5 | Docker Compose | Multi-container setup | 1-2 jam |
| 6 | Docker + MySQL | Database di container (pakai skill SQL Anda!) | 1 jam |
| 7 | Backend App | Containerize app + connect ke MySQL | 2 jam |
| 🏆 | Project Final | Deploy Backend + MySQL dengan Compose | 2 jam |

**Total: ~12 jam** (2-4 hari intensif atau 1-2 minggu santai)

---

## ⚠️ ATURAN MAIN

1. **NO SURPRISE CONCEPTS** — Semua yang ada di latihan HARUS sudah dijelaskan di materi
2. **Analogi WAJIB** — Setiap konsep baru harus ada analogi dunia nyata
3. **Hands-on > Teori** — Setiap topik harus ada yang Anda ketik di terminal
4. **Progress tracking** — Update `progress.md` setelah setiap topik
5. **Urutan TIDAK boleh lompat** — Topik 3 butuh Topik 2, dst
6. **Boleh tanya kapan saja** — Kalau ada yang tidak paham, tanya sebelum lanjut

---

## 🎯 Setelah Selesai, Anda Bisa:

1. ✅ Menjalankan MySQL di Docker (gak perlu install native lagi!)
2. ✅ Menulis Dockerfile untuk containerize backend app
3. ✅ Pakai Docker Compose untuk development (app + database sekaligus)
4. ✅ Push image ke Docker Hub
5. ✅ **Siap magang backend** dengan pemahaman Docker yang solid

---

**Mulai dari**: `00_INSTALASI/materi.md`
