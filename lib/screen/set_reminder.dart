import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lenden/config/colors.dart';
import 'package:lenden/config/toast.dart';
import 'package:lenden/functions/core/input_decor.dart';
import 'package:lenden/functions/core/reminders_provider.dart';
import 'package:lenden/functions/reminder_handler.dart';
import 'package:lenden/screen/edit_reminder.dart';
import 'package:lenden/widget/custom_tab_bar.dart';

class SetReminderScreen extends ConsumerStatefulWidget {
  const SetReminderScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SetReminderScreenState();
}

class _SetReminderScreenState extends ConsumerState<SetReminderScreen> {
  String _reminderType = ReminderHandler.types.first;
  String _amount = '';
  DateTime _date = DateTime.now();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _time = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final reminders = ref.watch(upcomingReminderProvider);
    final notifier = ref.read(remindersProvider.notifier);
    return Scaffold(
        backgroundColor: MyColor.pageBg,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: MyColor.darkColor,
          title: const Text(
            'Set Reminder',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: CustomTabBar(tabs: const [
            'Add Reminder',
            'View Reminders'
          ], tabsWidgets: [
            Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: _reminderType,
                    decoration: AppInputDecor.inputDecor().copyWith(
                      labelText: 'Reminder Type',
                    ),
                    items: ReminderHandler.types
                        .map((String type) => DropdownMenuItem<String>(
                              value: type,
                              child: Text(type),
                            ))
                        .toList(),
                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() {
                          _reminderType = value;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: AppInputDecor.inputDecor().copyWith(
                      labelText: 'Amount',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter amount';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    onChanged: (String value) {
                      setState(() {
                        _amount = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: AppInputDecor.inputDecor().copyWith(
                      labelText: 'Time',
                    ),
                    controller: _time,
                    readOnly: true,
                    onTap: () async {
                      picker.DatePicker.showDateTimePicker(context,
                          showTitleActions: true,
                          minTime: DateTime.now(),
                          maxTime:
                              DateTime.now().add(const Duration(days: 3650)),
                          onConfirm: (date) {
                        setState(() {
                          _date = date;
                          String dateString =
                              DateFormat.yMd().add_jm().format(date);
                          _time.text = dateString;
                        });
                      },
                          currentTime: DateTime.now(),
                          locale: picker.LocaleType.en);
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          notifier.addReminder(
                              ReminderModel(
                                reminderType: _reminderType,
                                amount: _amount,
                                time: _date,
                              ), () {
                            if (_date.isAfter(DateTime.now())) {
                              Toast.showSuccess(context, 'Reminder Set');
                            }
                          });
                        }
                      },
                      child: const Text('Set Reminder')),
                ],
              ),
            ),
            reminders.isEmpty
                ? const Center(
                    child: Text('No Upcoming Reminders'),
                  )
                : ListView.builder(
                    itemCount: reminders.length,
                    itemBuilder: (BuildContext context, int index) {
                      final ReminderModel reminder = reminders[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ReminderTile(
                          reminder: reminder,
                          insideReminder: true,
                          onDelete: () {
                            notifier.deleteReminder(reminder.id);
                          },
                        ),
                      );
                    },
                  )
          ]),
        ));
  }
}

class ReminderTile extends ConsumerWidget {
  const ReminderTile({
    super.key,
    required this.reminder,
    required this.onDelete,
    this.insideReminder = false,
  });
  final ReminderModel reminder;
  final void Function() onDelete;
  final bool insideReminder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        if (insideReminder) {
          showModalBottomSheet(
            showDragHandle: true,
            context: context,
            builder: (context) {
              return EditReminderBottomSheet(reminder: reminder);
            },
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: MyColor.pageBg,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 2),
            )
          ],
        ),
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(reminder.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                    reminder.body,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete),
            )
          ],
        ),
      ),
    );
  }
}
