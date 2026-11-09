import 'package:flutter/material.dart';

class SavingsPage extends StatelessWidget {
  const SavingsPage({super.key});

  // Method bantuan yang sama dengan di TransactionPage
  Widget _field(String label, String value, IconData? icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value, style: const TextStyle(fontSize: 15)),
              if (icon != null) Icon(icon, color: Colors.grey, size: 20),
            ],
          ),
        ),
        const SizedBox(height: 16),
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
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(
                  context,
                ), // ← akan diisi Navigator.pop() di Tahap 6
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
            'Tabungan',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 4),
          const Text(
            'Sedikit demi sedikit, jadi bukit.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),

          // Kartu tabungan terkumpul
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.savings,
                        color: Colors.green,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Tabungan terkumpul',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Rp 500.000',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'dari target Rp 2.000.000',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Text(
                      '25% tercapai',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: 0.25,
                    minHeight: 8,
                    backgroundColor: Colors.green.shade100,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Rp 1.500.000 lagi menuju targetmu.',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          const Text(
            'Atur target dan tabungan',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          _field('Target tabungan', 'Rp 2.000.000', null),
          _field('Tabungan terkumpul', 'Rp 500.000', null),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              icon: const Icon(Icons.check, size: 20),
              label: const Text(
                'Simpan tabungan',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Kartu hijau langkah bulanan
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.savings, color: Colors.green, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Langkah kecil setiap bulan',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Rp 250.000 / bulan',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Selama 6 bulan ke depan: November 2026–April 2027.',
                  style: TextStyle(color: Colors.green, fontSize: 13),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Sisa Rp 1.500.000 ÷ 6 bulan. Sisihkan secara rutin agar targetmu tercapai.',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Center(
            child: Text(
              'Hanya untuk mencatat progres tabungan. Tidak ada transfer atau pemindahan uang.',
              style: TextStyle(color: Colors.grey, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
