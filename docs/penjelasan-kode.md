# Penjelasan Kode PocketWise

## main.dart — Aplikasi Utama (PocketWiseApp)

- `import 'package:flutter/material.dart';` : Mengambil semua widget Material (MaterialApp, Scaffold, Text, dst.)
- `import 'pages/home.dart';` : Membaca file `home.dart` agar class `HomePage` dikenali di sini
- `void main() { runApp(const PocketWiseApp()); }` : Titik masuk program, menyalakan aplikasi dengan widget paling atas `PocketWiseApp`
- `class PocketWiseApp extends StatelessWidget` : Widget paling atas aplikasi, Stateless karena tema/judulnya tidak pernah berubah selama aplikasi jalan
- `const PocketWiseApp({super.key});` : Konstruktor class, `{super.key}` adalah parameter bawaan Flutter
- `Widget build(BuildContext context)` : Method yang dipanggil Flutter untuk menggambar widget
- `MaterialApp(...)` : Manajer utama aplikasi, hanya boleh ada satu
- `title: 'PocketWise'` : Nama yang muncul di task switcher Android, bukan judul di dalam aplikasi
- `debugShowCheckedModeBanner: false` : Menghilangkan pita merah "DEBUG" di pojok kanan atas
- `useMaterial3: true` : Mengaktifkan desain Material 3
- `colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)` : Dari satu warna biru, Flutter otomatis membuat palet warna seluruh aplikasi
- `home: const MainScreen()` : Halaman (cangkang) yang tampil pertama; di dalamnya berisi NavigationBar dan pergantian halaman

## main.dart — Cangkang Navigasi (MainScreen)

- `class MainScreen extends StatefulWidget` : Cangkang aplikasi, Stateful karena `_selectedIndex` (posisi menu) bisa berubah
- `class _MainScreenState extends State<MainScreen>` : Tempat data dan build() milik StatefulWidget; class `MainScreen` hanya konfigurasinya
- `int _selectedIndex = 0;` : Data tab yang sedang aktif. Angka 0–3 (Beranda, Transaksi, Anggaran, Pengaturan). Buka aplikasi selalu di 0 = Beranda
- `final List<Widget> _pages = const [...]` : Daftar halaman yang bisa ditampilkan. Urutannya WAJIB sama dengan urutan menu di NavigationBar, karena nomor menu dipasangkan lewat urutan
- `Scaffold(...)` : Kerangka cangkang; Scaffold-nya milik MainScreen, bukan milik tiap halaman
- `body: _pages[_selectedIndex]` : Isi tengah layar = ambil halaman yang angkanya sama dengan tab aktif. Inilah baris yang "berganti isi layar"
- `bottomNavigationBar: NavigationBar(...)` : Slot khusus Scaffold untuk menu di bawah layar, ditulis sekali untuk semua halaman
- `NavigationBar(selectedIndex: _selectedIndex, ...)` : Menu navigasi Material 3; membaca data tab aktif untuk menandai pil biru pada ikon yang aktif
- `NavigationDestination(icon: Icon(Icons.home), label: 'Beranda')` : Satu menu = ikon + tulisan. Empat menu: `Icons.home`, `Icons.receipt_long`, `Icons.pie_chart`, `Icons.settings` sesuai desain
- `onDestinationSelected: (int index) { setState(() { _selectedIndex = index; }); }` : Dipanggil otomatis saat menu ditekan; index yang diterima disimpan ke data melalui setState, sehingga build() jalan ulang dan body berganti

## pages/home.dart

- `class HomePage extends StatelessWidget` : Halaman Beranda. Masih Stateless karena tab ini sendiri belum punya data yang berubah
- `Widget build(BuildContext context)` : Semua tampilan halaman ditulis di sini
- `return const Center(child: Text('Beranda'));` : Sementara isi tengahnya teks saja. Tidak ada Scaffold di sini karena Scaffold milik MainScreen; HomePage hanya "isi" yang dipasang di body cangkang

## pages/transaction.dart, budget.dart, settings.dart (placeholder)

- `class TransactionPage extends StatelessWidget` : Halaman Transaksi, versi placeholder agar pergantian tab bisa diuji
- `return const Center(child: Text('Halaman Transaksi'));` : Isi sementara. Pola sama untuk `BudgetPage` ('Halaman Anggaran') dan `SettingsPage` ('Halaman Settings')

## pages/home.dart — Halaman Beranda (Tahap 4.1 & 4.2)

- `ListView(padding: const EdgeInsets.all(16), children: [...])` : Pengganti Center/Column. Seperti Column tapi otomatis bisa discroll saat isinya melebihi layar. padding memberi jarak ke pinggir layar
- `const SizedBox(height: 20)` : Kotak kosong dipakai sebagai jarak antarwidget
- `Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [...])` : Baris mendatar; spaceBetween menaruh anak pertama di kiri dan anak terakhir di pojok kanan
- `Column(crossAxisAlignment: CrossAxisAlignment.start, ...)` : Tumpukan menurun; crossAxis.start membuat semua teks rata kiri
- `Expanded(child: Column(...))` di dalam Row : Makan semua ruang sisa; dipakai agar teks heading tidak menabrak chip tanggal, dan agar lengking (Expanded) dua kartu Pemasukan/Pengeluaran selebar setengah layar masing-masing
- `Container(decoration: BoxDecoration(color: ..., borderRadius: BorderRadius.circular(20)))` : "Kartu" buatan sendiri: warna + sudut membulat; `borderRadius` mengatur kelengkungan sudut
- `EdgeInsets.all(16)` / `EdgeInsets.symmetric(horizontal: 12, vertical: 8)` : Jarak padding; all = semua sisi, symmetric = kiri/kanan + atas/bawah terpisah
- `width: double.infinity` : Lebar ikut melebar penuh (hingga batas pembungkusnya), dipakai di kartu saldo dan tombol
- `Colors.blue.shade50` / `Colors.green.shade50` : Versi terang dari warna dasar, dipakai untuk latar kartu, chip, dan lingkaran ikon
- `TextStyle(fontSize: ..., fontWeight: FontWeight.w700)` : Mengatur ukuran/tebal huruf; w700-w800 untuk judul, normal untuk isi
- `_selectedIndex` di body + `backgroundColor: Colors.grey.shade100` di Scaffold MainScreen : Latar abu terang agar kartu putih (warna putih asli) tampak terpisah dari latar
- `ElevatedButton.icon(onPressed: () {}, ...)` : Tombol dengan ikon + tulisan. `onPressed: () {}` = fungsi kosong (diam saja), nanti diisi navigasi di Tahap 6
- `style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)))` : Menimpa gaya bawaan tombol: biru polos, teks putih, ujung menenggelam setengah jadi pil
- `Card` vs `Container`+`BoxDecoration` : Dua-duanya sah untuk kartu; desain ini pakai Container agar bebas menentukan warna & sudut persis
- `LinearProgressIndicator(value: 0.25, minHeight: 6, backgroundColor: ..., color: ...)` : Bar kemajuan siap pakai; 0.25 = 25% terisi. Angka ini nanti dihitung dari data tabungan
- `ClipRRect(borderRadius: BorderRadius.circular(6), child: LinearProgressIndicator(...))` : Membungkus bar progress agar ujungnya membulat
- `TextButton(onPressed: () {}, child: Text('Lihat semua'))` : Tombol tanpa latar (teks saja); tempat menempel `Navigator.push` ke HistoryPage di Tahap 6
- `ListTile(leading: ..., title: ..., subtitle: ..., trailing: ...)` : Baris daftar siap pakai; leading = widget di kiri (ikon dalam lingkaran Container), title = teks utama, subtitle = teks kecil di bawahnya, trailing = widget di ujung kanan (nominal + tanggal)
- `trailing: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.end, ...)` : Dua baris teks di kanan; center agar sejajar vertikal dengan ikon, end agar angka/tanggal rata kanan
- `Divider(height: 1, indent: 68, endIndent: 16)` : Garis pemisah tipis antar ListTile; indent = menjorok dari kiri agar garis mulai setelah ikon (16 padding + 40 ikon + 12 jarak)

## Konsep Dasar

- `MaterialApp` vs `Scaffold` : MaterialApp = level aplikasi, Scaffold = level cangkang yang menampung NavigationBar; halaman dipasang di dalamnya sebagai isi
- `StatelessWidget` : Tampilan tidak pernah berubah, tidak punya setState
- `StatefulWidget` + `setState()` : Ada data yang bisa berubah; setState mengubah data lalu memicu build() dijalankan ulang sehingga layar diperbarui. Tanpa setState, perubahan tidak terlihat
- `NavigationBar` + `NavigationDestination` : Menu bawah Material 3; pil biru di ikon aktif muncul otomatis
- `selectedIndex` + `onDestinationSelected` : Berpasangan: yang pertama menentukan tab aktif, yang kedua dipanggil saat user menekan tab
- `const` : Nilai yang pasti sama sejak awal, cukup dibuat sekali; biasakan menempelkannya seperti di contoh
- `import` : Dart tidak otomatis tahu isi file lain, jadi file harus diimpor dulu; path relatif terhadap folder `lib/`
- `ListView` vs `Column` : Column muat satu layar dan tidak bisa discroll; ListView menampung banyak isi panjang dengan geser otomatis
- `mainAxisAlignment` vs `crossAxisAlignment` : Pada Row main axis = mendatar; pada Column main axis = menurun; crossAxis selalu tegak lurusnya
- Padding warna: hijau = pemasukan/positif, oranye = pengeluaran/negatif, biru = aksi utama/tema
