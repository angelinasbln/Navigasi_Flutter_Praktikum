# Navigasi Flutter Praktikum

Repositori ini berisi kumpulan praktikum Flutter yang membahas berbagai jenis navigasi yang umum digunakan dalam pengembangan aplikasi mobile menggunakan Flutter.

## 🎯 Tujuan Praktikum

Tujuan dari praktikum ini adalah untuk memahami dan mengimplementasikan berbagai teknik navigasi dalam Flutter, mulai dari navigasi dasar hingga navigasi kompleks seperti nested navigation dan deep linking. Dengan mempelajari ini, diharapkan mahasiswa mampu membangun alur navigasi aplikasi yang terstruktur dan scalable.

---

## 📦 Daftar Proyek Navigasi

### 1. `navigation_pbm` - **Named Routes**
- **Deskripsi:** Menggunakan `Navigator.pushNamed` dan `MaterialApp.routes` untuk berpindah antar halaman.
- **Widget Utama:** `Navigator`, `MaterialPageRoute`
- **Manfaat:** Pemisahan rute secara deklaratif, cocok untuk proyek kecil-menengah.
- **Contoh UI:**
  
  ![Named Routes - Home](screenshots/navigation_pbm.png)
  > Gambar: Halaman Home menggunakan `Navigator.pushNamed` untuk navigasi.

---

### 2. `navigation_20_pbm` - **Navigator 2.0 (Router API)**
- **Deskripsi:** Menggunakan API `Router` dan `RouteInformationParser` untuk mengatur rute secara lebih fleksibel.
- **Widget Utama:** `Router`, `RouteInformationParser`, `RouterDelegate`
- **Manfaat:** Kontrol penuh terhadap URL, cocok untuk aplikasi skala besar dan web.
- **Contoh UI:**

  ![Navigator 2.0 - Detail](screenshots/navigation_20_pbm_detail.png)
  > Gambar: Halaman Detail diakses melalui deep link `/detail/:id`, dikontrol oleh `AppRouterDelegate`.

---

### 3. `nested_navigation_pbm` - **Nested Navigation**
- **Deskripsi:** Navigasi bertingkat di dalam satu screen, seperti alur onboarding atau setup wizard.
- **Widget Utama:** `Navigator` dalam `body`, menggunakan `GlobalKey<NavigatorState>`
- **Manfaat:** Menyediakan alur langkah demi langkah tanpa keluar dari halaman induk.
- **Contoh UI:**

  ![Nested Navigation - Confirm](screenshots/nested_navigation_pbm_confirm.png)
  > Gambar: Sub-layar "Confirm Device" di dalam `SetupFlowScreen`, bagian dari nested navigator.

---

### 4. `deep_link_navigation_pnm` - **Deep Linking**
- **Deskripsi:** Mendukung akses halaman langsung melalui URL, seperti `/detail/2` atau `/settings`.
- **Widget Utama:** `Router`, `RouteInformationParser`, `RouterDelegate`
- **Manfaat:** Cocok untuk aplikasi berbasis web atau integrasi link eksternal.
- **Contoh UI:**

  ![Deep Linking - Settings](screenshots/deep_link_navigation_settings.png)
  > Gambar: Halaman Settings yang dapat diakses langsung melalui `/settings`, ditambahkan ke konfigurasi router.

---

## 🛠 Struktur Folder

