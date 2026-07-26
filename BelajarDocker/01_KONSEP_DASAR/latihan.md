# TOPIK 1: LATIHAN — Quiz Konseptual

> ⚠️ Jawab pertanyaan berikut **tanpa melihat materi**. 
> Setelah selesai, baru cek ulang ke materi.md untuk verifikasi jawaban Anda.
> Tulis jawaban Anda di bawah setiap pertanyaan.

---

## SOAL 1: Masalah Docker
Jelaskan dengan kata-kata Anda sendiri: **Masalah apa yang Docker selesaikan?**
Berikan satu contoh skenario nyata.

**Jawaban Anda:**
jadi docker untuk mengatasi masalah misal projek nih gede atau di perusaaahaan, nanti kan tiap laptop pasti orang bakal beda dong versi bahasa pemograman atau mysql nya, nah jadi docker tuh dia  buat fix itu, jadi pake docker biar bisa pakai image sama gitu , misal nanti perusahaan udah kasih file docker jadi sy bisa tinggal instalasi aja dan versi semuanya udah sama

---

## SOAL 2: Docker vs Virtual Machine
Sebutkan **3 perbedaan utama** antara Docker Container dan Virtual Machine.

**Jawaban Anda:**
dokcer lebih ringan , sharing, mudah gak ribet sedankgan vm sebaliknya

---

## SOAL 3: Image vs Container
Seorang teman bertanya: *"Image sama Container itu bedanya apa sih?"*
Jelaskan dengan **analogi** yang mudah dipahami.

**Jawaban Anda:**
image tuhcetakannya misal ada node js atau my sql versi tertentu, nah nanti container itu adalainstance yang berjalan berasar image nya , dan juga image gak bisa diubah kalo udah dibuat

---

## SOAL 4: Istilah Docker
Cocokkan istilah dengan definisinya:

| No | Istilah | Definisi |
|:---|:---|:---|
| 1 | Dockerfile | a. Tempat menyimpan dan membagikan image (seperti App Store) |
| 2 | Registry | b. Penyimpanan data yang tetap ada walaupun container dihapus |
| 3 | Volume | c. File teks berisi instruksi untuk membuat image |
| 4 | Container | d. Instance dari image yang sedang berjalan |

**Jawaban Anda:**
- 1 → ? dockerhub
- 2 → ?volume
- 3 → ?dockerfile
- 4 → ?container

---

## SOAL 5: Kenapa Backend Dev Perlu Docker?
Tim Anda mendapat developer baru. **Tanpa Docker**, berapa lama estimasi setup environment?
**Dengan Docker**, apa yang developer baru perlu lakukan?

**Jawaban Anda:**
misal tanpa docker bisa 1-2 hari, dengan docker gampang tinggal git clone trus jalankan perintah docker untuh install dependecy nya dan kelar.


---

## SOAL 6: Alur Kerja Docker
Urutkan langkah-langkah berikut sesuai alur yang benar ketika Anda mengetik `docker run mysql`:

- [ 4] Docker Engine membuat container dari image
- [ 1] Anda mengetik command di terminal
- [3 ] Docker Engine pull image dari Docker Hub (jika belum ada)
- [2 ] Docker Client mengirim perintah ke Docker Engine
- [ 5] Container MySQL berjalan dan siap digunakan

**Jawaban Anda (urutkan 1-5):**



---

> 📝 Setelah selesai menjawab, cek ulang jawaban Anda dengan membaca `materi.md`.
> Jika semua sudah benar → lanjut ke **Topik 2: Image & Container**!
