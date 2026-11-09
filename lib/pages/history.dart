import 'package:flutter/material.dart';
import 'package:pocketwise/models/transaction.dart';
import 'package:pocketwise/services/transaction_service.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Transaction> _items = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final data = await TransactionService.load();
    if (!mounted) return;
    setState(() {
      _items = data..sort((a, b) => b.date.compareTo(a.date));
      _loading = false;
    });
  }

  int get _income => _items.where((t) => t.type == TransactionType.income).fold(0, (s, t) => s + t.amount);
  int get _expense => _items.where((t) => t.type == TransactionType.expense).fold(0, (s, t) => s + t.amount);

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

  IconData _iconFor(Transaction t) {
    final c = t.category.toLowerCase();
    if (c.contains('makan')) return Icons.lunch_dining;
    if (c.contains('transport')) return Icons.directions_bus;
    return t.type == TransactionType.income ? Icons.south_west : Icons.north_east;
  }

  Widget _item(Transaction t) {
    final isIncome = t.type == TransactionType.income;
    final color = isIncome ? Colors.green : Colors.orange;
    return Column(
      children: [
        ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(12)),
            child: Icon(_iconFor(t), color: color, size: 20),
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
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 16),
            // Top bar
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.wallet, color: Colors.blue, size: 24),
                const SizedBox(width: 8),
                const Text('PocketWise', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.blue)),
              ],
            ),
            const SizedBox(height: 8),
            const Text('Riwayat', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            const Text('Catatan uangmu, dari hari ke hari.', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),

            // Kartu ringkasan
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Oktober 2026', style: TextStyle(fontWeight: FontWeight.w700)),
                      Icon(Icons.calendar_month, color: Colors.blue),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.south_west, size: 14, color: Colors.green),
                                SizedBox(width: 4),
                                Text('Pemasukan', style: TextStyle(fontSize: 12)),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(_rp(_income), style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.north_east, size: 14, color: Colors.orange),
                                SizedBox(width: 4),
                                Text('Pengeluaran', style: TextStyle(fontSize: 12)),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(_rp(_expense), style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Transaksi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                Text('Terbaru dahulu', style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 8),

            if (_loading)
              const Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (_items.isEmpty)
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
                    Text('Catat transaksi pertamamu di Beranda', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              )
            else
              Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: _items.map(_item).toList(),
                ),
              ),
            const SizedBox(height: 12),
            const Text(
              'Menampilkan catatan terbaru. Ringkasan di atas mencakup seluruh transaksi.',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
