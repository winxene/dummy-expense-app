// ignore_for_file: library_private_types_in_public_api
import 'package:finalmade/providers/transaction_provider.dart';
import 'package:finalmade/widgets/buttons/add_button.dart';
import 'package:finalmade/widgets/transaction_screen_widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './../widgets/buttons/change_theme_button.dart';

class TransactionDetailScreen extends StatefulWidget {
  final String month;
  const TransactionDetailScreen({
    Key? key,
    required this.month,
  }) : super(key: key);

  @override
  _TransactionDetailScreenState createState() =>
      _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Detail ${widget.month}',
            style: widget.month.length <= 7
                ? const TextStyle(fontSize: 18)
                : const TextStyle(fontSize: 16)),
        actions: <Widget>[ChangeThemeButton()],
      ),
      body: FutureBuilder<void>(
        future: context
            .read<TransactionProvider>()
            .getTransactionsByMonth(widget.month),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.error != null) {
            return const Center(
              child: Text('An error occurred'),
            );
          } else {
            return Consumer<TransactionProvider>(
                builder: (ctx, provider, child) {
              if (provider.transactions.isEmpty) {
                return const Center(
                  child: Text('No transactions, press "+" to add one'),
                );
              }
              return ListView.builder(
                itemCount: provider.transactions.length,
                itemBuilder: (ctx, i) {
                  final showTransaction = provider.transactions[i];
                  return TransactionCard(
                    transaction: showTransaction,
                  );
                },
              );
            });
          }
        },
      ),
      floatingActionButton: AddButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
