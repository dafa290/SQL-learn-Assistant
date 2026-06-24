# TOPIK 1: SELECT DASAR

## KONSEP POKOK
`SELECT` = Mengambil/menampilkan data dari tabel.
`FROM` = Dari tabel mana data diambil.

---

## SYNTAX
```sql
SELECT kolom1, kolom2 FROM nama_tabel;
```

---

## PENJELASAN SINGKAT

| Bagian | Fungsi |
|--------|--------|
| `SELECT` | Pilih kolom mana yang ditampilkan |
| `FROM` | Tabel mana yang digunakan |
| `*` (asterisk) | Ambil SEMUA kolom |

---

## CONTOH PRAKTIS

### 1️⃣ SELECT Semua Kolom
```sql
SELECT * FROM produk;
```
**Output**: Tampil semua kolom dari tabel produk (id_produk, nama_produk, kategori, harga, stok, tanggal_masuk)

---

### 2️⃣ SELECT Kolom Spesifik
```sql
SELECT nama_produk, harga FROM produk;
```
**Output**: Hanya tampil nama_produk dan harga (kolom lain tidak ditampilkan)

---

### 3️⃣ SELECT Multiple Kolom
```sql
SELECT id_produk, nama_produk, kategori, harga FROM produk;
```
**Output**: 4 kolom ditampilkan sesuai urutan yang ditulis

---

## KAPAN DIPAKAI?
- **SELECT *** → Lihat semua data tanpa tahu struktur tabel
- **SELECT kolom tertentu** → Ambil data spesifik, hemat resource (lebih cepat)
- Di pekerjaan: **SELALU pilih kolom spesifik**, jangan `*` (lebih efficient)

---

## NEXT STEP
📝 **Coba kerjakan soal di file latihan (latihan.sql)**

> Buka latihan.sql → ikuti instruksi → tulis query di bawah soal → simpan file

