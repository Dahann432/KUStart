import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class ShuttleMain extends StatefulWidget {
  @override
  _ShuttleMainState createState() => _ShuttleMainState();
}

class _ShuttleMainState extends State<ShuttleMain> {
  var directionIcon = const Icon(Icons.east);
  var timeLine = ToSchul().toString();

  @override
  Widget build(BuildContext context) {
    // widget Container
    return Column(
      children: [
        Container(
          height: 170,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 0),
                spreadRadius: 1,
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text(
                  '조치원역',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                const SizedBox(width: 30),
                // direction Button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      // Toggle the container color
                      if (directionIcon.icon == Icons.east) {
                        directionIcon = const Icon(Icons.west);
                        timeLine = ToStation().toString();
                      } else {
                        directionIcon = const Icon(Icons.east);
                        timeLine = ToSchul().toString();
                      }
                    });
                  },
                  child: Container(
                    width: 70,
                    height: 25,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 0),
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: directionIcon,
                  ),
                ),
                const SizedBox(width: 30),
                const Text(
                  '고려대',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                const SizedBox(width: 15)
              ]),
              Text(timeLine)     // 시간 나타내기
            ],
          ),
        ),
        const SizedBox(height: 30),
        Container(
          height: 20,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 0),
                spreadRadius: 1,
              )
            ],
          ),
        )
      ],
    );
  }
}

//조치원역 방향 셔틀
class ToStation extends StatefulWidget {
  const ToStation({super.key});

  @override
  State<ToStation> createState() => _ToStationState();
}

class _ToStationState extends State<ToStation> {
  DateTime now = DateTime.now();
  late Timer timer;
  String remainingTime = '00:00';

  final Map<int, List<int>> schedule = {
    8: [50],
    9: [10, 30, 40, 50],
    10: [10, 30, 40],
    11: [0, 20, 40],
    12: [10, 30, 40],
    13: [10, 30, 50],
    14: [10, 30, 40, 50],
    15: [0, 10, 30, 50],
    16: [10, 30, 50],
    17: [10],
    18: [0, 20],
    19: [0, 30],
    20: [0, 30, 50],
  };

  void updateRemainingTime() {
    DateTime nextTime = calculateNextTime();
    Duration remainingDuration = nextTime.difference(now);

    if (remainingDuration.inSeconds <= 0) {
      remainingTime = '방금 출발쓰';
      timer.cancel();
    } else {
      String formattedRemainingTime =
          '${remainingDuration.inMinutes.toString().padLeft(2, '0')}:${(remainingDuration.inSeconds % 60).toString().padLeft(2, '0')}';
      setState(() {
        remainingTime = formattedRemainingTime;
      });
    }
  }

  DateTime calculateNextTime() {
    int currentHour = now.hour;
    int currentMinute = now.minute;
    int closestHour = currentHour;
    int closestMinute = 0;

    List<int> minutesList = schedule[currentHour] ?? [];

    if (minutesList.isNotEmpty) {
      int minDifference = 60;

      for (int minute in minutesList) {
        int difference = minute - currentMinute;
        if (difference >= 0 && difference < minDifference) {
          minDifference = difference;
          closestMinute = minute;
        }
      }

      if (closestMinute < currentMinute) {
        closestHour++;
        closestMinute = minutesList[0];
      }
    } else {
      while (!schedule.containsKey(closestHour)) {
        closestHour++;
        closestMinute = 0;
      }
    }

    DateTime nextTime =
        DateTime(now.year, now.month, now.day, closestHour, closestMinute);
    return nextTime;
  }

  @override
  void initState() {
    super.initState();
    updateRemainingTime();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      now = DateTime.now();
      updateRemainingTime();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(remainingTime,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 70,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w800,
          height: 0,
        ));
  }
}

// 고려대 방향 셔틀
class ToSchul extends StatefulWidget {
  ToSchul({Key? key}) : super(key: key);

  @override
  _ToSchulState createState() => _ToSchulState();
}

class _ToSchulState extends State<ToSchul> {
  DateTime now = DateTime.now();
  late Timer timer;
  String remainingTime = '00:00';

  final Map<int, List<int>> schedule = {
    8: [20, 30, 40, 50],
    9: [0, 20, 40, 50],
    10: [0, 20, 40, 50],
    11: [10, 30, 50],
    12: [20, 40, 50],
    13: [20, 40],
    14: [0, 20, 40],
    15: [10, 20, 40],
    16: [0, 20, 40],
    17: [0, 20, 35, 50],
    18: [10, 30],
    19: [10, 40],
    20: [10, 40],
    21: [0],
  };

  void updateRemainingTime() {
    DateTime nextTime = calculateNextTime();
    Duration remainingDuration = nextTime.difference(now);

    if (remainingDuration.inSeconds <= 0) {
      remainingTime = '방금 출발쓰';
      timer.cancel();
    } else {
      String formattedRemainingTime =
          '${remainingDuration.inMinutes.toString().padLeft(2, '0')}:${(remainingDuration.inSeconds % 60).toString().padLeft(2, '0')}';
      setState(() {
        remainingTime = formattedRemainingTime;
      });
    }
  }

  DateTime calculateNextTime() {
    int currentHour = now.hour;
    int currentMinute = now.minute;
    int closestHour = currentHour;
    int closestMinute = 0;

    List<int> minutesList = schedule[currentHour] ?? [];

    if (minutesList.isNotEmpty) {
      int minDifference = 60;

      for (int minute in minutesList) {
        int difference = minute - currentMinute;
        if (difference >= 0 && difference < minDifference) {
          minDifference = difference;
          closestMinute = minute;
        }
      }

      if (closestMinute < currentMinute) {
        closestHour++;
        closestMinute = minutesList[0];
      }
    } else {
      while (!schedule.containsKey(closestHour)) {
        closestHour++;
        closestMinute = 0;
      }
    }

    DateTime nextTime =
        DateTime(now.year, now.month, now.day, closestHour, closestMinute);
    return nextTime;
  }

  @override
  void initState() {
    super.initState();
    updateRemainingTime();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      now = DateTime.now();
      updateRemainingTime();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(remainingTime,
        style: const TextStyle(
            color: Colors.black,
            fontSize: 70,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w800,
            height: 0));
  }
}

class FlipArrowAnimation extends StatefulWidget {
  const FlipArrowAnimation({super.key});

  @override
  State<FlipArrowAnimation> createState() => _FlipArrowAnimationState();
}

class _FlipArrowAnimationState extends State<FlipArrowAnimation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 25,
      margin: const EdgeInsets.only(top: 20),
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        front: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 70,
              height: 25,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 0),
                    spreadRadius: 2,
                  )
                ],
              ),
            ),
            const Icon(
              Icons.east,
              color: Colors.black,
            ),
          ],
        ),
        back: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 70,
              height: 25,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 0),
                    spreadRadius: 2,
                  )
                ],
              ),
            ),
            const Icon(
              Icons.west,
              color: Colors.black,
            ),
          ],
        ),
        onFlip: () {
          print('dd');
        },
      ),
    );
  }
}
