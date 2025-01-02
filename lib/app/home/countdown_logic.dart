import 'dart:async';

class Countdown {
  final StreamController<int> _tickController = StreamController<int>.broadcast();
  final StreamController<bool> _isRunningController = StreamController<bool>.broadcast();
  final StreamController<List<String>> _segmentsController = StreamController<List<String>>.broadcast();

  Timer? timer;
  int totalDuration; // Total duration in seconds
  bool isRunning = false;
  int currentSeconds; // Track remaining time manually
  List<int> segments = []; // Store segments in seconds

  Countdown({required this.totalDuration}) : currentSeconds = totalDuration {
    _isRunningController.add(isRunning);
    _segmentsController.add([]);
  }

  Stream<int> get tickStream => _tickController.stream;
  Stream<bool> get isRunningStream => _isRunningController.stream;
  Stream<List<String>> get segmentsStream => _segmentsController.stream;

  void startOrResume() {
    if (isRunning) {
      pause();
    } else {
      startTimer();
    }
  }

  void startTimer() {
    isRunning = true;
    _isRunningController.add(isRunning);
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (currentSeconds > 0) {
        currentSeconds--;
        _tickController.add(currentSeconds);
      } else {
        timer.cancel();
        isRunning = false;
        _isRunningController.add(isRunning);
      }
    });
  }

  void pause() {
    isRunning = false;
    _isRunningController.add(isRunning);
    timer?.cancel();
  }

  void restart(int totalDuration) {
    segments.clear(); // Clear segments when restarting
    this.totalDuration = totalDuration;
    currentSeconds = totalDuration;
    isRunning = false;
    _isRunningController.add(isRunning);
    _tickController.add(currentSeconds);
    _segmentsController.add([]); // Ensure the segments stream is updated on restart
  }

  void markSegment() {
    if (isRunning) {
      final segmentTime = totalDuration - currentSeconds;
      segments.add(segmentTime);
      _segmentsController.add(
          segments.map((s) => "${s ~/ 60}:${(s % 60).toString().padLeft(2, '0')}").toList());
    }
  }

  void dispose() {
    timer?.cancel();
    _tickController.close();
    _isRunningController.close();
    _segmentsController.close();
  }
}