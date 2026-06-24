# PROJECT 1: CRUD USER MANAGEMENT

## 🎯 SKENARIO BISNIS

Anda sedang membuat **Backend REST API untuk User Management System**. 

Aplikasi ini perlu:
- ✅ Register user baru
- ✅ Lihat data user tertentu
- ✅ Update profil user (email, password, status)
- ✅ Delete user (deactivate account)
- ✅ List semua user aktif dengan filter

---

## 📊 SCHEMA DATABASE

Anda perlu 1 tabel: `users`

```sql
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,           -- di real: encrypted!
    nama_lengkap VARCHAR(100),
    status ENUM('aktif', 'inactive') DEFAULT 'aktif',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

---

## 🔧 ENDPOINT BACKEND + SQL MAPPING

| No | Endpoint | Method | SQL Query | Tujuan |
|----|----------|--------|-----------|--------|
| 1 | `POST /users` | POST | INSERT | Register user baru |
| 2 | `GET /users/{id}` | GET | SELECT | Lihat data user |
| 3 | `GET /users` | GET | SELECT (with filter) | List users aktif |
| 4 | `PUT /users/{id}` | PUT | UPDATE | Update profil user |
| 5 | `DELETE /users/{id}` | DELETE | DELETE | Hapus user (soft/hard) |

---

## 💡 IMPORTANT NOTE

- **Real world**: DELETE user biasanya SOFT DELETE (update status = 'inactive'), bukan hard delete
- **Kita akan praktik BOTH**: soft delete (UPDATE) dan hard delete (DELETE)

---

## 🎓 APA YANG AKAN DIPELAJARI?

1. **SELECT** - Query data dengan filter, sorting
2. **INSERT** - Tambah user baru
3. **UPDATE** - Update profil (soft delete included)
4. **DELETE** - Hapus user (hard delete)
5. **WHERE + ORDER + LIMIT** - Kombinasi untuk list paginated

---

**Next**: Buka `tasks.sql` dan kerjakan sesuai instruksi!
