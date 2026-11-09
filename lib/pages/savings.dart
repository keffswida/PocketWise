import 'package:flutter/material.dart';
import 'package:pocketwise/services/transaction_service.dart';

class SavingsPage extends StatefulWidget {
  const SavingsPage({super.key});

  @override
  State<SavingsPage> createState() => _SavingsPageState();
}

class _SavingsPageState extends State<SavingsPage> {
  int _target = 2000000;
  int _saved = 0;
  bool _loading = true;
  bool _saving = false;
  final _targetController = TextEditingController();
  final _savedController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _targetController.dispose();
    _savedController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final target = await TransactionService.loadSavingsTarget();
    final saved = await TransactionService.loadSavingsSaved();
    if (!mounted) return;
    setState(() {
      _target = target;
      _saved = saved;
      _targetController.text = target.toString();
      _savedController.text = saved.toString();
      _loading = false;
    });
  }

  int get _remaining => (_target - _saved) < 0 ? 0 : _target - _saved;
  bool get _reached => _target > 0 && _saved >= _target;
  double get _progress => _target <= 0 ? 0 : (_saved / _target).clamp(0.0, 1.0);
  int get _monthly => (_remaining / 6).round();

  String _rp(int v) {
    final s = v.abs().toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
      buf.write(s[i]);
    }
    return 'Rp ${v < 0 ? '-' : ''}${buf.toString()}';
  }

  Future<void> _saveSavings() async {
    final target = int.tryParse(_targetController.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    final saved = int.tryParse(_savedController.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    if (target <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Target tabungan harus lebih dari 0')));
      return;
    }
    setState(() => _saving = true);
    await TransactionService.saveSavings(target, saved);
    await _load();
    if (!mounted) return;
    setState(() => _saving = false);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tabungan disimpan')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const SizedBox(height: 16),
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
                        Text(
                          _rp(_saved),
                          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'dari target ${_rp(_target)}',
                              style: const TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            Text(
                              '${(_progress * 100).round()}% tercapai',
                              style: const TextStyle(
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
                            value: _progress,
                            minHeight: 8,
                            backgroundColor: Colors.green.shade100,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _reached
                              ? 'Target tabunganmu sudah tercapai!'
                              : '${_rp(_remaining)} lagi menuju targetmu.',
                          style: TextStyle(
                            color: _reached ? Colors.green : Colors.grey,
                            fontWeight: _reached ? FontWeight.w600 : FontWeight.normal,
                            fontSize: 12,
                          ),
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
                  const Text(
                    'Target tabungan',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _targetController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Rp 2.000.000',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Tabungan terkumpul',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _savedController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Rp 500.000',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _saving ? null : _saveSavings,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      icon: _saving
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.check, size: 20),
                      label: Text(
                        _saving ? 'Menyimpan...' : 'Simpan tabungan',
                        style: const TextStyle(fontWeight: FontWeight.w600),
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
                        Text(
                          '${_rp(_monthly)} / bulan',
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Selama 6 bulan ke depan: November 2026–April 2027.',
                          style: TextStyle(color: Colors.green, fontSize: 13),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Sisa ${_rp(_remaining)} ÷ 6 bulan. Sisihkan secara rutin agar targetmu tercapai.',
                          style: const TextStyle(color: Colors.grey, fontSize: 13),
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
      ),
    );
  }
}
