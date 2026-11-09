import 'package:flutter/material.dart';
import 'package:pocketwise/models/transaction.dart';
import 'package:pocketwise/services/transaction_service.dart';
import 'history.dart';
import 'savings.dart';
import 'transaction.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Transaction> _items = [];
  int _savingsTarget = 2000000;
  int _savingsSaved = 0;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final data = await TransactionService.load();
    final target = await TransactionService.loadSavingsTarget();
    final saved = await TransactionService.loadSavingsSaved();
    if (!mounted) return;
    setState(() {
      _items = data..sort((a, b) => b.date.compareTo(a.date));
      _savingsTarget = target;
      _savingsSaved = saved;
      _loading = false;
    });
  }

  int get _income => _items.where((t) => t.type == TransactionType.income).fold(0, (s, t) => s + t.amount);
  int get _expense => _items.where((t) => t.type == TransactionType.expense).fold(0, (s, t) => s + t.amount);
  int get _balance => _income - _expense;
  double get _savingsProgress => _savingsTarget <= 0 ? 0 : (_savingsSaved / _savingsTarget).clamp(0.0, 1.0);

  String _rp(int v) {
    final s = v.abs().toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
      buf.write(s[i]);
    }
    return 'Rp ${v < 0 ? '-' : ''}${buf.toString()}';
  }

  String _formatDate(DateTime d) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
    return '${d.day} ${months[d.month - 1]} ${d.year}';
  }

  Widget _tile(Transaction t) {
    final isIncome = t.type == TransactionType.income;
    final color = isIncome ? Colors.green : Colors.orange;
    final icon = isIncome ? Icons.south_west : (t.category.toLowerCase().contains('makan') ? Icons.lunch_dining : (t.category.toLowerCase().contains('transport') ? Icons.directions_bus : Icons.north_east));
    return Column(
      children: [
        ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: color, size: 20),
          ),
          title: Text(t.note.isEmpty ? t.category : t.note, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          subtitle: Text(t.category, style: const TextStyle(fontSize: 12)),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${isIncome ? '+' : '-'} ${_rp(t.amount)}', style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 13)),
              Text(_formatDate(t.date), style: const TextStyle(color: Colors.grey, fontSize: 11)),
            ],
          ),
        ),
        const Divider(height: 1, indent: 68, endIndent: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    final recent = _items.take(3).toList();
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Header
        const Row(
          children: [
            Text('PocketWise', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          ],
        ),
        const SizedBox(height: 20),
        // Heading + chip
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Beranda', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
                  SizedBox(height: 4),
                  Text('Yuk, cek uang sakumu.', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(20)),
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
        // Kartu saldo
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Saldo saat ini', style: TextStyle(color: Colors.grey)),
                  Icon(Icons.account_balance_wallet, color: Colors.blue),
                ],
              ),
              const SizedBox(height: 8),
              Text(_rp(_balance), style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w800)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Pemasukan / Pengeluaran
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.south_west, size: 16, color: Colors.green),
                        SizedBox(width: 6),
                        Text('Pemasukan', style: TextStyle(fontSize: 13)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(_rp(_income), style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    const Text('Bulan ini', style: TextStyle(color: Colors.grey, fontSize: 12)),
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
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.north_east, size: 16, color: Colors.orange),
                        SizedBox(width: 6),
                        Text('Pengeluaran', style: TextStyle(fontSize: 13)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(_rp(_expense), style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    const Text('Bulan ini', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Tombol catat transaksi
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () async {
              await Navigator.push(context, MaterialPageRoute(builder: (context) => const TransactionPage()));
              _load();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            ),
            icon: const Icon(Icons.add),
            label: const Text('Catat transaksi', style: TextStyle(fontWeight: FontWeight.w600)),
          ),
        ),
        const SizedBox(height: 16),
        // Kartu tabungan
        GestureDetector(
          onTap: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (context) => const SavingsPage()));
            _load();
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.savings, color: Colors.green),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tabungan', style: TextStyle(fontWeight: FontWeight.w700)),
                          SizedBox(height: 2),
                          Text('Sedikit demi sedikit, jadi bukit.', style: TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_rp(_savingsSaved), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                    Text('${(_savingsProgress * 100).round()}% tercapai', style: const TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(value: _savingsProgress, minHeight: 6, backgroundColor: Colors.green.shade50, color: Colors.green),
                ),
                const SizedBox(height: 4),
                Text('dari target ${_rp(_savingsTarget)}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Transaksi terbaru
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Transaksi terbaru', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HistoryPage())),
              child: const Text('Lihat semua', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (recent.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: const Column(
              children: [
                Icon(Icons.receipt_long, size: 48, color: Colors.grey),
                SizedBox(height: 12),
                Text('Belum ada transaksi', style: TextStyle(fontWeight: FontWeight.w700)),
                SizedBox(height: 4),
                Text('Tekan tombol "Catat transaksi" di atas', style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          )
        else
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                for (int i = 0; i < recent.length; i++) ...[
                  _tile(recent[i]),
                  if (i < recent.length - 1) const SizedBox.shrink(),
                ],
              ],
            ),
          ),
        const SizedBox(height: 24),
      ],
    );
  }
}
