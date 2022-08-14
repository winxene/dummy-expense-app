import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/transaction.dart';
import 'package:finalmade/components/snack_bar.dart';
import '../../providers/transaction_provider.dart';

import '../../screens/transaction_detail_screen.dart';

TransactionProvider transactionProvider = TransactionProvider();

// ignore: must_be_immutable
class NewTransaction extends StatefulWidget {
  NewTransaction({Key? key}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now())
        .then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _selectedDate = pickedDate;
        });
      },
    );
  }

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = int.parse(_amountController.text);

    if (_amountController.text.isEmpty ||
        enteredTitle.isEmpty ||
        enteredAmount <= 0) {
      return;
    }

    DateFormat format = DateFormat('MMMM');
    String convertedMonth = format.format(_selectedDate);
    String convertedDate = DateFormat('dd/MM/yyyy').format(_selectedDate);
    //playing with provider of SQLite
    final newTransaction = Transaction(
      month: convertedMonth,
      title: enteredTitle,
      amount: enteredAmount,
      dateRegistered: convertedDate,
    );

    context
        .read<TransactionProvider>()
        .addTransaction(newTransaction, convertedMonth);
    context.read<TransactionProvider>().getSpendingSum();
    //pop 2 times so that it goes back directly to the main screen
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TransactionDetailScreen(
          month: convertedMonth,
        ),
      ),
    );
    showSnackBar(context, 'Transaction added successfully');
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          TextField(
            decoration: const InputDecoration(
                labelText: 'Title', hintText: 'Enter Title'),
            controller: _titleController,
          ),
          TextField(
            decoration: const InputDecoration(
                labelText: 'Price', hintText: 'Enter Price in Rupiah'),
            controller: _amountController,
            keyboardType: TextInputType.number,
          ),
          Row(
            children: [
              Expanded(
                child: Text(_selectedDate == null
                    ? 'No Date Chosen!'
                    : 'Picked Date: ${DateFormat.yMMMEd().format(_selectedDate)}'),
              ),
              TextButton(
                onPressed: () {
                  _presentDatePicker();
                },
                child: const Text('Choose Date'),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () => _submitData(),
            child: const Text('Add Transaction'),
          ),
        ],
      );
}
