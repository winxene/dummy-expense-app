import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';
import '../models/transaction.dart' as template_data;

class TransactionProvider with ChangeNotifier {
  List<template_data.Transaction> transactions = [];
  List<template_data.Transaction> get _transactions {
    return [...transactions];
  }

  List<Map<String, dynamic>> monthlyTransactionSummaries = [];

  Future<void> addTransaction(
      template_data.Transaction transaction, String month) async {
    await DatabaseHelper.appendDatabase(transaction);
    getTransactionsByMonth(month);
  }

  Future<void> deleteTransaction(
      template_data.Transaction transaction, String month) async {
    await DatabaseHelper.deleteDatabase(transaction.id ?? '');
    getTransactionsByMonth(month);
  }

  Future<void> getTransactionsByMonth(String month) async {
    await DatabaseHelper.readDatabase(month).then((value) {
      transactions = value;
      notifyListeners();
    });
  }

  Future<void> getSpendingSum() async {
    List<Map<String, dynamic>> temp = [];
    for (var month in template_data.Transaction.months) {
      int count = 0;
      // count spend
      await DatabaseHelper.readDatabase(month).then((value) {
        value.forEach((element) {
          count += element.amount;
        });
        temp.add({
          'month': month,
          'amount': count,
        });
      });
      monthlyTransactionSummaries = temp;
      notifyListeners();
    }
  }
}
