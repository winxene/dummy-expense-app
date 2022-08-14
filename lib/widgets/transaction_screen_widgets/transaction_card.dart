import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/transaction_provider.dart';
import '../../models/transaction.dart';
import '../../components/snack_bar.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  // ignore: use_key_in_widget_constructors
  const TransactionCard({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
          leading: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => {
              if (transaction.id != null)
                {
                  context
                      .read<TransactionProvider>()
                      .deleteTransaction(transaction, transaction.month),
                  context.read<TransactionProvider>().getSpendingSum(),
                  showSnackBar(context, 'Transaction Deleted'),
                }
              else
                {
                  showSnackBar(context, 'An unexpected error occured'),
                }
            },
          ),
          title: Text(
            transaction.title,
          ),
          subtitle: Text(
            transaction.dateRegistered,
          ),
          trailing: Text(
            'Rp ${transaction.amount}',
          )),
    );
  }
}
