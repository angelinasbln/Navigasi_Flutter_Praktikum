# Navigasi Flutter Praktikum

Repositori ini berisi kumpulan praktikum Flutter yang membahas berbagai jenis navigasi yang umum digunakan dalam pengembangan aplikasi mobile menggunakan Flutter.

---

## 🎯 Tujuan Praktikum

Praktikum ini bertujuan untuk memperdalam pemahaman mahasiswa terhadap berbagai teknik navigasi dalam Flutter, mulai dari yang paling dasar hingga navigasi yang lebih kompleks dan modern. Dengan memahami Named Routes, Navigator 2.0, Nested Navigation, dan Deep Linking, mahasiswa diharapkan mampu membangun alur navigasi aplikasi yang lebih terstruktur, efisien, dan scalable, baik untuk aplikasi mobile maupun web.

---

## 🚀 Pengantar Jenis Navigasi di Flutter

### Named Routes  
Navigasi dengan mendefinisikan rute secara statis di `MaterialApp.routes` dan menggunakan `Navigator.pushNamed`. Cocok untuk aplikasi kecil sampai menengah dengan struktur rute yang sederhana.

![Named Routes - Home](screenshots/navigator_pbm.png)  
*Gambar: Halaman Home menggunakan Named Routes.*

---

### Navigator 2.0 (Router API)  
Navigasi modern menggunakan `Router`, `RouteInformationParser`, dan `RouterDelegate`. Memberikan kontrol penuh terhadap URL dan state navigasi, sangat cocok untuk aplikasi skala besar dan web.

![Navigator 2.0 - Detail](screenshots/navigator_20_pbm.png)  
*Gambar: Halaman Detail diakses melalui deep link dengan parameter ID.*

---

### Nested Navigation  
Navigasi bertingkat di dalam satu halaman induk, cocok untuk alur bertahap seperti onboarding atau setup wizard. Menggunakan `Navigator` internal dengan `GlobalKey<NavigatorState>`.

![Nested Navigation - Steps](screenshots/nested_navigation1.png)  
*Gambar: Langkah-langkah bertahap pada Nested Navigation.*
![Nested Navigation - Steps](screenshots/nested_navigation2.png)  
*Gambar: Langkah-langkah bertahap pada Nested Navigation.*
![Nested Navigation - Steps](screenshots/nested_navigation3.png)  
*Gambar: Langkah-langkah bertahap pada Nested Navigation.*
![Nested Navigation - Steps](screenshots/nested_navigation4.png)  
*Gambar: Langkah-langkah bertahap pada Nested Navigation.*
---

### Deep Linking  
Mendukung akses halaman secara langsung menggunakan URL, misalnya `/detail/2` atau `/settings`. Implementasi dengan `Router`, `RouteInformationParser`, dan `RouterDelegate`. Cocok untuk aplikasi web atau integrasi dengan link eksternal.

![Deep Linking - Settings](screenshots/deep_link_navigation.png)  
*Gambar: Halaman Settings dapat diakses langsung via deep link.*

---
