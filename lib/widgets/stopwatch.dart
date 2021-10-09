import 'dart:async';

import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  @override
  _StopWatchState createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  bool flag = true;
  Stream<int> timerStream;
  StreamSubscription<int> timerSubscription;
  String hoursStr = '00';
  String minutesStr = '00';
  String secondsStr = '00';

  Stream<int> stopWatchStream() {
    StreamController<int> streamController;
    Timer timer;
    Duration timerInterval = Duration(seconds: 1);
    int counter = 0;

    void stopTimer() {
      if (timer != null) {
        timer.cancel();
        timer = null;
        counter = 0;
        streamController.close();
      }
    }

    void tick(_) {
      counter++;
      streamController.add(counter);
      if (!flag) {
        stopTimer();
      }
    }

    void startTimer() {
      timer = Timer.periodic(timerInterval, tick);
    }

    streamController = StreamController<int>(
      onListen: startTimer,
      onCancel: stopTimer,
      onResume: startTimer,
      onPause: stopTimer,
    );

    return streamController.stream;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$hoursStr:$minutesStr:$secondsStr",
            style: TextStyle(
              fontSize: 90.0,
            ),
          ),
          SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  timerStream = stopWatchStream();
                  timerSubscription = timerStream.listen((int newTick) {
                    setState(() {
                      hoursStr = ((newTick / (60 * 60)) % 60)
                          .floor()
                          .toString()
                          .padLeft(2, '0');
                      minutesStr = ((newTick / 60) % 60)
                          .floor()
                          .toString()
                          .padLeft(2, '0');
                      secondsStr =
                          (newTick % 60).floor().toString().padLeft(2, '0');
                    });
                  });
                },
                child: Text(
                  'START',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                ),
              ),
              SizedBox(width: 40.0),
              ElevatedButton(
                onPressed: () {
                  timerSubscription.cancel();
                  timerStream = null;
                  setState(() {
                    hoursStr = '00';
                    minutesStr = '00';
                    secondsStr = '00';
                  });
                },
                child: Text(
                  'RESET',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
