import 'dart:convert';

import 'package:lenden/config/StorageService.dart';

class TranscationsHandler {
  static double balance = 0.0;

  static const String _dataName = 'transactions';
  static final StorageService _storageService = StorageService();

  static void saveTransactions(String data) async {
    await _storageService.saveData(_dataName, data);
  }

  static Future<List<dynamic>> getTransactions(double amount) async {
    String? data = await _storageService.getData('transactions');
    List<dynamic> transactions = [];
    List<dynamic> jsonList = [];
    if (data != null) {
      jsonList = jsonDecode(data);
    }
    transactions = jsonList;
    return transactions;
  }
}
