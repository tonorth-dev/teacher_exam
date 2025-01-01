import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

///
/// Test app
///
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Countdown Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CountdownPage(
        title: 'Flutter Demo Countdown',
      ),
    );
  }
}

///
/// Home page with countdown timer and segmented timing
///
class CountdownPage extends StatefulWidget {
  ///
  /// AppBar title
  ///
  final String title;

  /// Home page constructor
  CountdownPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _CountdownPageState createState() => _CountdownPageState();
}

///
/// Page state
///
class _CountdownPageState extends State<CountdownPage> {
  Timer? _timer;
  List<int> _segments = []; // Store segments in seconds
  int _totalDuration = 60; // Initial total duration in seconds (1 minute)
  bool _isRunning = false;
  int _currentSeconds = 60; // Track remaining time manually

  void _startOrResume() {
    if (_isRunning) {
      _pause();
    } else {
      _startTimer();
    }
  }

  void _startTimer() {
    setState(() {
      _isRunning = true;
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (_currentSeconds > 0) {
          setState(() {
            _currentSeconds--;
          });
        } else {
          _timer?.cancel();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Timer is done!')),
          );
        }
      });
    });
  }

  void _pause() {
    setState(() {
      _isRunning = false;
      _timer?.cancel();
    });
  }

  void _restart() {
    setState(() {
      _segments.clear(); // Clear segments when restarting
      _currentSeconds = _totalDuration;
      _isRunning = false;
      _timer?.cancel();
    });
  }

  void _markSegment() {
    if (_isRunning) {
      setState(() {
        _segments.add(_totalDuration - _currentSeconds);
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // Start/Resume button
                  ElevatedButton(
                    child: Text(_isRunning ? 'Pause' : 'Start'),
                    onPressed: _startOrResume,
                  ),
                  // Restart button
                  ElevatedButton(
                    child: Text('Restart'),
                    onPressed: _restart,
                  ),
                  // Mark segment button
                  ElevatedButton(
                    child: Text('Mark Segment'),
                    onPressed: _markSegment,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '${(_currentSeconds ~/ 60).toString().padLeft(2, '0')}:${(_currentSeconds % 60).toString().padLeft(2, '0')}',
                style: TextStyle(fontSize: 48),
              ),
            ),
            const SizedBox(height: 20),
            // Display segments
            _segments.isNotEmpty
                ? Text(
              '分段: ${_segments.map((s) => "${s ~/ 60}:${(s % 60).toString().padLeft(2, '0')}").join(", ")}',
              style: const TextStyle(fontSize: 18),
            )
                : const Text('暂无分段', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}