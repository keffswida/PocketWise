import 'package:flutter/material.dart';

class BudgetPage extends StatelessWidget {
  const BudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Anggaran', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
                  SizedBox(height: 4),
                  Text('Jaga pengeluaranmu.', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(Icons.calendar_month, size: 16, color: Colors.blue),
                  SizedBox(width: 6),
                  Text('Oktober 2026', style: TextStyle(color: Colors.blue, fontSize: 12, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Kartu besar: total anggaran + progress 65%
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total anggaran bulanan', style: TextStyle(color: Colors.grey)),
                  Icon(Icons.pie_chart, color: Colors.blue),
                ],
              ),
              const SizedBox(height: 8),
              const Text('Rp 1.000.000', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800)),
              const SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Terpakai bulan ini', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Text('65%', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: 0.65,
                  minHeight: 8,
                  backgroundColor: Colors.white,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 12),
              const Row(
                children: [
                  Icon(Icons.check_circle, size: 16, color: Colors.green),
                  SizedBox(width: 6),
                  Text('Masih dalam batas', style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 13)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Dua kartu mini
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Row(
                      children: [
                        Icon(Icons.north_east, size: 16, color: Colors.orange),
                        SizedBox(width: 6),
                        Text('Sudah terpakai', style: TextStyle(fontSize: 13)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text('Rp 650.000', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Row(
                      children: [
                        Icon(Icons.account_balance_wallet, size: 16, color: Colors.green),
                        SizedBox(width: 6),
                        Text('Sisa anggaran', style: TextStyle(fontSize: 13)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text('Rp 350.000', style: TextStyle(color: Colors.green, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        const Text('Atur anggaran bulanan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        const Text(
          'Tentukan satu batas total pengeluaran untuk seluruh kebutuhanmu di bulan Oktober.',
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
        const SizedBox(height: 16),
        const Text('Anggaran Oktober 2026', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: const Text('Rp 1.000.000', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            ),
            icon: const Icon(Icons.check, size: 20),
            label: const Text('Simpan anggaran', style: TextStyle(fontWeight: FontWeight.w600)),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Pengeluaran yang kamu catat otomatis dihitung sebagai pemakaian anggaran bulan ini.',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Icon(Icons.info, color: Colors.blue, size: 20),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Pengeluaran yang kamu catat otomatis dihitung sebagai pemakaian anggaran bulan ini.',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
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
