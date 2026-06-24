# TOPIK 5: UPDATE + DELETE

Backend sering butuh **modify data** (UPDATE) dan **hapus data** (DELETE).
Topik ini mengajarkan keduanya dengan **production pattern** (soft delete vs hard delete).

---

## 1. UPDATE SYNTAX

**Fungsi**: Mengubah data yang sudah ada

### Basic Syntax
```sql
UPDATE nama_tabel
SET column1 = value1, column2 = value2, ...
WHERE condition;
```

### ⚠️ CRITICAL: WHERE clause wajib!
- **TANPA WHERE** → Update SEMUA row (ERROR!)
- **DENGAN WHERE** → Update hanya row yg match

### Contoh 1: Update 1 column
```sql
UPDATE inventori
SET jumlah_stok = 75
WHERE id = 1;
```
✅ Update hanya row id=1, jumlah_stok jadi 75

### Contoh 2: Update multiple columns
```sql
UPDATE categories
SET nama_kategori = 'Elektronik Premium', created_at = NOW()
WHERE id = 1;
```
✅ Ubah nama dan timestamp sekaligus

### Contoh 3: Update dengan WHERE AND
```sql
UPDATE inventori
SET jumlah_stok = 0
WHERE id_produk = 2 AND lokasi = 'Gudang B';
```
✅ Update hanya di Gudang B untuk produk id=2

### Contoh 4: Update dengan arithmetic
```sql
UPDATE inventori
SET jumlah_stok = jumlah_stok - 10
WHERE id = 3;
```
✅ Kurangi stok (current - 10). Berguna untuk transaksi!

### Contoh 5: Update dengan calculated value
```sql
UPDATE inventori
SET updated_at = CURRENT_TIMESTAMP, jumlah_stok = jumlah_stok + 5
WHERE lokasi = 'Gudang A';
```
✅ Update Gudang A: tambah stok + set updated_at ke sekarang (audit trail)

---

## 2. DELETE SYNTAX

**Fungsi**: Hapus data dari database

### Basic Syntax
```sql
DELETE FROM nama_tabel
WHERE condition;
```

### ⚠️ CRITICAL: WHERE clause wajib!
- **TANPA WHERE** → Hapus SEMUA row (FATAL ERROR!)
- **DENGAN WHERE** → Hapus hanya row yg match

### Contoh 1: Delete 1 row
```sql
DELETE FROM categories
WHERE id = 5;
```
✅ Hapus kategori id=5 saja

### Contoh 2: Delete multiple rows
```sql
DELETE FROM inventori
WHERE jumlah_stok = 0;
```
✅ Hapus semua inventori dengan stok 0

### Contoh 3: Delete dengan AND
```sql
DELETE FROM inventori
WHERE lokasi = 'Gudang C' AND jumlah_stok < 10;
```
✅ Hapus barang di Gudang C dengan stok kecil

---

## 3. SOFT DELETE vs HARD DELETE (PRODUCTION PATTERN)

Backend production jarang hard delete. Kenapa? **Audit trail + data history!**

### HARD DELETE (⚠️ Tidak boleh sembarangan)
```sql
DELETE FROM categories WHERE id = 5;
```
- Data hilang permanent
- Tidak bisa recover
- Kasusnya: temporary data, spam, etc.

### SOFT DELETE (✅ Recommended untuk business data)
```sql
UPDATE categories
SET status = 'inactive'
WHERE id = 5;
```
- Data masih ada di database
- Hanya ditandai "inactive" atau "deleted"
- Bisa recover kapan saja
- Query: `SELECT * FROM categories WHERE status = 'active'`

### Pattern: Soft Delete
Kebanyakan production table punya `status` column:
```sql
CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nama_kategori VARCHAR(50),
    status ENUM('active', 'inactive') DEFAULT 'active',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    deleted_at DATETIME DEFAULT NULL
);
```

**Soft Delete Query**:
```sql
UPDATE categories
SET status = 'inactive', deleted_at = CURRENT_TIMESTAMP
WHERE id = 5;
```

**Get Active Data Only**:
```sql
SELECT * FROM categories WHERE status = 'active';
```

**Get Deleted Data (untuk audit)**:
```sql
SELECT * FROM categories WHERE status = 'inactive';
```

---

## 4. BEST PRACTICES

### ✅ DO:
1. **Always use WHERE** - hindari akidental update/delete all
2. **Test first dengan SELECT** - sebelum UPDATE/DELETE, test WHERE condition dulu
3. **Use LIMIT** - kalau data besar, batasi
4. **Prefer SOFT DELETE** - untuk business data
5. **Log changes** - audit trail penting

### ❌ DON'T:
1. **DELETE tanpa WHERE** - FATAL!
2. **UPDATE complex logic tanpa SELECT test** - risky
3. **Hard delete business data** - tidak bisa recovery
4. **Forget timestamp** - audit trail hilang

### Safe Practice
```sql
-- STEP 1: Test dengan SELECT dulu
SELECT * FROM inventori WHERE lokasi = 'Gudang C';

-- STEP 2: Kalau cocok, baru UPDATE/DELETE
UPDATE inventori SET status = 'inactive' WHERE lokasi = 'Gudang C';

-- STEP 3: Verify
SELECT * FROM inventori WHERE lokasi = 'Gudang C';
```

---

## 5. REAL BACKEND SCENARIOS

### Scenario 1: E-commerce "Hapus" Produk
```sql
-- User klik "Delete" di admin panel
-- Backend jalanin:
UPDATE produk SET status = 'inactive' WHERE id = 123;

-- Produk hilang dari katalog customer (SELECT * WHERE status='active')
-- Tapi data masih ada untuk audit & return processing
```

### Scenario 2: Inventory "Pickup" Barang
```sql
-- Barang diambil dari gudang
UPDATE inventori 
SET jumlah_stok = jumlah_stok - 5, updated_at = CURRENT_TIMESTAMP
WHERE id_produk = 10 AND lokasi = 'Gudang A';
```

### Scenario 3: Restock Supply
```sql
-- Supply baru datang
UPDATE inventori
SET jumlah_stok = jumlah_stok + 100, updated_at = CURRENT_TIMESTAMP
WHERE id_produk = 5 AND lokasi = 'Gudang B';
```

---

## 📝 RINGKASAN

| Operation | Syntax | Bahaya | Use Case |
|-----------|--------|--------|----------|
| **UPDATE** | `UPDATE tbl SET col=val WHERE cond` | Ubah banyak row | Modify data |
| **HARD DELETE** | `DELETE FROM tbl WHERE cond` | Permanent loss | Temp data |
| **SOFT DELETE** | `UPDATE tbl SET status='inactive'` | None | Business data |
| **Verify Update** | `SELECT * WHERE cond` (test dulu) | - | Safety check |

---

**KUNCI**: UPDATE dan DELETE selalu pakai WHERE. Kalau ragu, test dengan SELECT dulu!
