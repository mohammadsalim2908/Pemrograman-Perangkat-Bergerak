## Identitas
- Nama: [Nama Kamu]
- NIM: 362558302127
- Mata Kuliah: Pemrograman Perangkat Bergerak
- Studi Kasus: Aplikasi Informasi Wisata Kampus

## Fitur dan Halaman
Project terdiri dari empat halaman utama:

HomePage
   ↓ Navigator.push()
DetailPage
   ↓ Navigator.push()
RoutePage
   ↓ Navigator.pushReplacement()
SuccessPage
   ↓ Navigator.popUntil()
HomePage

### 1. HomePage
halaman awal yang menampilkan gambar ilustrasi wisata kampus dan beberapa pilihan lokasi:

- Taman Kampus
- Perpustakaan
- Laboratorium

Ketika lokasi dipilih, aplikasi berpindah ke `DetailPage` menggunakan `Navigator.push()`.

### 2. DetailPage
menampilkan detail lokasi yang dipilih. Nama lokasi dikirim melalui constructor menggunakan parameter `placeName`.

Tombol "Lihat Rute" menggunakan `Navigator.push()` untuk membuka `RoutePage`.

### 3. RoutePage
menampilkan petunjuk rute menuju lokasi. Ketika tombol "Selesai" ditekan, `RoutePage` diganti dengan `SuccessPage` menggunakan `Navigator.pushReplacement()`.

### 4. SuccessPage
menampilkan pesan bahwa pengguna sudah sampai.

Tombol "Kembali ke Beranda" menggunakan:

Navigator.popUntil(
  context,
  (route) => route.isFirst,
);

## Mengapa Menggunakan `Navigator.popUntil()`?
Pada project ini urutan navigasi adalah:

HomePage
   ↓ push
DetailPage
   ↓ push
RoutePage
   ↓ pushReplacement
SuccessPage

Setelah `pushReplacement()`, `RoutePage` digantikan oleh `SuccessPage`. Karena itu route stack menjadi:

HomePage
DetailPage
SuccessPage

`Navigator.pop(context)` hanya melakukan **satu pop**, yaitu menghapus route paling atas. Jika dipanggil dari `SuccessPage`, hasilnya adalah:

HomePage
DetailPage

sehingga halaman yang tampil adalah `DetailPage`, bukan langsung `HomePage`.

Karena kebutuhan aplikasi adalah kembali langsung sampai halaman pertama, digunakan `Navigator.popUntil()`.

Navigator.popUntil(
  context,
  (route) => route.isFirst,
);

`popUntil()` melakukan pop berulang sampai kondisi yang diberikan bernilai `true`.

### Arti `(route) => route.isFirst`
Bagian tersebut bukan berarti menunjuk `HomePage` secara langsung. `route.isFirst` memeriksa apakah route yang sedang diperiksa merupakan route pertama pada Navigator.

Pada aplikasi ini route pertama adalah `HomePage`, sehingga prosesnya dapat digambarkan sebagai:

SuccessPage
    ↓ pop
DetailPage
    ↓ pop
HomePage
    ↓ route.isFirst == true
STOP

Dengan demikian `SuccessPage` dapat kembali ke `HomePage` tanpa menuliskan `HomePage` sebagai tujuan langsung.

## Asset Gambar
Gambar ilustrasi pada halaman utama menggunakan asset lokal:

assets/
└── images/
    └── wisata_kampus.png

Pada `home_page.dart` digunakan:

Image.asset(
  'assets/images/wisata_kampus.png',
  fit: BoxFit.contain,
)

Asset juga harus didaftarkan pada `pubspec.yaml`:

```yaml
flutter:
  uses-material-design: true

  assets:
    - assets/images/wisata_kampus.png
```

## Struktur Project

p6/
├── assets/
│   └── images/
│       └── wisata_kampus.png
│
├── lib/
│   ├── main.dart
│   └── studi_kasus/
│       ├── home_page.dart
│       ├── detail_page.dart
│       ├── route_page.dart
│       └── succes_page.dart
│
├── pubspec.yaml
├── README.md
└── useai.md

## Skenario Pengujian
1. Jalankan aplikasi.
2. Pastikan `HomePage` menampilkan gambar wisata kampus.
3. Tekan **Taman Kampus**.
4. Pastikan `DetailPage` terbuka dan menampilkan nama lokasi.
5. Tekan **Lihat Rute**.
6. Pastikan `RoutePage` terbuka.
7. Tekan **Selesai**.
8. Pastikan `SuccessPage` terbuka.
9. Tekan **Kembali ke Beranda**.
10. Pastikan `Navigator.popUntil()` mengembalikan aplikasi sampai `HomePage`.