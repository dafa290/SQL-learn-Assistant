# 🚨 MISTAKES & MISCONCEPTIONS LOG

**Purpose**: Track common mistakes dan misconceptions untuk reteach dan prevention.

---

## TEMPLATE SETIAP ENTRY

```
### Mistake #X: [Judul]
**Topik**: [topik berapa]
**Kesalahan**: [apa yang salah]
**Root Cause**: [kenapa sampai salah?]
**Correct Approach**: [cara yang benar]
**Prevention**: [ingat ini supaya tidak terulang]
```

---

## ENTRY LOG

*(Akan di-update setiap ada mistake)*

### Mistake #0: AI ASSUMPTION ERRORS - SESSION 3 (2026-06-14)

**Three critical mistakes caught by user:**

#### 0.1: LOWER() Function Not in Curriculum
**Context**: PROJECT 1 Task 3 (SEARCH users by name)
**Kesalahan**: Used `WHERE LOWER(nama_lengkap) LIKE LOWER('%ahmad%')`
**Root Cause**: AI tried to provide "cleaner" solution without checking if LOWER() was taught
**Why Wrong**: LOWER() is NOT in Topik 1-5. Violates "NO SURPRISE CONCEPTS" rule
**Correct Approach**: Use `WHERE nama_lengkap LIKE '%ahmad%'` (already taught in Topik 3)
**Prevention**: BEFORE using ANY SQL function/syntax in soal, verify it's in the materi.md first. Do not assume knowledge.

#### 0.2: Unnecessary OR Condition
**Context**: Same Task 3 after user challenged LOWER()
**Kesalahan**: Suggested `WHERE nama_lengkap LIKE '%Ahmad%' OR nama_lengkap LIKE '%ahmad%'`
**Root Cause**: AI didn't know MySQL LIKE is case-insensitive by default
**Why Wrong**: Redundant - one condition is sufficient, violates DRY principle
**Correct Approach**: `WHERE nama_lengkap LIKE '%ahmad%'` (case-insensitive by default)
**Prevention**: Know language defaults (MySQL LIKE, PostgreSQL ILIKE, etc) before adding conditions

#### 0.3: AS (Alias) Not Taught - False Claim
**Context**: Topik 6 materi.md - explaining JOIN concepts
**Kesalahan**: Claimed "AS already taught in Topik 1" but actually NOT taught anywhere
**Root Cause**: AI made assumption without verifying by reading actual Topik 1 materi.md
**Why Wrong**: AS is not in any Topik 1-5, so claiming it's prerequisite knowledge is WRONG
**User Challenge**: "dimana coba beri tahu sy kalo sy pernah belajar as" - User demanded proof
**Action**: Verified by grep_search - AS not in any materi. User was right.
**Fix**: Added NEW CONCEPT section to Topik 6 materi.md explaining AS before using it
**Prevention**: NEVER claim "already taught" without verifying. When user challenges, ALWAYS verify immediately.

#### 0.4: Table Prefix Notation Without Explanation (NEW - CAUGHT BY USER!)
**Context**: Topik 6 materi.md - used `pelanggan.id`, `pembelian.total_harga` throughout
**Kesalahan**: Used `tabel.kolom` notation in all examples WITHOUT explaining what it is or WHY
**Root Cause**: AI assumed notation was "obvious" or explained verbally in explanation, but NOT in materi.md
**Why Wrong**: User never seen this notation before (new in Topik 6), so it's SURPRISE CONCEPT again
**User Challenge**: "kenapa penulisannya menjadi namatabel.kolom, kenapa gitu" - User asked for explanation
**When Explained**: AI provided good explanation in response, BUT should have been IN MATERI FIRST
**Lesson**: Just because AI *can* explain something doesn't mean it's in the materi. Materi must be self-contained.
**Fix**: Added NEW CONCEPT section "Table Prefix Notation (tabel.kolom)" to materi.md BEFORE using it in examples
**Prevention**: 
- AUDIT every syntax notation used in materi
- If notation appears without prior explanation = add NEW CONCEPT section first
- Materi must be self-contained - user shouldn't need verbal explanation to understand written materi

**Key Learning**: 
Verbal explanation ≠ Materi documentation. If user asks "kenapa gitu", it means it's not explained in materi. Add it to materi immediately.

#### 0.5: ON Clause Used Before Explanation (CAUGHT BY USER!)
**Context**: Topik 6 materi.md - used ON in SYNTAX section before explaining ON
**Kesalahan**: SYNTAX section had `ON tabel1.id = tabel2.id_tabel1` without prior ON explanation
**Root Cause**: AI added SYNTAX section without first adding ON Clause explanation section
**Why Wrong**: ON is NEW concept in Topik 6, using it without explanation = SURPRISE CONCEPT (again!)
**User Challenge**: "yang dibagian on nya gak kamu jelasin, saya suruh malah baru dijelasin" (you didn't explain ON section, only after I asked)
**When Explained**: User discovered gap in materi organization
**Action**: Added detailed ON Clause section with step-by-step explanation, ensured it comes BEFORE SYNTAX section in file structure
**Lesson**: Check section ORDER in file - explanation must come BEFORE usage in examples, not just "somewhere in materi"
**Fix**: Reorganized so ON Clause explanation section comes BEFORE SYNTAX section
**Prevention**: 
- When creating new section with new concepts, verify order: EXPLAIN → THEN USE
- Don't add SYNTAX or CONTOH sections until all NEW CONCEPTS explained first
- Audit file structure order, not just content

#### 0.6: Aggregate Functions & GROUP BY - Not Yet Taught (CAUGHT BY USER!)
**Context**: Topik 6 materi.md - section "6️⃣ JOIN + GROUP BY + AGGREGATE" used COUNT(), SUM(), and GROUP BY
**Kesalahan**: Taught aggregate functions (COUNT, SUM) and GROUP BY in Topik 6 without explaining them
**Root Cause**: AI tried to show "advanced" example without checking if aggregate/GROUP BY were taught
**Why Wrong**: COUNT, SUM, GROUP BY are NEW concepts not in Topik 1-5, belong to Topik 7
**When Discovered**: User asked "aggregate apa? group by?" - signal that these aren't taught yet
**Action**: REMOVED entire section "6️⃣ JOIN + GROUP BY + AGGREGATE" - will be reintroduced in Topik 7
**Lesson**: Topik 6 = JOIN ONLY. Don't mix with other concepts. Each topik has ONE focus.
**Prevention**: 
- STRICTLY limit each topik to ONE concept (Topik 6 = JOIN)
- Don't add "advanced" examples that mix multiple untaught concepts
- When tempted to show complex example, ask: "Are ALL components already taught?"

**Key Lesson from Session 3**:
- User is VERY strict about "NO SURPRISE CONCEPTS"
- All 6 mistakes violated this rule (LOWER, redundant OR, AS, notation, ON, aggregate)
- Pattern = AI assumes knowledge / doesn't audit materi coverage thoroughly / mixes concepts / doesn't check section order
- Solution = ALWAYS audit every syntax/concept in materi before using + VERIFY EXPLANATION COMES BEFORE USAGE + STICK TO ONE CONCEPT PER TOPIK
- When user asks "kenapa" = immediate signal to add explanation to materi or remove untaught concept

---

### Mistake #1: TEXT QUOTES CONFUSION (To be filled)
**Topik**: TBD
**Kesalahan**: TBD
**Root Cause**: TBD
**Correct Approach**: 
- Text fields: gunakan `'` (single quote) → `WHERE kategori = 'Elektronik'`
- Number fields: TIDAK perlu `'` → `WHERE harga = 500000`
**Prevention**: Selalu tanya: "Is this data a string or number?" → pilih quote atau tidak

---

### Mistake #2: AND/OR PRECEDENCE (To be filled)
**Topik**: TBD
**Kesalahan**: TBD
**Root Cause**: TBD
**Correct Approach**: AND dijalankan terlebih dahulu. Gunakan `()` untuk clarity:
- ❌ `WHERE kategori = 'Elektronik' OR kategori = 'Audio' AND harga > 500000`
- ✅ `WHERE (kategori = 'Elektronik' OR kategori = 'Audio') AND harga > 500000`
**Prevention**: Selalu pakai `()` kalau ada kombinasi AND/OR

---

### Mistake #3: JOIN CREATES DUPLICATES CONFUSION (To be filled)
**Topik**: TBD
**Kesalahan**: TBD
**Root Cause**: TBD
**Correct Approach**: JOIN tidak membuat duplikat "accidentally". Duplikat terjadi jika:
- Data di tabel benar-benar duplikat
- Tabel A (1-many) dengan B melalui JOIN bisa multiplikasi baris
- Ini EXPECTED behavior, bukan mistake
**Prevention**: Understand one-to-many relationships SEBELUM JOIN

---

### Mistake #4: NULL HANDLING (To be filled)
**Topik**: TBD
**Kesalahan**: TBD
**Root Cause**: TBD
**Correct Approach**: 
- `NULL` ≠ `0` 
- `NULL` ≠ `''` (empty string)
- Query NULL: gunakan `WHERE kolom IS NULL`, bukan `WHERE kolom = NULL`
**Prevention**: Ingat: NULL adalah "unknown value", bukan zero atau empty

---

### Mistake #5: UPDATE WITHOUT WHERE (To be filled - Critical!)
**Topik**: TBD
**Kesalahan**: TBD
**Root Cause**: TBD
**Correct Approach**: 
- ❌ `UPDATE users SET email = 'new@email.com';` ← MENAKUTKAN! Update SEMUA user!
- ✅ `UPDATE users SET email = 'new@email.com' WHERE id = 1;` ← Spesifik
**Prevention**: SELALU ada WHERE clause di UPDATE/DELETE kecuali Anda 100% yakin

---

### Mistake #6: DELETE vs SOFT DELETE (To be filled)
**Topik**: TBD
**Kesalahan**: TBD
**Root Cause**: TBD
**Correct Approach**:
- **Hard DELETE**: `DELETE FROM users WHERE id = 1;` ← Data hilang selamanya
- **Soft DELETE**: `UPDATE users SET status = 'inactive' WHERE id = 1;` ← Data tetap ada
- Di production: gunakan soft delete untuk audit trail
**Prevention**: Tanya dulu: "Hard or soft delete?" sebelum jalankan query

---

## SUMMARY STATS

| Mistake Category | Count | Status |
|------------------|-------|--------|
| Text/Number confusion | 1 | - |
| Operator precedence | 1 | - |
| JOIN misconception | 1 | - |
| NULL handling | 1 | - |
| UPDATE/DELETE safety | 2 | - |
| **TOTAL** | **6** | - |

---

**Last Updated**: 2026-06-12
**Template Created**: Ready for entries
