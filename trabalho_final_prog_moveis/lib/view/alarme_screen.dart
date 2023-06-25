import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AlarmScreen extends StatefulWidget {
  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _alarmName = '';

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  void _saveAlarm() {
    // Save alarm settings and schedule the alarm
    // Implement your logic here
  }

  @override
  Widget build(BuildContext context) {
    final timeFormat = DateFormat('hh:mm a');

    return Scaffold(
      appBar: AppBar(
        title: Text('Set Alarm'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Time:',
              style: TextStyle(fontSize: 18),
            ),
            ListTile(
              title: Text(timeFormat.format(DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
                _selectedTime.hour,
                _selectedTime.minute,
              ))),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: () => _selectTime(context),
            ),
            SizedBox(height: 20),
            Text(
              'Alarm Name:',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter alarm name',
              ),
              onChanged: (value) {
                setState(() {
                  _alarmName = value;
                });
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _saveAlarm,
                  child: Text('Save Alarm'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
