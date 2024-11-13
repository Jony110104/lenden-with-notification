// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lenden/config/StorageService.dart';
import 'package:lenden/services/logger.dart';
import 'package:lenden/services/notification_service.dart';

class ReminderHandler {
  ReminderHandler._();
  static const List<String> types = [
    'Tution Fee',
    'Rent',
    'Electricity Bill',
    'Water Bill',
    'Internet Bill',
    'Mobile Bill',
    'Credit Card Bill',
    'Insurance',
    'EMI',
    'Tax',
    'Loan',
    'Others',
  ];

  static (String, String) consturctMessage(
      String type, String amount, String date) {
    return ('$type Reminder', 'You have to pay $amount for $type on $date');
  }

  static const String _dataName = 'reminders';
  static final StorageService _storageService = StorageService();

  static void _saveReminders(String data) async {
    await _storageService.saveData(_dataName, data);
  }

  static Future<void> addNewReminder(
      ReminderModel reminder, VoidCallback callBack) async {
    List<ReminderModel> reminders = await getReminders();
    reminders.add(reminder);
    _saveReminders(
        jsonEncode(reminders.map((ReminderModel e) => e.toMap()).toList()));
    NotificationService()
        .scheduleNotification(
      data: reminder,
    )
        .then((value) {
      callBack();
    });
  }

  static Future<void> deleteReminder(int id) async {
    List<ReminderModel> reminders = await getReminders();
    reminders.removeWhere((ReminderModel reminder) => reminder.id == id);
    _saveReminders(
        jsonEncode(reminders.map((ReminderModel e) => e.toMap()).toList()));
    try {
      NotificationService().cancelNotification(id);
    } catch (e) {
      Log.error('Error: $e');
    }
  }

  static Future<List<ReminderModel>> getReminders() async {
    String? data = await _storageService.getData(_dataName);
    List<ReminderModel> reminders = [];
    List<dynamic> jsonList = [];
    if (data != null) {
      jsonList = jsonDecode(data);
    }
    reminders = jsonList
        .map((dynamic json) =>
            ReminderModel.fromMap(json as Map<String, dynamic>))
        .toList();
    return reminders;
  }

  static int generateId(DateTime time) {
    var bytes = utf8.encode(
        '${time.year}${time.month}${time.day}${time.hour}${time.minute}');
    var digest = md5.convert(bytes);
    return digest.hashCode & 0x7FFFFFFF;
  }

  static String formatDate(DateTime date) =>
      DateFormat.yMd().add_jm().format(date);
}

class ReminderModel {
  final String reminderType;
  final String amount;
  final DateTime time;

  int get id => ReminderHandler.generateId(time);
  String get title => '$reminderType Reminder';
  String get timeStr => ReminderHandler.formatDate(time);
  String get body => 'You have to pay $amount for $reminderType on $timeStr';
  ReminderModel({
    required this.reminderType,
    required this.amount,
    required this.time,
  });

  ReminderModel copyWith({
    String? reminderType,
    String? amount,
    DateTime? time,
  }) {
    return ReminderModel(
      reminderType: reminderType ?? this.reminderType,
      amount: amount ?? this.amount,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'reminderType': reminderType,
      'amount': amount,
      'time': time.millisecondsSinceEpoch,
    };
  }

  factory ReminderModel.fromMap(Map<String, dynamic> map) {
    return ReminderModel(
      reminderType: map['reminderType'] as String,
      amount: map['amount'] as String,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
    );
  }
}
