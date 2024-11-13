import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lenden/functions/core/reminders_provider.dart';
import 'package:lenden/functions/reminder_handler.dart';
import 'package:lenden/screen/set_reminder.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    final reminders = ref.watch(notificationProvider);
    final notifier = ref.read(remindersProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: reminders.isEmpty
          ? const Center(
              child: Text('No Notifications'),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListView.builder(
                itemCount: reminders.length,
                itemBuilder: (BuildContext context, int index) {
                  final ReminderModel reminder = reminders[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ReminderTile(
                      reminder: reminder,
                      onDelete: () {
                        notifier.deleteReminder(reminder.id);
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}
