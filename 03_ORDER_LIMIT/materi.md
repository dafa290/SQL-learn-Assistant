# TOPIK 3: ORDER BY + LIMIT + LIKE

## KONSEP POKOK
- `ORDER BY` = Urutkan hasil query (ascending/descending)
- `DESC` = Descending (terbesar/terbaru dulu)
- `ASC` = Ascending (terkecil/terlama dulu) - default
- `LIMIT` = Batasi jumlah baris yang ditampilkan
- `LIKE` = Pencarian pattern/wildcard untuk text

---

## SYNTAX

### ORDER BY
```sql
SELECT kolom FROM tabel ORDER BY kolom ASC|DESC;
```

### LIMIT
```sql
SELECT kolom FROM tabel LIMIT jumlah;
```

### LIKE
```sql
SELECT kolom FROM tabel WHERE kolom LIKE pattern;
```

---

## PENJELASAN SINGKAT

| Konsep | Penjelasan |
|--------|-----------|
| `ORDER BY kolom ASC` | Urutkan dari kecil ke besar (default) |
| `ORDER BY kolom DESC` | Urutkan dari besar ke kecil |
| `LIMIT 5` | Ambil maksimal 5 baris pertama |
| `LIMIT 5 OFFSET 10` | Ambil 5 baris mulai dari baris ke-11 (pagination) |
| `LIKE 'Ahmad%'` | Mulai dengan "Ahmad" |
| `LIKE '%ahmad%'` | Mengandung "ahmad" di mana saja |
| `LIKE '%ahmad'` | Berakhir dengan "ahmad" |

---

## CONTOH PRAKTIS

### 1️⃣ ORDER BY Ascending (Kecil ke Besar)
```sql
SELECT nama_produk, harga FROM produk ORDER BY harga ASC;
```
**Output**: Produk diurutkan harga termurah dulu
```
Webcam          500000
Headphone       750000
Monitor        1200000
Laptop        1500000
Keyboard       200000
```

---

### 2️⃣ ORDER BY Descending (Besar ke Kecil)
```sql
SELECT nama_produk, harga FROM produk ORDER BY harga DESC;
```
**Output**: Produk diurutkan harga termahal dulu
```
Laptop        1500000
Monitor        1200000
Headphone       750000
Webcam          500000
Keyboard        200000
```

---

### 3️⃣ ORDER BY dengan DATE (Terbaru Dulu)
```sql
SELECT nama_produk, tanggal_masuk FROM produk ORDER BY tanggal_masuk DESC;
```
**Output**: Produk berdasarkan tanggal masuk (paling baru dulu)
```
SSD Samsung    2025-03-01
Monitor LG     2025-02-15
Laptop Dell    2025-01-20
```

---

### 4️⃣ LIMIT - Ambil N Baris
```sql
SELECT nama_produk, harga FROM produk ORDER BY harga DESC LIMIT 3;
```
**Output**: Top 3 produk termahal
```
Laptop        1500000
Monitor        1200000
Headphone       750000
```

---

### 5️⃣ LIMIT + OFFSET - Pagination
```sql
SELECT nama_produk, harga FROM produk ORDER BY harga DESC LIMIT 3 OFFSET 3;
```
**Output**: Baris ke-4 sampai ke-6 (Page 2, 3 items per page)
```
Webcam          500000
Keyboard        200000
Mouse           150000
```

---

### 6️⃣ LIKE - Pencarian Sederhana
```sql
SELECT nama_produk FROM produk WHERE nama_produk LIKE '%phone%';
```
**Output**: Semua produk yang namanya mengandung "phone"
```
Headphone
Smartphone
```

---

### 7️⃣ LIKE - Mulai Dengan
```sql
SELECT nama_pelanggan FROM pelanggan WHERE nama_pelanggan LIKE 'Ahmad%';
```
**Output**: Nama yang mulai dengan "Ahmad"
```
Ahmad Hidayat
Ahmad Suryanto
```

---

### 8️⃣ LIKE - Case Insensitive
```sql
SELECT nama_produk FROM produk WHERE nama_produk LIKE '%laptop%';
```
**Output**: MySQL LIKE adalah case-INSENSITIVE secara default
```
Laptop Dell    (match: LIKE '%laptop%')
Sublaptop Pro  (match: LIKE '%laptop%')
```
**Catatan**: 'Laptop', 'laptop', 'LAPTOP' semua match!

---

## KOMBINASI: ORDER BY + LIMIT
```sql
SELECT nama_pelanggan, email FROM pelanggan 
WHERE kota = 'Jakarta' 
ORDER BY nama_pelanggan ASC 
LIMIT 5;
```
**Output**: 
- Filter kota Jakarta
- Urutkan nama A-Z
- Ambil 5 pertama

---

## KOMBINASI: WHERE + LIKE + ORDER BY + LIMIT
```sql
SELECT nama_produk, harga, tanggal_masuk FROM produk 
WHERE nama_produk LIKE '%phone%' 
ORDER BY tanggal_masuk DESC 
LIMIT 3;
```
**Output**:
- Cari produk dengan nama mengandung "phone"
- Urutkan dari terbaru
- Ambil 3 terbaru

---

## 🚀 USE CASE DI DUNIA NYATA (Backend)

### Kasus 1: List Top 10 Best Sellers
```sql
SELECT nama_produk, total_terjual FROM produk 
ORDER BY total_terjual DESC 
LIMIT 10;
```

### Kasus 2: Pagination - Users halaman 2 (10 per page)
```sql
SELECT username, email FROM users 
WHERE status = 'aktif'
ORDER BY created_at DESC 
LIMIT 10 OFFSET 10;  -- Page 2: rows 11-20
```

### Kasus 3: Search users by name
```sql
SELECT username, email FROM users 
WHERE nama_lengkap LIKE '%Ahmad%'
ORDER BY created_at DESC;
```

### Kasus 4: Pelanggan terbaru di kota tertentu
```sql
SELECT nama_pelanggan, email FROM pelanggan 
WHERE kota LIKE 'Jakarta%'
ORDER BY id DESC 
LIMIT 5;
```

---

## PENTING! ⚠️
- **ORDER BY default = ASC** (kalau tidak tulis DESC)
- **LIKE case-insensitive** (Ahmad = ahmad = AHMAD)
- **LIMIT saja** = batasi dari baris pertama
- **LIMIT + OFFSET** = pagination (mulai dari baris ke-X)
- **Urutan syntax**: SELECT → FROM → WHERE → ORDER BY → LIMIT
- **Di production**: SELALU gunakan ORDER BY + LIMIT untuk query besar (lebih cepat, hemat resource)

---

## NEXT STEP
📝 **Buka latihan.sql dan kerjakan 5 soal praktis!**
