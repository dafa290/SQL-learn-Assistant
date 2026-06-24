# TOPIK 6: JOIN - MULTI-TABLE QUERIES

---

## 🔑 PREREQUISITE: PRIMARY KEY & FOREIGN KEY

### Apa itu PRIMARY KEY?
- **PK** = unique identifier untuk setiap row dalam table
- Tidak boleh NULL, tidak boleh duplicate
- Contoh di database kita:
  - `pelanggan.id_pelanggan` = PK (setiap pelanggan punya ID unik: 1, 2, 3, etc.)
  - `produk.id_produk` = PK (setiap produk punya ID unik)
  - `pembelian.id_pembelian` = PK (setiap transaksi punya ID unik)

### Apa itu FOREIGN KEY?
- **FK** = column yang "reference" PK dari table lain
- Cara tabel saling terhubung
- Contoh:
  - `pembelian.id_pelanggan` = FK yang point ke `pelanggan.id_pelanggan`
  - Artinya: "Transaksi ini punya pelanggan ID berapa?"
  - `pembelian.id_produk` = FK yang point ke `produk.id_produk`
  - Artinya: "Transaksi ini beli produk ID berapa?"

### Bagaimana JOIN menggunakan PK & FK?

```
pembelian table:
- id_pelanggan = 1  ← FK (reference ke pelanggan.id_pelanggan)
- id_produk = 5     ← FK (reference ke produk.id_produk)

JOIN logic (ON clause):
"MATCH pembelian.id_pelanggan DENGAN pelanggan.id_pelanggan"
"MATCH pembelian.id_produk DENGAN produk.id_produk"
```

### Visualisasi:
```
pelanggan table                  pembelian table                produk table
id_pelanggan | nama_pelanggan    id_pembelian | id_pelanggan | id_produk    id_produk | nama_produk
1            | Budi     ←──────→ 1            | 1            | 1   ←──────→ 1         | Laptop
2            | Siti     ←──────→ 2            | 2            | 3   ←──────→ 3         | Keyboard
3            | Ahmad    ←──────→ 3            | 3            | 7   ←──────→ 7         | Headphone
```

**Kesimpulan**: 
- JOIN = "temukan row yang punya PK-FK match"
- ON clause = kondisi untuk match
- INNER JOIN = ambil yang match AJA
- LEFT/RIGHT JOIN = include yang tidak match juga

---

## 📌 NEW CONCEPT: Table Prefix Notation (tabel.kolom)

### Apa itu Table Prefix?
Saat JOIN, kita tulis column dengan prefix table-nya:
```sql
tabel1.kolom_name
tabel2.kolom_name
```

**Contoh:**
```sql
SELECT pelanggan.nama_pelanggan, pembelian.total_harga FROM ...
```
Bukan:
```sql
SELECT nama_pelanggan, total_harga FROM ...  -- ❌ Ambigu kalau banyak table
```

### Kenapa WAJIB pakai prefix di JOIN?

**Karena 2+ table bisa punya column dengan nama SAMA:**

```
pelanggan table:    pembelian table:
- id_pelanggan      - id_pelanggan  ← SAMA NAMA!
- nama_pelanggan    - total_harga
```

Kalau tulis tanpa prefix:
```sql
SELECT id_pelanggan FROM pelanggan
INNER JOIN pembelian ON ...;
-- ❌ MySQL: "id_pelanggan dari table mana? pelanggan atau pembelian?"
-- ERROR: ambiguous column name
```

**HARUS dengan prefix:**
```sql
SELECT pelanggan.id_pelanggan, pembelian.id_pelanggan FROM pelanggan
INNER JOIN pembelian ON ...;
-- ✅ CLEAR: ada 2 id_pelanggan columns, satu dari pelanggan, satu dari pembelian
```

### Best Practice (Even Recommended):
Bahkan jika nama kolomnya unik, tetap gunakan prefix untuk:
- ✅ Clarity - siapa column-nya? dari table mana?
- ✅ Safety - jika schema berubah di masa depan, query tetap aman
- ✅ Professional - standard industri

**KESIMPULAN:**
- Topik 1-5 (single table): Boleh tanpa prefix → `SELECT nama_pelanggan FROM pelanggan`
- Topik 6+ (JOIN, multi-table): HARUS pakai prefix → `SELECT pelanggan.nama_pelanggan, pembelian.id_pembelian`

---

## 📌 NEW CONCEPT: AS (Column Aliasing)

### Apa itu AS?
`AS` = **rename column** di hasil output (alias)

**Syntax:**
```sql
SELECT kolom AS nama_baru FROM tabel;
```   

**Contoh:**
```sql
SELECT id_pelanggan AS user_id FROM pelanggan;
```
Output akan tampil `user_id` bukan `id_pelanggan`

### Kenapa pakai AS?
- ✅ **Clarity ONLY** - output lebih mudah dibaca
- ✅ Terutama saat JOIN, banyak kolom dari table berbeda
- ✅ Jika ada 2 kolom ID yang mirip (misalnya `id_pelanggan` dari tabel pelanggan & `id_pelanggan` dari tabel pembelian), tanpa AS jadi kurang deskriptif di output:
  - **Tanpa AS**: `id_pelanggan | id_pembelian`
  - **Dengan AS**: `pelanggan_id | transaksi_id` (jelas!)

### Important Clarification:
- ❌ AS **BUKAN wajib** - query tetap jalan tanpa AS
- ✅ AS **HANYA untuk rename** output saja, tabel asli tidak berubah
- ✅ AS adalah **best practice** untuk clarity (terutama multi-table queries)

**Contoh perbandingan:**
```sql
-- Tanpa AS (bisa jalan, tapi output kurang jelas):
SELECT pelanggan.id_pelanggan, pembelian.id_pembelian FROM pelanggan
INNER JOIN pembelian ON ...;
-- Output: id_pelanggan | id_pembelian
peh.pelan
-- Dengan AS (lebih jelas untuk reporting):
SELECT pelanggan.id_pelanggan AS pelanggan_id, pembelian.id_pembelian AS transaksi_id 
FROM pelanggan INNER JOIN pembelian ON ...;
-- Output: pelanggan_id | transaksi_id ← Clear!
```

---

## 📌 NEW CONCEPT: ON Clause (JOIN Condition)

### Apa itu ON?
`ON` = **kondisi untuk match** row dari 2 tabel saat JOIN

Syntax:
```sql
JOIN tabel2 ON tabel1.kolom = tabel2.kolom
```

### Kenapa perlu ON?
Tanpa ON, MySQL tidak tahu: "Gimana cara match row dari tabel1 dengan tabel2?"

**Contoh:**
```sql
-- ❌ SALAH (no ON, ambiguous):
SELECT * FROM pelanggan INNER JOIN pembelian;
-- ERROR: Cannot join without condition!

-- ✅ BENAR (with ON):
SELECT * FROM pelanggan 
INNER JOIN pembelian ON pelanggan.id_pelanggan = pembelian.id_pelanggan;
-- Clear: "Match pelanggan.id_pelanggan dengan pembelian.id_pelanggan"
```

### Bagaimana ON bekerja step-by-step?

**Data:**
```
pelanggan table:
id_pelanggan | nama_pelanggan
1            | Budi
2            | Siti

pembelian table:
id_pembelian | id_pelanggan | total_harga
10           | 1            | 100000
11           | 2            | 200000
```

**Query:**
```sql
SELECT pelanggan.nama_pelanggan, pembelian.total_harga
FROM pelanggan
INNER JOIN pembelian ON pelanggan.id_pelanggan = pembelian.id_pelanggan;
```

**Proses (step-by-step):**
1. Ambil row pertama pelanggan: `id_pelanggan=1, nama_pelanggan=Budi`
2. Cari di pembelian WHERE `id_pelanggan = 1` (ON condition)
3. Ditemukan: `pembelian.id_pembelian=10, id_pelanggan=1, total_harga=100000`
4. **MATCH!** Combine jadi: `Budi | 100000`
5. Ulangi untuk pelanggan berikutnya

**Output:**
```
nama_pelanggan | total_harga
Budi           | 100000
Siti           | 200000
```

### ON dengan PK-FK Relationship

**Best Practice:** ON biasanya match PK dengan FK:
```sql
ON pelanggan.id_pelanggan = pembelian.id_pelanggan
   ↑ PK (primary key)      ↑ FK (foreign key)
```
Ini adalah relationship yang sudah didefined saat CREATE TABLE.

### ON vs WHERE (Jangan bingung!)
Keduanya filter, tapi berbeda timing:
```sql
-- ON = filter SAAT JOIN (early filter)
FROM pelanggan
INNER JOIN pembelian ON pelanggan.id_pelanggan = pembelian.id_pelanggan
INNER JOIN produk ON pembelian.id_produk = produk.id_produk

-- WHERE = filter SETELAH JOIN (late filter)
WHERE pembelian.total_harga > 1000000;
```
**Praktiknya:**
- ON = untuk match relationship (PK-FK)
- WHERE = untuk business logic filter (harga > 1000000)

---

## KONSEP POKOK
- `JOIN` = Gabungkan data dari 2+ tabel berdasarkan relasi/kondisi
- `INNER JOIN` = Ambil data yang match di KEDUA tabel
- `LEFT JOIN` = Ambil SEMUA dari tabel kiri + yang match dari tabel kanan
- `RIGHT JOIN` = Ambil SEMUA dari tabel kanan + yang match dari tabel kiri
- Foreign Key = Penghubung antar tabel (`id_pelanggan`, `id_produk`, dll)

---

## SYNTAX

### INNER JOIN
```sql
SELECT kolom FROM tabel1
INNER JOIN tabel2 ON tabel1.id_tabel1 = tabel2.id_tabel1;
```

### LEFT JOIN
```sql
SELECT kolom FROM tabel1
LEFT JOIN tabel2 ON tabel1.id_tabel1 = tabel2.id_tabel1;
```

### RIGHT JOIN
```sql
SELECT kolom FROM tabel1
RIGHT JOIN tabel2 ON tabel1.id_tabel1 = tabel2.id_tabel1;
```

---

## PENJELASAN SINGKAT

| Jenis Join | Deskripsi | Kegunaan |
|-----------|-----------|---------|
| `INNER JOIN` | Hanya data yang match di kedua tabel | Data lengkap dengan relasi (PALING SERING) |
| `LEFT JOIN` | Semua dari tabel kiri + match dari kanan | Include data tanpa relasi dari tabel kiri |
| `RIGHT JOIN` | Semua dari tabel kanan + match dari kiri | Include data tanpa relasi dari tabel kanan |

---

## DATABASE STRUKTUR (toko_online)

```
pelanggan table:
- id_pelanggan (Primary Key)
- nama_pelanggan
- email
- kota
- no_telp

pembelian table:
- id_pembelian (Primary Key)
- id_pelanggan (Foreign Key → pelanggan.id_pelanggan)
- id_produk (Foreign Key → produk.id_produk)
- jumlah
- total_harga
- tanggal_beli

produk table:
- id_produk (Primary Key)
- nama_produk
- kategori
- harga
- stok
- tanggal_masuk
```

---

## CONTOH PRAKTIS

### 1️⃣ INNER JOIN - Ambil Pelanggan + Pembelian Mereka
```sql
SELECT 
    pelanggan.nama_pelanggan, 
    pelanggan.email,
    pembelian.id_pembelian AS pembelian_id,
    pembelian.total_harga
FROM pelanggan
INNER JOIN pembelian ON pelanggan.id_pelanggan = pembelian.id_pelanggan;
```
**Output**: Hanya pelanggan yang ada pembelian
```
Budi Santoso     | budi@email.com      | 1    | 8000000
Siti Nurhaliza   | siti@email.com      | 2    | 1500000
Ahmad Hidayat    | ahmad@email.com     | 3    | 1200000
```

---

### 2️⃣ INNER JOIN - 3 TABEL (Pelanggan + Pembelian + Produk)
```sql
SELECT 
    pelanggan.nama_pelanggan,
    produk.nama_produk,
    pembelian.jumlah,
    pembelian.total_harga
FROM pelanggan
INNER JOIN pembelian ON pelanggan.id_pelanggan = pembelian.id_pelanggan
INNER JOIN produk ON pembelian.id_produk = produk.id_produk;
```
**Output**: Data lengkap siapa beli apa
```
Budi Santoso     | Laptop Dell     | 1 | 8000000
Siti Nurhaliza   | Keyboard Mech   | 2 | 1500000
Ahmad Hidayat    | Headphone Sony  | 1 | 1200000
```

---

### 3️⃣ LEFT JOIN - Semua Pelanggan + Pembelian (atau NULL)
```sql
SELECT 
    pelanggan.nama_pelanggan,
    pelanggan.email,
    pembelian.id_pembelian AS pembelian_id,
    pembelian.total_harga
FROM pelanggan
LEFT JOIN pembelian ON pelanggan.id_pelanggan = pembelian.id_pelanggan;
```
**Output**: Semua pelanggan, bahkan yang belum beli
```
Budi Santoso     | budi@email.com      | 1      | 8000000
Siti Nurhaliza   | siti@email.com      | 2      | 1500000
Ahmad Hidayat    | ahmad@email.com     | 3      | 1200000
Dewi Lestari     | dewi@email.com      | 5      | 1500000
Roni Hermawan    | roni@email.com      | 7      | 600000
Lisa Manobal     | lisa@email.com      | 8      | 600000
Sari Wijaya      | sari@email.com      | 12     | 350000
```
*(Catatan: Jika ada pelanggan yang benar-benar tidak membeli sama sekali, kolom `pembelian_id` dan `total_harga` akan bernilai `NULL`)*

---

### 4️⃣ RIGHT JOIN - Semua Pembelian + Pelanggan (atau NULL)
```sql
SELECT 
    pelanggan.nama_pelanggan,
    pembelian.id_pembelian AS pembelian_id,
    pembelian.total_harga
FROM pelanggan
RIGHT JOIN pembelian ON pelanggan.id_pelanggan = pembelian.id_pelanggan;
```

---

### 5️⃣ JOIN + WHERE - Filter setelah join
```sql
SELECT 
    pelanggan.nama_pelanggan,
    pembelian.total_harga,
    pembelian.tanggal_beli
FROM pelanggan
INNER JOIN pembelian ON pelanggan.id_pelanggan = pembelian.id_pelanggan
WHERE pembelian.total_harga > 1000000
ORDER BY pembelian.tanggal_beli DESC;
```

---

## 🚀 USE CASE DI DUNIA NYATA (Backend)

### Kasus 1: List semua pembelian dengan nama pelanggan
```sql
SELECT 
    pembelian.id_pembelian,
    pelanggan.nama_pelanggan,
    produk.nama_produk,
    pembelian.jumlah,
    pembelian.total_harga
FROM pembelian
INNER JOIN pelanggan ON pembelian.id_pelanggan = pelanggan.id_pelanggan
INNER JOIN produk ON pembelian.id_produk = produk.id_produk
ORDER BY pembelian.tanggal_beli DESC;
```
**Backend use**: API endpoint untuk list transaksi lengkap

### Kasus 2: Pelanggan mana yang belum pernah beli?
```sql
SELECT 
    pelanggan.nama_pelanggan,
    pelanggan.email
FROM pelanggan
LEFT JOIN pembelian ON pelanggan.id_pelanggan = pembelian.id_pelanggan
WHERE pembelian.id_pembelian IS NULL;
```
**Backend use**: Marketing - kirim email promo ke customer potensial yang belum belanja

### Kasus 3: Semua transaksi untuk kategori produk tertentu
```sql
SELECT 
    pelanggan.nama_pelanggan,
    produk.nama_produk,
    produk.kategori,
    pembelian.total_harga,
    pembelian.tanggal_beli
FROM pembelian
INNER JOIN pelanggan ON pembelian.id_pelanggan = pelanggan.id_pelanggan
INNER JOIN produk ON pembelian.id_produk = produk.id_produk
WHERE produk.kategori = 'Elektronik'
ORDER BY pembelian.total_harga DESC;
```
**Backend use**: Filter dan display transaksi berdasarkan kategori produk

---

## PENTING! ⚠️
- **ON clause** = kondisi join (biasanya match primary key dengan foreign key)
- **INNER JOIN**: Data harus ada di kedua tabel (relasi harus match)
- **LEFT JOIN**: Pertahankan semua data dari tabel kiri (meskipun tidak ada pasangan di kanan)
- **NULL values**: Muncul di LEFT/RIGHT JOIN ketika tidak ada kecocokan relasi
- **WHERE NULL check**: `WHERE tabel_kanan.id_pembelian IS NULL` digunakan untuk mencari records yang tidak punya relasi
- **Multiple JOINs**: Dapat menggabungkan 3+ tabel sekaligus dengan menuliskan keyword `JOIN ... ON ...` berurutan
- **Performance**: Query JOIN jauh lebih cepat dibanding query satu-satu secara terpisah (menghindari masalah performa N+1 query)

---

## NEXT STEP
📝 **Buka latihan.sql dan kerjakan 5 soal praktis!**
