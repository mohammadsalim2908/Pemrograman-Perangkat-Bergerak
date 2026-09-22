# Use AI

## Alat/Model

ChatGPT (GPT-5.6 Luna)

## Tujuan Penggunaan

AI digunakan sebagai tutor, debugger, dan reviewer selama pengerjaan studi kasus Flutter Navigator.

Bantuan digunakan untuk memahami konsep navigasi Flutter, memeriksa error compile/runtime, memeriksa hubungan antar file, membantu memperbaiki import, dan membantu menyusun dokumentasi project.

## Ringkasan Prompt

Prompt yang digunakan meminta bantuan untuk:

- memahami alur `Navigator.push()`;
- memahami `Navigator.pushReplacement()`;
- memahami `Navigator.pop()` dan perbedaannya dengan `Navigator.popUntil()`;
- memahami route stack;
- memperbaiki error karena nama file dan import tidak sesuai;
- menambahkan gambar lokal pada `HomePage`;
- memperbaiki registrasi asset pada `pubspec.yaml`;
- menyusun README dan dokumentasi penggunaan AI.

## Bagian Kode yang Terpengaruh
AI memberikan bantuan/review pada:

- `lib/main.dart`
- `lib/studi_kasus/home_page.dart`
- `lib/studi_kasus/detail_page.dart`
- `lib/studi_kasus/route_page.dart`
- `lib/studi_kasus/succes_page.dart`
- `pubspec.yaml`
- asset `assets/images/wisata_kampus.png`
- `README.md`

## Perubahan yang Dilakukan Setelah Menerima Saran AI
Saya menyesuaikan struktur file dengan project yang digunakan, memeriksa kembali path import, menambahkan asset gambar ke `HomePage`, mendaftarkan asset pada `pubspec.yaml`, dan memilih penggunaan:

```dart
Navigator.popUntil(
  context,
  (route) => route.isFirst,
);
```

untuk mengembalikan `SuccessPage` sampai route pertama, yaitu `HomePage`.

Saya juga menjalankan kembali project menggunakan `flutter analyze` dan `flutter run` untuk memeriksa hasil implementasi.

## Pernyataan Pemahaman
Saya memahami bahwa `Navigator.push()` menambahkan route, `Navigator.pushReplacement()` mengganti route aktif, `Navigator.pop()` menghapus satu route teratas, sedangkan `Navigator.popUntil()` melakukan pop berulang sampai suatu kondisi terpenuhi.

Saya juga memahami bahwa `route.isFirst` tidak menunjuk class `HomePage` secara eksplisit. Nilai tersebut memeriksa apakah route yang sedang diperiksa merupakan route pertama pada Navigator. Pada project ini route pertama tersebut adalah `HomePage`.
