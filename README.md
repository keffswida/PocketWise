# PocketWise 💰

Aplikasi pengelolaan keuangan pribadi berbasis Flutter untuk mahasiswa — mencatat pemasukan dan pengeluaran, mengatur anggaran bulanan, dan memantau target tabungan. Dikembangkan sebagai proyek UTS Pemrograman Mobile.

## Tentang Aplikasi

PocketWise membantu kamu mengelola uang saku secara manual dan offline — tanpa akun, tanpa koneksi bank, tanpa sinkronisasi cloud. Semua data disimpan di perangkatmu sendiri.

**Fitur utama:**

- **Beranda** — ringkasan saldo, pemasukan/pengeluaran bulan ini, progres tabungan, dan transaksi terbaru
- **Transaksi** — mencatat uang masuk/keluar lengkap dengan nominal, kategori, catatan, dan tanggal
- **Anggaran** — batas total pengeluaran bulanan dengan indikator pemakaian (sudah terpakai / sisa anggaran)
- **Pengaturan** — mode gelap, rating aplikasi, dan informasi aplikasi/developer
- **Riwayat** — daftar seluruh transaksi dengan ringkasan bulanan (halaman pendukung)
- **Tabungan** — target dan progres tabungan dengan saran setoran bulanan (halaman pendukung)

**Teknologi:**

| | |
|---|---|
| Framework | Flutter (Material 3) |
| Bahasa | Dart |
| State management | `setState()` |
| Penyimpanan | Rencana: `shared_preferences` |
| Platform | Android |

## Struktur Proyek

```
lib/
├── main.dart              # MaterialApp + MainScreen (NavigationBar 4 menu)
└── pages/
    ├── home.dart          # Beranda
    ├── transaction.dart   # Transaksi
    ├── budget.dart        # Anggaran
    ├── settings.dart      # Pengaturan
    ├── history.dart       # Riwayat (dibuka via Navigator.push)
    └── savings.dart       # Tabungan (dibuka via Navigator.push)
```

Referensi desain (PNG) dan dokumentasi penjelasan kode ada di folder [`docs/`](docs/).

## Cara Menjalankan Aplikasi

**Prasyarat:** SDK Flutter terpasang dan Android Studio dengan emulator atau perangkat Android (mode USB debugging).

```bash
# 1. Ambil dependensi
flutter pub get

# 2. Jalankan (pastikan emulator/HP terdeteksi)
flutter run
```

Atau tekan tombol **Run ▶** langsung dari Android Studio.

## Cara Membuat File APK

```bash
# Build release APK (debug untuk pengujian cepat)
flutter build apk --release
```

Hasilnya ada di:

```
build/app/outputs/flutter-apk/app-release.apk
```

Salin file `.apk` tersebut ke HP untuk menginstalnya (aktifkan "Install dari sumber tidak dikenal" bila diminta), atau bagikan langsung sebagai file.

Alternatif untuk pengujian cepat:

```bash
flutter build apk --debug   # APK debug, ukuran lebih besar
```

> **Catatan:** build pertama biasanya memakan waktu beberapa menit karena proses kompilasi Gradle.

## Status Pengembangan

- [x] Hari 2 — Kerangka UI, Bottom Navigation, tampilan enam halaman
- [ ] Hari 3 — Penyimpanan data (`shared_preferences`) dan logika keuangan

## Dokumentasi

- [`docs/penjelasan-kode.md`](docs/penjelasan-kode.md) — penjelasan tiap bagian kode
- [`docs/`](docs/) — referensi desain PNG seluruh halaman
