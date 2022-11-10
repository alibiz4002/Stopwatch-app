import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: HomeApp(),
  ));
}

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HpmeAppState();
}

class _HpmeAppState extends State<HomeApp> {
  // The business logic of the app
  int seconds = 0, minutes = 0, hours = 0;
  String digitSeconds = '00', digitMinutes = '00', digitHours = '00';
  Timer? timer;
  bool started = false;
  List laps = [];

  // Creating the stop timer function
  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  // Creating the reset of function

  void reset() {
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;

      digitSeconds = '00';
      digitMinutes = '00';
      digitHours = '00';

      started = false;
    });
  }

  void addLaps() {
    String lap =
        '$digitHours:$digitMinutes:$digitSeconds'.toString().padLeft(2, '0');
    setState(() {
      laps.add(lap);
    });
  }

// creating the start timer function
  void start() {
    started = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int localSeconds = seconds + 1;
      int localMinuts = minutes;
      int localHours = hours;

      if (localSeconds > 59) {
        if (localMinuts > 59) {
          localHours++;
          localMinuts = 0;
        } else {
          localMinuts++;
          localSeconds = 0;
        }
      }
      setState(() {
        seconds = localSeconds;
        minutes = localMinuts;
        hours = localHours;
        digitSeconds = (seconds >= 10)
            ? '$seconds'
            : '$seconds'.toString().padLeft(2, '0');
        digitMinutes = (minutes >= 10)
            ? '$minutes'
            : '$minutes'.toString().padLeft(2, '0');

        digitHours =
            (hours >= 10) ? '$hours' : '$hours'.toString().padLeft(2, '0');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C2757),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  'StopWatch App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Center(
                child: Text(
                  '$digitHours:$digitMinutes:$digitSeconds',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 82.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                  height: 400.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFF323F68),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  // Adding a list builder
                  child: ListView.builder(
                    itemCount: laps.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'lap n°${index + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                            Text(
                              '${laps[index]}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  )),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        (!started) ? start() : stop();
                      },
                      shape: const StadiumBorder(
                        side: BorderSide(color: Colors.blue),
                      ),
                      child: Text(
                        (!started) ? 'Start' : 'Pause',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  IconButton(
                    color: Colors.white,
                    onPressed: () {
                      addLaps();
                    },
                    icon: const Icon(Icons.flag),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        reset();
                      },
                      fillColor: Colors.blue,
                      shape: const StadiumBorder(),
                      child: const Text(
                        'Reset',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            ]),
      )),
    );
  }
}
