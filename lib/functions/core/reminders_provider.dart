import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lenden/functions/reminder_handler.dart';
import 'package:lenden/services/logger.dart';

final remindersProvider =
    NotifierProvider<RemindersNotifier, List<ReminderModel>>(
        RemindersNotifier.new);

final notificationProvider = Provider<List<ReminderModel>>((ref) {
  return ref.watch(remindersProvider).where((ReminderModel reminder) {
    return reminder.time.isBefore(DateTime.now());
  }).toList();
});

final upcomingReminderProvider = Provider<List<ReminderModel>>((ref) {
  return ref.watch(remindersProvider).where((ReminderModel reminder) {
    return reminder.time.isAfter(DateTime.now());
  }).toList();
});

class RemindersNotifier extends Notifier<List<ReminderModel>> {
  @override
  List<ReminderModel> build() {
    Future.microtask(() {
      getReminders();
    });
    return <ReminderModel>[];
  }

  void getReminders() async {
    final reminders = await ReminderHandler.getReminders();
    Log.info('Reminders: ${reminders.length}');
    state = reminders;
  }

  void addReminder(ReminderModel reminder, void Function() callBack) {
    ReminderHandler.addNewReminder(reminder, () {
      callBack();
      getReminders();
    });
  }

  Future<void> updateReminder(ReminderModel reminder, int id,
      {void Function()? callBack}) async {
    await deleteReminder(id);
    ReminderHandler.addNewReminder(reminder, () {
      callBack?.call();
      getReminders();
    });
  }

  Future<void> deleteReminder(int id) async {
    await ReminderHandler.deleteReminder(id);
    getReminders();
  }
}
