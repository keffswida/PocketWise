enum TransactionType { income, expense }

class Transaction {
  final String id;
  final TransactionType type;
  final int amount;
  final String category;
  final String note;
  final DateTime date;

  Transaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.category,
    required this.note,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type.name,
    'amount': amount,
    'category': category,
    'note': note,
    'date': date.toIso8601String(),
  };

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    id: json['id'] as String,
    type: TransactionType.values.byName(json['type'] as String),
    amount: json['amount'] as int,
    category: json['category'] as String,
    note: json['note'] as String,
    date: DateTime.parse(json['date'] as String),
  );
}
