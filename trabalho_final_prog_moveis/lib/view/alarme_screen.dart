import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/app_colors.dart';
import 'clock_view.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key? key}) : super(key: key);

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
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.person_2_outlined),
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
      backgroundColor: AppColors.kSecondaryColor,
      body: SingleChildScrollView( // Wrap the main Column with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: ClockView(size: 250),
              ),
              const SizedBox(height: 20),
              const Text(
                'Selecione o tempo:',
                style: TextStyle(
                  fontFamily: 'avenir',
                  color: AppColors.kTextStyle,
                  fontSize: 24,
                ),
              ),
              ListTile(
                title: Container(
                  width: double.infinity,
                  child: Text(
                    timeFormat.format(DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      _selectedTime.hour,
                      _selectedTime.minute,
                    )),
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
                trailing: const Icon(Icons.keyboard_arrow_down),
                onTap: () => _selectTime(context),
              ),
              const SizedBox(height: 10),
              const Text(
                'Nome do Alarme',
                style: TextStyle(
                  fontFamily: 'avenir',
                  color: AppColors.kTextStyle,
                  fontSize: 24,
                ),
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Coloque o nome do alarme',
                  hintStyle: TextStyle(
                    fontFamily: 'avenir',
                    fontSize: 18,
                  ),
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
                    style: ElevatedButton.styleFrom(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      backgroundColor: AppColors.kPrimaryColor,
                    ),
                    child: const Text(
                      'Salvar',
                      style: TextStyle(
                        fontFamily: 'avenir',
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      backgroundColor: AppColors.kPrimaryColor,
                    ),
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(
                        fontFamily: 'avenir',
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
