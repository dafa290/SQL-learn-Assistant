# TOPIK 6: DOCKER + MYSQL (Integrasi dengan Project SQL Anda)

---

## 🎯 Tujuan
Menggabungkan skill Docker dengan skill SQL yang sudah Anda pelajari (Toko Online). Anda akan belajar cara **otomatis me-load file SQL (`setup.sql`)** saat database container pertama kali menyala.

---

## 1️⃣ MASALAH: "Database saya masih kosong pas baru jalan"

Di project `BLJRSQL` yang sudah Anda kerjakan, Anda punya folder `DATABASE_SETUP` yang berisi `setup.sql` (berisi table `produk`, `pelanggan`, dll beserta datanya).

Saat Anda melakukan `docker compose up -d` (seperti di Topik 5), container MySQL memang jalan. TAPI, databasenya **masih KOSONG**.

**Cara manual (Ribet):**
1. Masuk ke container: `docker exec -it mydb bash`
2. Buka MySQL shell, copy-paste isi `setup.sql` manual.

Apakah Backend Dev melakukan itu setiap hari? **TIDAK.**

---

## 2️⃣ SOLUSI: INITIALIZATION SCRIPTS (Auto-Load SQL)

Image resmi MySQL di Docker Hub memiliki sebuah fitur rahasia (magic feature):

> "Jika Anda meletakkan file `.sql` atau `.sh` ke dalam folder `/docker-entrypoint-initdb.d/` di dalam container, maka saat container PERTAMA KALI berjalan, MySQL akan **otomatis mengeksekusi (run)** semua script tersebut."

### Analogi: Instruksi Hari Pertama Kerja 📋

Bayangkan container MySQL adalah karyawan baru yang datang ke kantor (laptop Anda). 
Folder `/docker-entrypoint-initdb.d/` adalah **meja kerjanya**.
Jika Anda meletakkan kertas "Tugas Hari Pertama.sql" di meja itu, si karyawan akan langsung membacanya dan mengerjakannya tanpa perlu disuruh lagi.

---

## 3️⃣ BAGAIMANA CARA MELETAKKAN FILE-NYA KE MEJA KERJA?

Kita gunakan **Bind Mount** (Volume)! (Ingat materi Topik 4?).

Kita mount file `setup.sql` dari laptop kita ke folder magic tersebut di dalam container menggunakan `docker-compose.yml`.

### Contoh Penulisan `docker-compose.yml`:

```yaml
version: '3.8'

services:
  db_backend:
    image: mysql:8.0
    container_name: db_toko_sql
    ports:
      - "3306:3306"
    environment:
      MYSQL_ROOT_PASSWORD: password123
      # Kita minta MySQL buatkan DB kosong namanya 'toko_online'
      MYSQL_DATABASE: toko_online  
    volumes:
      - data-db-sql:/var/lib/mysql
      # INI MAGIC-NYA: Bind Mount file setup.sql ke folder magic MySQL
      # Asumsi file setup.sql ada di dalam folder yang sama dengan docker-compose.yml
      - ./setup.sql:/docker-entrypoint-initdb.d/init.sql

volumes:
  data-db-sql:
```

### Penjelasan Syntax Bind Mount File:
`- ./setup.sql:/docker-entrypoint-initdb.d/init.sql`
- Kiri (`./setup.sql`) = Path file di laptop Anda (titik slash artinya folder saat ini).
- Kanan (`/docker-.../init.sql`) = Path di dalam container. File tersebut akan ditaruh di sana dengan nama `init.sql`.

---

## 4️⃣ MENGAKSES DATABASE DARI HOST (LAPTOP ANDA)

Sekarang database sudah otomatis terisi. Pertanyaannya: **Bagaimana Anda (atau Backend App Anda yang jalan di IntelliJ/VS Code di laptop) konek ke database ini?**

Jawabannya: **Melalui PORT MAPPING!**

Ingat bagian `ports: - "3306:3306"`?
Artinya port `3306` laptop Anda diteruskan (di-forward) ke port `3306` container.

**Maka URL Koneksinya adalah:**
- Host: `localhost`
- Port: `3306`
- Username: `root`
- Password: `password123`
- DB Name: `toko_online`

Anda bisa memasukkan kredensial ini ke:
1. **DBeaver / DataGrip / MySQL Workbench** (Aplikasi GUI untuk query).
2. **`application.properties` (Java Spring Boot)** atau `.env` (Node.js).

---

> ✅ Lanjut ke **latihan.md** untuk langsung mempraktekkan auto-load database SQL Anda!
