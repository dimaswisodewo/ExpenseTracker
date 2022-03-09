class Transaction {
  final String id;
  final String title;
  final TransactionType type;
  final double amount;
  final DateTime date;

  Transaction({
    required this.id,
    required this.title,
    required this.type,
    required this.amount,
    required this.date,
  });
}

enum TransactionType {
  Outcome,
  Income,
}
