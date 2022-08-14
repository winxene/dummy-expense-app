import 'package:sqflite/sqflite.dart' as sql;
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import '../models/transaction.dart' as template_data;

//database helper functions as a class to create a database
class DatabaseHelper {
  static Future<sql.Database> database() async {
    final databasePath = await sql.getDatabasesPath();
    final String myDatabasePath = path.join(databasePath, 'transactions.db');
    return sql.openDatabase(myDatabasePath, version: 1,
        onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE ${template_data.Transaction.tableName}(id TEXT PRIMARY KEY, month TEXT, dateRegistered TEXT, title TEXT, amount INTEGER )');
    });
  }

  static Future<void> appendDatabase(
      template_data.Transaction transaction) async {
    final database = await DatabaseHelper.database();
    await database.insert(template_data.Transaction.tableName, {
      'id': transaction.id,
      'month': transaction.month,
      'title': transaction.title,
      'amount': transaction.amount,
      'dateRegistered': transaction.dateRegistered,
    });
  }

  static Future<void> deleteDatabase(String id) async {
    final database = await DatabaseHelper.database();
    await database.delete(template_data.Transaction.tableName,
        where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<template_data.Transaction>> readDatabase(
      String month) async {
    final database = await DatabaseHelper.database();
    final List<Map<String, dynamic>> rowsOfData = await database.query(
        template_data.Transaction.tableName,
        where: "month = ?",
        whereArgs: [month]);
    return rowsOfData
        .map((transaction) => template_data.Transaction(
              id: transaction['id'].toString(),
              month: transaction['month'].toString(),
              title: transaction['title'].toString(),
              amount: transaction['amount'].toInt(),
              dateRegistered: transaction['dateRegistered'].toString(),
            ))
        .toList();
  }
}
