# TOPIK 2: WHERE - FILTER DATA

## KONSEP POKOK
`WHERE` = Filter data berdasarkan kondisi spesifik.
Hanya baris yang memenuhi kondisi yang ditampilkan.

---

## SYNTAX
```sql
SELECT kolom FROM nama_tabel WHERE kondisi;
```

---

## PENJELASAN SINGKAT

| Operator | Arti | Contoh |
|----------|------|--------|
| `=` | Sama dengan | `harga = 1500000` |
| `>` | Lebih besar | `harga > 500000` |
| `<` | Lebih kecil | `harga < 500000` |
| `>=` | Lebih besar/sama | `harga >= 500000` |
| `<=` | Lebih kecil/sama | `harga <= 500000` |
| `!=` atau `<>` | Tidak sama | `kategori != 'Elektronik'` |
| `AND` | Kedua kondisi harus terpenuhi | `harga > 500000 AND stok > 10` |
| `OR` | Salah satu kondisi terpenuhi | `kategori = 'Elektronik' OR kategori = 'Audio'` |

---

## CONTOH PRAKTIS

### 1️⃣ WHERE dengan Perbandingan
```sql
SELECT * FROM produk WHERE harga > 500000;
```
**Output**: Hanya produk dengan harga lebih dari 500.000

---

### 2️⃣ WHERE dengan Teks (String)
```sql
SELECT * FROM produk WHERE kategori = 'Elektronik';
```
**Output**: Hanya produk kategori Elektronik (perhatian: gunakan `'` untuk text)

---

### 3️⃣ WHERE dengan AND (Kedua kondisi harus terpenuhi)
```sql
SELECT * FROM produk WHERE kategori = 'Aksesori' AND harga < 500000;
```
**Output**: Aksesori dengan harga kurang dari 500.000

---

### 4️⃣ WHERE dengan OR (Salah satu kondisi)
```sql
SELECT nama_pelanggan, email FROM pelanggan WHERE kota = 'Jakarta' OR kota = 'Surabaya';
```
**Output**: Pelanggan dari Jakarta atau Surabaya

---

### 5️⃣ WHERE dengan AND (Multiple Kondisi)
```sql
SELECT nama_produk, kategori, harga FROM produk WHERE kategori = 'Elektronik' AND harga < 1500000;
```
**Output**: Produk elektronik dengan harga kurang dari 1.5 juta (Webcam, Headphone)

---

## 🚀 ADVANCED: Kombinasi AND + OR (Optional)

**Jika Anda ingin belajar sekarang:**

```sql
SELECT * FROM pembelian 
WHERE (jumlah > 1 AND total_harga > 1000000) OR id_pelanggan = 1;
```

**Penjelasan Logika**:
```
Ambil pembelian JIKA salah satu kondisi terpenuhi:

KONDISI A: (jumlah > 1 AND total_harga > 1000000)
           = pembelian dengan jumlah >1 DAN total >1 juta

ATAU

KONDISI B: id_pelanggan = 1
           = pembelian dari pelanggan ID 1
```

**Kenapa perlu `()`?**
- AND memiliki precedence lebih tinggi dari OR
- Tanpa `()`: `WHERE A AND B OR C` = `(A AND B) OR C` (ambiguous!)
- Dengan `()`: Jelas intent Anda

**Result**: 
- Baris 1 (id_pelanggan=1) ✅ match kondisi B
- Baris 2 (jumlah=2, total=1.5jt) ✅ match kondisi A
- Baris 4 (id_pelanggan=1) ✅ match kondisi B

**Tips**: Saat ada kombinasi AND/OR, **selalu gunakan parentheses** untuk clarity, bahkan jika technically tidak diperlukan.

*(Advanced topic ini akan dilatih di Topik 4 & Project. Untuk sekarang, focus pada soal 1-5 dasar dulu.)*

---

## KAPAN DIPAKAI?
- Cari produk tertentu (by harga, kategori, stok)
- Cari pelanggan dari kota tertentu
- Cari transaksi dengan kondisi spesifik
- **Di pekerjaan**: WAJIB digunakan untuk query production (hemat resource, cepat)

---

## PENTING! ⚠️
- **Untuk text**: Gunakan `'` (single quote) → `WHERE kategori = 'Elektronik'`
- **Untuk angka**: TIDAK perlu `'` → `WHERE harga = 500000`
- **AND/OR**: Perhatikan urutan (AND dijalankan terlebih dahulu, gunakan `()` untuk jelas)

---

## NEXT STEP
📝 **Coba kerjakan soal di latihan.sql**

> Topik 2 ada 5 soal yang cukup menantang. Pahami konsep di atas dulu, baru buka latihan!
