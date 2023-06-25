import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/app_colors.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _alarmName = '';
  int? selectedHour;
  int? selectedMinute;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
        selectedHour = _selectedTime.hour;
        selectedMinute = _selectedTime.minute;
      });
    }
  }

  void _saveAlarm() {
    // Save alarm settings and schedule the alarm
    // Implement your logic here
  }

  @override
  void initState() {
    super.initState();
    selectedHour = _selectedTime.hour;
    selectedMinute = _selectedTime.minute;
  }

  @override
  Widget build(BuildContext context) {
    final timeFormat = DateFormat('HH:mm');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [            
            const Text(
              'Alarme',
              style: TextStyle(
              fontFamily: 'avenir',
              color: AppColors.kTextStyle,
              fontSize: 24
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.person_2_outlined
              ),
              onPressed: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => const Login()),
              //   );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selecione o tempo:',
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
              trailing: const Icon(Icons.keyboard_arrow_down),
              onTap: () => _selectTime(context),
            ),
            const SizedBox(height: 20),
            const Text(
              'Nome do Alarme',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Coloque o nome do alarme',
              ),
              onChanged: (value) {
                setState(() {
                  _alarmName = value;
                });
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _saveAlarm,
                  child: const Text('Salvar'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancelar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
