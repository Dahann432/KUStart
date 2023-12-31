import 'package:flutter/material.dart';
import 'package:kustart/responsive/breakpoint.dart';
import 'package:kustart/responsive/responsive_center.dart';

class ShuttlePage extends StatefulWidget {
  const ShuttlePage({Key? key}) : super(key: key);

  @override
  State<ShuttlePage> createState() => _ShuttlePageState();
}

class _ShuttlePageState extends State<ShuttlePage> {
  var directionIcon = const Icon(Icons.east);
  late Widget weekdayTimelineWidget = buildShuttleTimeline(scheduleToCampusWeekday, true);
  late Widget sundayTimelineWidget = buildShuttleTimeline(scheduleToCampusSunday, false);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.5,
        title: const Text(
          '셔틀버스',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false, arguments: {"update": true});
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        height: screenHeight,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ResponsiveCenter(
            maxContentWidth: BreakPoint.tablet,
            padding: const EdgeInsets.all(20),
            child: Center(
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
                            directionIcon = Icon(Icons.west);
                            weekdayTimelineWidget =
                                buildShuttleTimeline(scheduleToStationWeekday, true);
                            sundayTimelineWidget =
                                buildShuttleTimeline(scheduleToStationSunday, false);
                          } else {
                            directionIcon = Icon(Icons.east);
                            weekdayTimelineWidget =
                                buildShuttleTimeline(scheduleToCampusWeekday, true);
                            sundayTimelineWidget =
                                buildShuttleTimeline(scheduleToCampusSunday, false);
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
                        child: directionIcon, // 변경 가능한 변수 사용
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
                  const SizedBox(height: 30),

                  // 주중 셔틀 시간표
                  Container(
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Color(0xFFD9D9D9),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '주중',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Color(0xFFD9D9D9),
                        ),
                      ),
                    ),
                  ),
                  weekdayTimelineWidget,
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const ShapeDecoration(
                          color: Color(0xFFF19A3D),
                          shape: OvalBorder(),
                        ),
                      ),
                      const SizedBox(width: 7),
                      const Text(
                        '금요일 운행하지 않음',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // 일요일 셔틀 시간표
                  Container(
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Color(0xFFD9D9D9),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '일요일',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Color(0xFFD9D9D9),
                        ),
                      ),
                    ),
                  ),
                  sundayTimelineWidget,
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (int index) {
          // 페이지 이동
          if (index == 0) {
            Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false, arguments: {"update": true});
          } else if (index == 1) {
            Navigator.pushNamedAndRemoveUntil(context, '/menu', ModalRoute.withName('/home'), arguments: {"update": true});
          }
        },
        // type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF862633),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: '식단표',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airport_shuttle),
            label: '셔틀버스',
          )
        ],
      ),
    );
  }

  // 조치원역 방향 시간표
  final Map<int, List<int>> scheduleToStationWeekday = {
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

  final Map<int, List<int>> scheduleToStationSunday = {
    17: [0, 40],
    18: [40],
    19: [0, 40],
    20: [20],
    21: [10],
  };

  // 고려대 방향 시간표
  final Map<int, List<int>> scheduleToCampusWeekday = {
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

  final Map<int, List<int>> scheduleToCampusSunday = {
    16: [40],
    17: [10, 50],
    18: [50],
    19: [10, 50],
    20: [35],
    21: [20],
  };

  // 시간 formatting
  String formatTime(int time) {
    return time.toString().padLeft(2, '0');
  }

  // 시간별 셔틀 타임라인 위젯
  Widget buildShuttleTimeline(Map<int, List<int>> schedule, bool isWeekday) {
    // 시간별 셔틀 타임라인 위젯 목록을 저장할 리스트
    List<Widget> timelineWidgets = [const SizedBox(height: 15)];
    bool fridayTimeline = false;

    // 주어진 Map의 각 항목을 반복하며 위젯을 생성
    schedule.forEach((hour, minutes) {
      List<Widget> minuteWidgets = [];

      // 금요일 시간표
      if ((hour == 19 || hour == 20 || hour == 21) && isWeekday) {
        fridayTimeline = true;
      }

      // 분에 대한 위젯을 생성
      for (var minute in minutes) {
        minuteWidgets.add(
          Row(
            children: [
              Text(
                formatTime(minute),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w800,
                  height: 0,
                ),
              ),
              const SizedBox(width: 33)
            ],
          ),
        );
      }

      // 시간과 분 위젯을 묶어 하나의 타임라인 위젯 생성
      timelineWidgets.add(
        Column(
          children: [
            Container(
              height: 55,
              decoration: fridayTimeline
                  ? ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1, color: Color(0xFFF19A3D)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    )
                  : ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1, color: Color(0xFF7B2D35)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
              child: Stack(
                children: [
                  Positioned(
                    left: 7,
                    top: 7,
                    child: Container(
                      width: 40,
                      height: 40,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: fridayTimeline
                                  ? const ShapeDecoration(
                                      color: Color(0xFFF19A3D),
                                      shape: CircleBorder(),
                                    )
                                  : const ShapeDecoration(
                                      color: Color(0xFF7B2D35),
                                      shape: CircleBorder(),
                                    ),
                            ),
                          ),
                          Positioned(
                            left: 9,
                            top: 8,
                            child: Text(
                              formatTime(hour),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 66,
                    top: 15,
                    child: Row(
                      children: minuteWidgets,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15)
          ],
        ),
      );
    });

    // 모든 시간별 셔틀 타임라인 위젯을 Column으로 묶어 반환
    return Column(children: timelineWidgets);
  }
}
