import 'dart:async';
import 'package:flutter/material.dart';
import 'alarme_screen.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

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

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Cronômetro'),
            IconButton(
              icon: const Icon(Icons.alarm),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AlarmScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _formatTime(_seconds),
              style: const TextStyle(fontSize: 80),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _toggleTimer,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: Text(_isRunning ? 'Pare' : 'Comece', style: const TextStyle(fontSize: 20)),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _resetTimer,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: const Text('Recomece', style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
