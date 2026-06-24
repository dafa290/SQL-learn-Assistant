# 📚 KEY CONCEPTS SUMMARY

**Purpose**: Ringkasan konsep penting untuk diingat di pekerjaan.

---

## ⭐ TOP 5 RULES FOR BACKEND DEVELOPERS

### Rule 1: Always SELECT Specific Columns
```sql
❌ SELECT * FROM products;          -- NEVER in production
✅ SELECT id, name, price FROM products;  -- ALWAYS
```
**Why**: Performance, security, clarity

---

### Rule 2: Always Use WHERE in UPDATE/DELETE
```sql
❌ UPDATE users SET status = 'active';           -- DANGER!
✅ UPDATE users SET status = 'active' WHERE id = 1;  -- SAFE
```
**Why**: Prevent accidental mass update/delete

---

### Rule 3: Text = Single Quotes, Numbers = No Quotes
```sql
✅ WHERE kategori = 'Elektronik'     -- text
✅ WHERE harga = 500000             -- number
❌ WHERE kategori = Elektronik       -- WRONG
❌ WHERE harga = '500000'            -- works but confusing
```
**Why**: SQL type system clarity

---

### Rule 4: Use AND/OR Carefully (Precedence!)
```sql
❌ WHERE kategori = 'A' OR kategori = 'B' AND harga > 1000
   -- means: (kategori = 'A') OR (kategori = 'B' AND harga > 1000)
   
✅ WHERE (kategori = 'A' OR kategori = 'B') AND harga > 1000
   -- means: (kategori = 'A' OR kategori = 'B') AND harga > 1000
```
**Why**: AND has higher precedence than OR

---

### Rule 5: Use LIMIT for Pagination
```sql
❌ SELECT * FROM users;  -- load all users = memory issue
✅ SELECT * FROM users LIMIT 10 OFFSET 0;  -- page 1, 10 per page
```
**Why**: Better performance, memory management

---

## 🔄 CRUD OPERATIONS AT A GLANCE

| Operation | SQL | Use Case |
|-----------|-----|----------|
| **CREATE (INSERT)** | `INSERT INTO users VALUES (...)` | Register user, create order |
| **READ (SELECT)** | `SELECT FROM users WHERE ...` | Fetch user data, list items |
| **UPDATE** | `UPDATE users SET col=val WHERE id=X` | Update profile, change status |
| **DELETE** | `DELETE FROM users WHERE id=X` | Remove user (hard delete) |
| **SOFT DELETE** | `UPDATE users SET status='inactive'` | Deactivate account (keep history) |

---

## 🔗 RELATIONSHIP TYPES

| Type | Symbol | Example | SQL |
|------|--------|---------|-----|
| One-to-Many | 1 ─── * | User ─ Orders | Foreign Key in orders table |
| Many-to-Many | * ─── * | Users ─ Roles | Junction table |
| One-to-One | 1 ─── 1 | User ─ Profile | FK with UNIQUE constraint |

---

## 🎯 COMMON BACKEND QUERIES

### 1. List Users (with pagination)
```sql
SELECT id, username, email FROM users 
WHERE status = 'aktif' 
ORDER BY created_at DESC 
LIMIT 10 OFFSET 0;
```

### 2. Get User by ID
```sql
SELECT * FROM users WHERE id = ?;
```

### 3. Search Users
```sql
SELECT * FROM users 
WHERE username LIKE ? OR email LIKE ?;
```

### 4. Create User
```sql
INSERT INTO users (username, email, password) 
VALUES (?, ?, ?);
```

### 5. Update User
```sql
UPDATE users 
SET email = ?, updated_at = CURRENT_TIMESTAMP 
WHERE id = ?;
```

### 6. Soft Delete User
```sql
UPDATE users SET status = 'inactive' 
WHERE id = ?;
```

### 7. Complex Query (multi-table)
```sql
SELECT u.username, o.id AS order_id, o.total 
FROM users u 
JOIN orders o ON u.id = o.user_id 
WHERE u.status = 'aktif' 
ORDER BY o.created_at DESC;
```

---

## ✋ SAFETY CHECKLIST

- [ ] Query punya WHERE clause? (untuk SELECT filter, UPDATE/DELETE safety)
- [ ] Menggunakan specific columns? (bukan SELECT *)
- [ ] Text data pakai quotes? (dan number tidak?)
- [ ] AND/OR pakai parentheses? (untuk clarity)
- [ ] LIMIT untuk pagination? (untuk performance)
- [ ] Mau hard atau soft delete? (soft di production preferrable)

---

**Last Updated**: 2026-06-12
