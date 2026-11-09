import 'dart:convert';

import 'package:pocketwise/models/transaction.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionService {
  static const _key = 'transactions';

  // Baca semua transaksi
  static Future<List<Transaction>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list
        .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // Simpan seluruh daftar
  static Future<void> save(List<Transaction> items) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = jsonEncode(items.map((e) => e.toJson()).toList());
    await prefs.setString(_key, raw);
  }

  // Tambah satu transaksi
  static Future<void> add(Transaction t) async {
    final items = await load();
    items.add(t);
    await save(items);
  }
}
