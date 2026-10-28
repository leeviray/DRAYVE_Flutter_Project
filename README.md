<<<<<<< HEAD
# 🏎️ DRAYVE — F1 Drivers Hub Community

**DRAYVE** adalah aplikasi web komunitas penggemar Formula 1 yang dibangun dengan **Flutter** dan **Firebase**. Di sini pengguna bisa menjelajahi profil pembalap F1, melihat statistik & biografi karier, mengikuti postingan terbaru, hingga berdiskusi langsung dengan sesama fans.

> Project ini dibuat untuk menunjang mata kuliah **Pemrograman Berbasis Platform (PBP)**. Semoga dapet A+ (aamiin ya Allah) 🤲

---

## ✨ Fitur Utama

### 🏁 Driver Hub
- Daftar **22 pembalap F1** lengkap dengan nomor, tim, dan bendera negara.
- **Pencarian** berdasarkan nama pembalap, tim, atau nomor (`#no`).
- **Filter tim**: Ferrari, Mercedes, McLaren, Red Bull, Aston Martin, Williams, Alpine, Racing Bulls, Haas, Audi, Cadillac.
- **Favorite** — simpan pembalap favoritmu dan tampilkan di menu khusus.

### 👤 Halaman Detail Pembalap
Setiap pembalap memiliki 4 tab:
| Tab | Isi |
|---|---|
| **Statistics** | Statistik performa pembalap |
| **Biography** | Bio & perjalanan karier |
| **Latest Post** | Postingan sosial media terbaru |
| **Discussion** | Ruang diskusi real-time antar pengguna (Cloud Firestore) |

### 🔐 Autentikasi
- Login & Sign Up dengan **Email / Password**.
- Login dengan **Google**, **Facebook**, dan **Twitter (X)**.
- **Lupa password** via email reset.

### 🙍 Profil Pengguna
- Edit username.
- Upload **foto profil** (dikompres & disimpan sebagai Base64 di Firestore).
- Reset password & logout.

### 🎨 UI / UX
- Splash screen animasi dengan logo DRAYVE.
- Background animasi (moving gradient + F1 speed streaks).
- Efek hover, smooth scroll, dan transisi halaman kustom.
- **Responsif** — tampilan menyesuaikan desktop & mobile.
- Font khas **Ethnocentric** ala F1.
- Halaman **About** pengembang.

---

## 🛠️ Tech Stack

| Kategori | Teknologi |
|---|---|
| Framework | [Flutter](https://flutter.dev) (Dart SDK `^3.13.2`) |
| Backend | Firebase Auth, Cloud Firestore, Firebase Storage |
| Hosting | Firebase Hosting |
| Package lain | `google_fonts`, `image_picker`, `url_launcher`, `cupertino_icons` |

---

## 📁 Struktur Folder

```
lib/
├── main.dart                 # Entry point aplikasi
├── firebase_options.dart     # Konfigurasi Firebase (FlutterFire)
├── data/                     # Data statis: pembalap, statistik, bio karier, sosmed
├── models/                   # Model data (Statistik, BioAtlet)
├── pages/                    # Halaman: splash, landing, auth, profile, detail driver, dll.
├── styles/                   # Warna & text style
└── widgets/                  # Widget reusable: driver card, animated background, dll.
assets/
├── fonts/                    # Font Ethnocentric
├── icons/
└── images/                   # Foto pembalap, bendera, dll.
```

---

## 🚀 Cara Menjalankan

### Prasyarat
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (versi terbaru / mendukung Dart `^3.13.2`)
- Browser Chrome
- (Opsional) [Firebase CLI](https://firebase.google.com/docs/cli) untuk deploy

### Langkah
```bash
# 1. Clone repository
git clone https://github.com/leeviray/MyAPP_flutter_project.git
cd MyAPP_flutter_project

# 2. Install dependencies
flutter pub get

# 3. Jalankan di browser
flutter run -d chrome
```

### Build & Deploy ke Firebase Hosting
```bash
flutter build web --release
firebase deploy --only hosting
```

Untuk deploy Firestore rules:
```bash
firebase deploy --only firestore:rules
```

---

## 🗄️ Struktur Firestore

```
users/{uid}
  ├── uid
  ├── name
  ├── email
  └── photoBase64

driver_discussions/{driverName}/messages/{messageId}
  ├── userName
  └── ...
```

---

## 👨‍💻 Developer

Dibuat oleh **[leeviray](https://github.com/leeviray)** sebagai project mata kuliah PBP.

---

<p align="center"><b>DRAYVE</b> — Lights out and away we go! 🏁</p>
=======
# <img width="192" height="192" alt="192 x 192" src="https://github.com/user-attachments/assets/41acf461-b777-4f1c-8812-f1c3946c129d" />  DRAYVE: F1 Drivers Hub Community <img width="192" height="192" alt="192 x 192" src="https://github.com/user-attachments/assets/c6e3c2bc-5696-47fa-8c67-3076afa1951a" />


<img width="1920" height="1080" alt="chrome_ABiCxLaYku" src="https://github.com/user-attachments/assets/9de4df97-7b79-4cd5-a555-3d5268ebe191" />

<img width="1920" height="1080" alt="chrome_4VYE5R17XY" src="https://github.com/user-attachments/assets/da153a9e-ce90-4e5b-a93c-a834e605cec0" />

<img width="1920" height="1080" alt="chrome_dQAiu8DS4e" src="https://github.com/user-attachments/assets/e1595e78-333e-4e86-8c30-a6f5a48bd40a" />

<img width="1920" height="1080" alt="chrome_bQgXFHOolL" src="https://github.com/user-attachments/assets/a72a853d-6121-4a12-8a7e-6122478ceab2" />

DRAYVE adalah platform komunitas digital interaktif bergaya premium yang didedikasikan untuk penggemar Formula 1, secara khusus mengusung tema musim 2026. Aplikasi ini menyajikan statistik mendalam, biografi perjalanan karier, hingga forum diskusi *real-time*.

🔗 **[Live Demo: Coba DRAYVE di sini](https://drayve-l44p1.web.app)**

## ✨ Fitur Utama
* **Responsive Layout Design:** Tampilan adaptif yang dirancang proporsional baik untuk Desktop (monitor 1080p, laptop 900p) maupun Mobile.
* **Driver Statistics & Bio:** Rekam jejak, poin, posisi klasemen, dan detail biografi pembalap F1 2026.
* **Real-time Fan Discussion:** Ruang obrolan/komentar antar penggemar yang tersinkronisasi seketika menggunakan StreamBuilder Firestore.
* **Smart Authentication:** Sistem *Try before you buy*. Akses baca terbuka publik, namun interaksi (komentar/favorit) diwajibkan *login*.
* **Trackpad Optimized:** Pengalaman *scrolling* momentum mulus menggunakan `BouncingScrollPhysics` dan deteksi kursor global.

## 🛠️ Teknologi yang Digunakan
* **Frontend:** Flutter Web (Dart)
* **Backend:** Firebase (Authentication, Cloud Firestore)
* **Fonts & Icons:** Google Fonts (Montserrat, Poppins, Caveat, Ethnocentric)

## 🚀 Cara Menjalankan Secara Lokal
Jika ingin menjalankan proyek ini di komputermu sendiri:

1. *Clone* repositori ini:
   ```bash
   git clone https://github.com/leeviray/DRAYVE_Flutter_Project.git
>>>>>>> 6a7ce3fcb5e0529a844aadb584688ab59efd0ded
