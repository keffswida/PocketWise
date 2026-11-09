import 'package:flutter/material.dart';
import 'package:pocketwise/models/transaction.dart';
import 'package:pocketwise/services/transaction_service.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  int _budget = 1000000;
  List<Transaction> _items = [];
  bool _loading = true;
  bool _saving = false;
  final _budgetController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _budgetController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final budget = await TransactionService.loadBudget();
    final data = await TransactionService.load();
    if (!mounted) return;
    setState(() {
      _budget = budget;
      _items = data;
      _budgetController.text = budget.toString();
      _loading = false;
    });
  }

  int get _spent => _items.where((t) => t.type == TransactionType.expense).fold(0, (s, t) => s + t.amount);
  int get _remaining => _budget - _spent;
  bool get _over => _spent > _budget;
  double get _progress => _budget <= 0 ? 0 : (_spent / _budget).clamp(0.0, 1.0);

  String _rp(int v) {
    final s = v.abs().toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
      buf.write(s[i]);
    }
    return 'Rp ${v < 0 ? '-' : ''}${buf.toString()}';
  }

  Future<void> _saveBudget() async {
    final value = int.tryParse(_budgetController.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    if (value <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Anggaran harus lebih dari 0')));
      return;
    }
    setState(() => _saving = true);
    await TransactionService.saveBudget(value);
    await _load();
    if (!mounted) return;
    setState(() => _saving = false);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Anggaran disimpan')));
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());

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

        // Kartu besar: total anggaran + progress
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
                  Text('Total anggaran bulanan', style: TextStyle(color: Colors.grey)),
                  Icon(Icons.pie_chart, color: Colors.blue),
                ],
              ),
              const SizedBox(height: 8),
              Text(_rp(_budget), style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w800)),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Terpakai bulan ini', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Text('${(_progress * 100).round()}%', style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: _progress,
                  minHeight: 8,
                  backgroundColor: Colors.white,
                  color: _over ? Colors.red : Colors.blue,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(_over ? Icons.warning : Icons.check_circle, size: 16, color: _over ? Colors.red : Colors.green),
                  const SizedBox(width: 6),
                  Text(_over ? 'Melebihi anggaran' : 'Masih dalam batas',
                      style: TextStyle(color: _over ? Colors.red : Colors.green, fontWeight: FontWeight.w600, fontSize: 13)),
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
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.north_east, size: 16, color: Colors.orange),
                        SizedBox(width: 6),
                        Text('Sudah terpakai', style: TextStyle(fontSize: 13)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(_rp(_spent), style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.w700)),
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
                        Icon(Icons.account_balance_wallet, size: 16, color: Colors.green),
                        SizedBox(width: 6),
                        Text('Sisa anggaran', style: TextStyle(fontSize: 13)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(_rp(_remaining), style: TextStyle(color: _over ? Colors.red : Colors.green, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        const Text('Atur anggaran bulanan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        const Text('Tentukan satu batas total pengeluaran untuk seluruh kebutuhanmu di bulan Oktober.',
            style: TextStyle(color: Colors.grey, fontSize: 13)),
        const SizedBox(height: 16),
        const Text('Anggaran Oktober 2026', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextField(
          controller: _budgetController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Rp 1.000.000',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _saving ? null : _saveBudget,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            ),
            icon: _saving
                ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : const Icon(Icons.check, size: 20),
            label: Text(_saving ? 'Menyimpan...' : 'Simpan anggaran', style: const TextStyle(fontWeight: FontWeight.w600)),
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
