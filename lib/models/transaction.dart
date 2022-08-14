class Transaction {
  String? id; // id of the transaction, putting ? makes it nullable
  final String month;
  final String title;
  final int amount;
  final String dateRegistered;

  Transaction({
    this.id,
    required this.month,
    required this.title,
    required this.amount,
    required this.dateRegistered,
  });
  static const String tableName = 'transactions';

  static const List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
}
