import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class ShuttleMain extends StatefulWidget {
  @override
  _ShuttleMainState createState() => _ShuttleMainState();
}

class _ShuttleMainState extends State<ShuttleMain> {
  var directionIcon = const Icon(Icons.east);
  late Widget timeWidget = ToCampus();

  @override
  void initState() {
    super.initState();
  }

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
                blurRadius: 0.5,
                offset: Offset(0, 0),
                spreadRadius: 0.5,
              )
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 15),
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
                        timeWidget = ToStation();
                      } else {
                        directionIcon = const Icon(Icons.east);
                        timeWidget = ToCampus();
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
                          blurRadius: 0.5,
                          offset: Offset(0, 0),
                          spreadRadius: 0.5,
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
                const SizedBox(width: 10)
              ]),
              Container(
                  height: 125, alignment: Alignment.center, child: timeWidget)
              // 시간 위젯
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 90,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 0.5,
                offset: Offset(0, 0),
                spreadRadius: 0.5,
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '이번 셔틀',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w800,
                        height: 0,
                      ),
                    ),
                    Text(
                      '14시 30분',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w800,
                        height: 0,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 300,
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 0.30,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0xFF7B2D35),
                      ),
                    ),
                  ),
                ),
              ),
              const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '다음 셔틀',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w800,
                        height: 0,
                      ),
                    ),
                    Text(
                      '14시 50분',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w800,
                        height: 0,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//조치원역 방향 셔틀
class ToStation extends StatefulWidget {
  ToStation({Key? key}) : super(key: key);

  @override
  State<ToStation> createState() => _ToStationState();
}

class _ToStationState extends State<ToStation> {
  DateTime now = DateTime.now();
  late Timer timer;
  bool biggerText = true;
  String remainingTime = '운행 종료';

  // 시간표 정보
  final Map<int, List<int>> scheduleWeekday = {
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

  final Map<int, List<int>> scheduleSunday = {
    17: [0, 40],
    18: [40],
    19: [0, 40],
    20: [20],
    21: [10],
  };

  @override
  void initState() {
    super.initState();
    if (!isScheduleOver()) {
      updateRemainingTime();
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        now = DateTime.now();
        updateRemainingTime();
      });
    } else {
      timer = Timer.periodic(Duration(seconds: 1), (timer) {});
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void updateRemainingTime() {
    DateTime nextTime = calculateNextTime();
    Duration remainingDuration = nextTime.difference(now);

    if (remainingDuration.inHours >= 1) {
      int hours = remainingDuration.inHours;
      setState(() {
        biggerText = true;
        remainingTime = '$hours 시간 남음';
      });
    } else if (remainingDuration.inSeconds < 60 && remainingDuration.inSeconds >= 0) {
      setState(() {
        biggerText = true;
        remainingTime = '곧 출발쓰'; // 1분 이내 출발일 경우 메시지 변경
      });
    } else {
      String formattedRemainingTime =
          '${remainingDuration.inMinutes.toString().padLeft(2, '0')}:${(remainingDuration.inSeconds % 60).toString().padLeft(2, '0')}';
      setState(() {
        biggerText = false;
        remainingTime = formattedRemainingTime;
      });
    }
  }

  bool isScheduleOver() {
    Map<int, List<int>> scheduleToUse;

    int currentDay = now.weekday;
    if (currentDay == DateTime.sunday) {
      scheduleToUse = scheduleSunday;
    } else {
      scheduleToUse = scheduleWeekday;
    }

    if (scheduleToUse.isEmpty) return true;

    int lastKey = scheduleToUse.keys.reduce((a, b) => a > b ? a : b);
    int lastValue =
        scheduleToUse[lastKey]?.reduce((a, b) => a > b ? a : b) ?? 0;

    int currentHour = now.hour;
    int currentMinute = now.minute;

    return currentHour > lastKey ||
        (currentHour == lastKey && currentMinute > lastValue);
  }

  DateTime calculateNextTime() {
    int currentHour = now.hour;
    int currentMinute = now.minute;
    int closestHour = currentHour;
    int closestMinute = 0;

    Map<int, List<int>> scheduleToUse;

    int currentDay = now.weekday;
    if (currentDay == DateTime.sunday) {
      scheduleToUse = scheduleSunday;
    } else {
      scheduleToUse = scheduleWeekday;
    }

    List<int> minutesList = scheduleToUse[currentHour] ?? [];

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
      while (!scheduleToUse.containsKey(closestHour)) {
        closestHour++;
        closestMinute = 0;
        if (scheduleToUse.containsKey(closestHour)) {
          closestMinute = 50;
        }
      }
    }

    DateTime nextTime =
        DateTime(now.year, now.month, now.day, closestHour, closestMinute);
    return nextTime;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      remainingTime,
      style: biggerText
          ? const TextStyle(
              color: Colors.black,
              fontSize: 50,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w800,
              height: 0,
            )
          : const TextStyle(
              color: Colors.black,
              fontSize: 70,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w800,
              height: 0,
            ),
    );
  }
}

// 고려대 방향 셔틀
class ToCampus extends StatefulWidget {
  ToCampus({Key? key}) : super(key: key);

  @override
  _ToCampusState createState() => _ToCampusState();
}

class _ToCampusState extends State<ToCampus> {
  DateTime now = DateTime.now();
  late Timer timer;
  bool biggerText = true;
  String remainingTime = '운행 종료';

  final Map<int, List<int>> scheduleWeekday = {
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

  final Map<int, List<int>> scheduleSunday = {
    16: [40],
    17: [10, 50],
    18: [50],
    19: [10, 50],
    20: [35],
    21: [20],
  };

  @override
  void initState() {
    super.initState();
    if (!isScheduleOver()) {
      updateRemainingTime();
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        now = DateTime.now();
        updateRemainingTime();
      });
    } else {
      timer = Timer.periodic(Duration(seconds: 1), (timer) {});
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void updateRemainingTime() {
    DateTime nextTime = calculateNextTime();
    Duration remainingDuration = nextTime.difference(now);

    if (remainingDuration.inHours >= 1) {
      int hours = remainingDuration.inHours;
      setState(() {
        biggerText = true;
        remainingTime = '$hours 시간 남음';
      });
    } else if (remainingDuration.inSeconds < 60 && remainingDuration.inSeconds >= 0) {
      setState(() {
        biggerText = true;
        remainingTime = '곧 출발쓰'; // 1분 이내 출발일 경우 메시지 변경
      });
    } else {
      String formattedRemainingTime =
          '${remainingDuration.inMinutes.toString().padLeft(2, '0')}:${(remainingDuration.inSeconds % 60).toString().padLeft(2, '0')}';
      setState(() {
        biggerText = false;
        remainingTime = formattedRemainingTime;
      });
    }
  }

  bool isScheduleOver() {
    Map<int, List<int>> scheduleToUse;

    int currentDay = now.weekday;
    if (currentDay == DateTime.sunday) {
      scheduleToUse = scheduleSunday;
    } else {
      scheduleToUse = scheduleWeekday;
    }

    if (scheduleToUse.isEmpty) return true;

    int lastKey = scheduleToUse.keys.reduce((a, b) => a > b ? a : b);
    int lastValue =
        scheduleToUse[lastKey]?.reduce((a, b) => a > b ? a : b) ?? 0;

    int currentHour = now.hour;
    int currentMinute = now.minute;

    return currentHour > lastKey ||
        (currentHour == lastKey && currentMinute > lastValue);
  }

  DateTime calculateNextTime() {
    int currentHour = now.hour;
    int currentMinute = now.minute;
    int closestHour = currentHour;
    int closestMinute = 0;

    Map<int, List<int>> scheduleToUse;

    int currentDay = now.weekday;
    if (currentDay == DateTime.sunday) {
      scheduleToUse = scheduleSunday;
    } else {
      scheduleToUse = scheduleWeekday;
    }

    List<int> minutesList = scheduleToUse[currentHour] ?? [];

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
      while (!scheduleToUse.containsKey(closestHour)) {
        closestHour++;
        closestMinute = 0;
        if (scheduleToUse.containsKey(closestHour)) {
          closestMinute = 50;
        }
      }
    }

    DateTime nextTime =
        DateTime(now.year, now.month, now.day, closestHour, closestMinute);
    return nextTime;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      remainingTime,
      style: biggerText
          ? const TextStyle(
              color: Colors.black,
              fontSize: 50,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w800,
              height: 0,
            )
          : const TextStyle(
              color: Colors.black,
              fontSize: 70,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w800,
              height: 0,
            ),
    );
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
        front: const Icon(
          Icons.east,
          color: Colors.black,
        ),
        back: const Icon(
          Icons.west,
          color: Colors.black,
        ),
        onFlip: () {
          print('dd');
        },
      ),
    );
  }
}
