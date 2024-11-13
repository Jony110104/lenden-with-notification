import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lenden/config/toast.dart';
import 'package:lenden/functions/core/input_decor.dart';
import 'package:lenden/functions/core/reminders_provider.dart';
import 'package:lenden/functions/reminder_handler.dart';

class EditReminderBottomSheet extends ConsumerStatefulWidget {
  const EditReminderBottomSheet({super.key, required this.reminder});
  final ReminderModel reminder;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditReminderBottomSheetState();
}

class _EditReminderBottomSheetState
    extends ConsumerState<EditReminderBottomSheet> {
  String _reminderType = ReminderHandler.types.first;
  String _amount = '';
  DateTime _date = DateTime.now();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _time = TextEditingController();
  @override
  void initState() {
    super.initState();
    _reminderType = widget.reminder.reminderType;
    _amount = widget.reminder.amount;
    _date = widget.reminder.time;
    String dateString = DateFormat.yMd().add_jm().format(_date);
    _time.text = dateString;
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(remindersProvider);
    final notifier = ref.read(remindersProvider.notifier);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 20),
            const Center(
              child: Text('Edit Reminder',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
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
              initialValue: _amount,
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
                    maxTime: DateTime.now().add(const Duration(days: 3650)),
                    onConfirm: (date) {
                  setState(() {
                    _date = date;
                    String dateString = DateFormat.yMd().add_jm().format(date);
                    _time.text = dateString;
                  });
                }, currentTime: DateTime.now(), locale: picker.LocaleType.en);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    notifier.updateReminder(
                        ReminderModel(
                          reminderType: _reminderType,
                          amount: _amount,
                          time: _date,
                        ),
                        widget.reminder.id, callBack: () {
                      if (_date.isAfter(DateTime.now())) {
                        Toast.showSuccess(context, 'Reminder Upodated');
                        Navigator.pop(context);
                      }
                    });
                  }
                },
                child: const Text('Update Reminder')),
          ],
        ),
      ),
    );
  }
}
