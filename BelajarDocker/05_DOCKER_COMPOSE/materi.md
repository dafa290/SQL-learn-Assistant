# TOPIK 5: DOCKER COMPOSE

---

## 🎯 Tujuan
Setelah topik ini, Anda bisa menjalankan **banyak container sekaligus** (misal: Backend App + Database) hanya dengan **satu command**, tanpa perlu mengetik command `docker run` yang panjang berulang-ulang.

---

## 1️⃣ MASALAH: "Command-nya terlalu panjang!"

Di Topik 2 dan 4, Anda menjalankan MySQL dengan command seperti ini:
```powershell
docker run -d --name mysql-db -p 3306:3306 -e MYSQL_ROOT_PASSWORD=rahasia -v volume-db:/var/lib/mysql --network jaringan-toko mysql:8.0
```

Bayangkan Anda bekerja di project sungguhan yang butuh:
1. Container MySQL
2. Container Redis (Caching)
3. Container Backend App (Java Spring Boot)
4. Container Frontend (React)

Apakah Anda harus menghafal dan mengetik 4 command `docker run` super panjang itu setiap pagi sebelum mulai kerja? **Tentu tidak!**

---

## 2️⃣ SOLUSI: DOCKER COMPOSE

**Docker Compose** adalah tools untuk mendefinisikan dan menjalankan multi-container Docker applications.

### Analogi: Playlist Spotify vs Putar Manual 🎧

- `docker run`: Anda mencari lagu satu per satu, lalu memencet tombol play manual untuk setiap lagu.
- `docker-compose`: Anda membuat **Playlist**. Cukup tekan tombol Play satu kali, semua lagu di playlist akan dimainkan secara berurutan.

File playlist-nya disebut **`docker-compose.yml`**. File ini berisi instruksi lengkap tentang container apa saja yang harus jalan, port-nya berapa, network-nya apa, dan volume-nya di mana.

---

## 3️⃣ STRUKTUR FILE `docker-compose.yml`

File ini ditulis dalam format **YAML** (mirip JSON tapi lebih mudah dibaca, menggunakan spasi/indentasi).

Berikut contoh `docker-compose.yml` untuk menjalankan MySQL dan phpMyAdmin (Web UI untuk database):

```yaml
version: '3.8'              # Versi syntax docker-compose

services:                   # Mulai daftar container ("playlist")

  database:                 # Container 1 (Nama bebas, misal: 'database')
    image: mysql:8.0        # Pakai image apa?
    container_name: db_toko # Nama container saat jalan (seperti --name)
    ports:                  # Port mapping (seperti -p)
      - "3306:3306"
    environment:            # Environment variables (seperti -e)
      MYSQL_ROOT_PASSWORD: password123
      MYSQL_DATABASE: toko_online
    volumes:                # Volume mapping (seperti -v)
      - data-mysql:/var/lib/mysql

  admin_db:                 # Container 2 (phpMyAdmin)
    image: phpmyadmin:latest
    container_name: pma_toko
    ports:
      - "8080:80"           # Akses phpMyAdmin di localhost:8080
    environment:
      PMA_HOST: database    # Tahu dari mana? Karena nama service di atas adalah 'database'
    depends_on:             # Tunggu container 'database' jalan dulu baru ini jalan
      - database

volumes:                    # Deklarasi Named Volume
  data-mysql:
```

### Penjelasan Penting (Keajaiban Docker Compose):

1. **Auto-Network**: Secara otomatis, Docker Compose akan membuatkan **satu custom network** untuk semua service di dalam file ini. Anda tidak perlu `docker network create` manual!
2. **DNS Resolution Otomatis**: Perhatikan `PMA_HOST: database`. Container `admin_db` bisa mengenali container MySQL cukup dengan memanggil **nama service-nya** (`database`), bukan IP address!
3. **Lebih Rapi**: Semua konfigurasi (environment, port, volume) tersimpan dalam satu file, bisa di-commit ke Git!

---

## 4️⃣ COMMAND DOCKER COMPOSE

Karena semua instruksi sudah ditulis di file `.yml`, command-nya jadi sangat pendek:

### Menjalankan Semua Container (Play Playlist)
```powershell
docker compose up -d
```
*(Gunakan `-d` agar jalan di background, persis seperti `docker run -d`)*

### Melihat Status Container di Playlist
```powershell
docker compose ps
```
*(Hanya menampilkan container yang ada di file `docker-compose.yml` saat ini, berbeda dengan `docker ps` yang menampilkan semua)*

### Melihat Log Semua Container Sekaligus
```powershell
docker compose logs -f
```
*(Sangat berguna untuk melihat log dari backend & database bersamaan)*

### Menghentikan Semua Container (Stop Playlist)
```powershell
docker compose stop
```

### Menghentikan DAN Menghapus Semua (Destroy Playlist)
```powershell
docker compose down
```
*(Ini akan menghapus container dan network, TAPI **volume data tetap aman**!)*

---

## 5️⃣ BAGAIMANA BACKEND DEV MENGGUNAKAN INI?

Dalam pekerjaan sehari-hari (Backend Developer), file `docker-compose.yml` biasanya dibuat oleh Senior atau DevOps dan dimasukkan ke repository (Git).

Saat Anda pertama kali masuk project (hari pertama kerja):
1. Anda clone repository Git.
2. Buka terminal di folder project.
3. Ketik: `docker compose up -d`
4. BAM! 💥 MySQL, Redis, Kafka, dan semua environment langsung jalan di laptop Anda tanpa perlu install satu-satu.
5. Anda tinggal buka IDE (IntelliJ/VS Code) dan mulai coding!

---

> ✅ Lanjut ke **latihan.md** untuk membuktikan seberapa mudahnya memakai Docker Compose!

<!-- rev-1687 -->
