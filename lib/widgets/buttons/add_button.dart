import 'package:finalmade/providers/transaction_provider.dart';
import 'package:intl/intl.dart';
import '../transaction_screen_widgets/new_transaction.dart';
import '../../models/transaction.dart' as template_data;
import 'package:flutter/material.dart';

TransactionProvider transactionProvider = TransactionProvider();

// ignore: use_key_in_widget_constructors
class AddButton extends StatelessWidget {
  @override
  FloatingActionButton build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (_) {
              return NewTransaction();
            });
      },
      backgroundColor: Theme.of(context).primaryColor,
      child: const Icon(Icons.add),
    );
  }
}
