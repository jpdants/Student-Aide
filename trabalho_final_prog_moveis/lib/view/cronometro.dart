import 'dart:async';
import 'package:flutter/material.dart';
import 'alarme_screen.dart';

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int _seconds = 0;
  Timer? _timer;
  bool _isRunning = false;

  void _toggleTimer() {
    if (_isRunning) {
      _stopTimer();
    } else {
      _startTimer();
    }
  }

  void _startTimer() {
    setState(() {
      _isRunning = true;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _stopTimer() {
    setState(() {
      _isRunning = false;
    });

    _timer?.cancel();
  }

  void _resetTimer() {
    setState(() {
      _seconds = 0;
      _isRunning = false;
    });

    _timer?.cancel();
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String minutesStr = (minutes < 10) ? '0$minutes' : minutes.toString();
    String secondsStr =
        (remainingSeconds < 10) ? '0$remainingSeconds' : remainingSeconds.toString();
    return '$minutesStr:$secondsStr';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer'),
        leading: IconButton(
          icon: Icon(Icons.alarm),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AlarmScreen()),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _formatTime(_seconds),
              style: TextStyle(fontSize: 80),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text(_isRunning ? 'Pare' : 'Comece', style: TextStyle(fontSize: 20)),
                  onPressed: _toggleTimer,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  child: Text('Recomece', style: TextStyle(fontSize: 20)),
                  onPressed: _resetTimer,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
