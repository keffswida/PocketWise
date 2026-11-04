import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 8),
        const Text('Pengaturan', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
        const SizedBox(height: 4),
        const Text('Buat PocketWise nyaman untukmu.', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 20),

        const Text('Tampilan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),

        // Kartu Mode gelap
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.dark_mode, color: Colors.blue, size: 20),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mode gelap', style: TextStyle(fontWeight: FontWeight.w600)),
                    SizedBox(height: 2),
                    Text('Nonaktif · Tema terang', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
              Switch(value: false, onChanged: (value) {}),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Kartu rating bintang
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Suka dengan PocketWise?', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
              const SizedBox(height: 8),
              const Text(
                'Beri penilaian untuk pengalamanmu mencatat keuangan sehari-hari.',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(5, (index) {
                  return Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.star_border, color: Colors.blue),
                  );
                }),
              ),
              const SizedBox(height: 12),
              const Center(
                child: Text('Ketuk bintang untuk memberi nilai', style: TextStyle(color: Colors.grey, fontSize: 12)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Kartu Tentang PocketWise
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.wallet, color: Colors.blue, size: 20),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tentang PocketWise', style: TextStyle(fontWeight: FontWeight.w700)),
                        SizedBox(height: 2),
                        Text('Versi 1.0.0', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Teman mengelola uang saku mahasiswa. Catat pemasukan dan pengeluaran secara manual, atur anggaran bulanan, dan pantau target tabunganmu.',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(Icons.shield, color: Colors.green, size: 18),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Offline, tersimpan di perangkat', style: TextStyle(color: Colors.green, fontWeight: FontWeight.w700, fontSize: 13)),
                          SizedBox(height: 2),
                          Text('Tanpa akun, sinkronisasi cloud, koneksi bank, atau pembayaran sungguhan.',
                              style: TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
