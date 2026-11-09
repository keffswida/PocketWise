import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  // Method bantuan: satu baris transaksi + garis pemisah
  Widget _item(
    String title,
    String category,
    String amount,
    String date,
    IconData icon,
    MaterialColor color,
  ) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          subtitle: Text(category, style: const TextStyle(fontSize: 12)),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
              Text(
                date,
                style: const TextStyle(color: Colors.grey, fontSize: 11),
              ),
            ],
          ),
        ),
        const Divider(height: 1, indent: 68, endIndent: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 16),
          // Top bar: tombol kembali + logo
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.wallet, color: Colors.blue, size: 24),
              const SizedBox(width: 8),
              const Text(
                'PocketWise',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Riwayat',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 4),
          const Text(
            'Catatan uangmu, dari hari ke hari.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),

          // Kartu ringkasan Oktober
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Oktober 2026',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Icon(Icons.calendar_month, color: Colors.blue),
                  ],
                ),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.south_west,
                                size: 14,
                                color: Colors.green,
                              ),
                              SizedBox(width: 4),
                              Text('Pemasukan', style: TextStyle(fontSize: 12)),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(
                            '+ Rp 1.500.000',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.north_east,
                                size: 14,
                                color: Colors.orange,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Pengeluaran',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(
                            '- Rp 650.000',
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Judul seksi
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Transaksi Oktober',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              Text(
                'Terbaru dahulu',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Daftar transaksi
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _item(
                  'Makan siang',
                  'Makanan',
                  '- Rp 25.000',
                  '18 Okt 2026',
                  Icons.lunch_dining,
                  Colors.orange,
                ),
                _item(
                  'Uang saku',
                  'Uang saku',
                  '+ Rp 250.000',
                  '18 Okt 2026',
                  Icons.south_west,
                  Colors.green,
                ),
                _item(
                  'Transport',
                  'Transportasi',
                  '- Rp 15.000',
                  '17 Okt 2026',
                  Icons.directions_bus,
                  Colors.orange,
                ),
                _item(
                  'Makan malam',
                  'Makanan',
                  '- Rp 20.000',
                  '16 Okt 2026',
                  Icons.lunch_dining,
                  Colors.orange,
                ),
                _item(
                  'Ke kampus',
                  'Transportasi',
                  '- Rp 10.000',
                  '15 Okt 2026',
                  Icons.directions_bus,
                  Colors.orange,
                ),
                _item(
                  'Uang saku mingguan',
                  'Uang saku',
                  '+ Rp 250.000',
                  '11 Okt 2026',
                  Icons.south_west,
                  Colors.green,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Menampilkan catatan terbaru. Ringkasan di atas mencakup seluruh transaksi bulan Oktober.',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
