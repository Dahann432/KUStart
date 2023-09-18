import 'package:flutter/material.dart';
import 'package:kustart/responsive/breakpoint.dart';
import 'package:kustart/responsive/responsive_center.dart';

class ShuttlePage extends StatefulWidget {
  const ShuttlePage({Key? key}) : super(key: key);

  @override
  State<ShuttlePage> createState() => _ShuttlePageState();
}

class _ShuttlePageState extends State<ShuttlePage> {
  // Icon 변수를 변경 가능한 변수로 선언
  Icon directionIcon = Icon(Icons.east);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
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
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        height: screenHeight,
        child: SingleChildScrollView(
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
                            directionIcon = Icon(Icons.west); // 변경 가능한 변수로 설정
                          } else {
                            directionIcon = Icon(Icons.east); // 변경 가능한 변수로 설정
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
                  const SizedBox(height: 15),
                  buildShuttleTimeline('08', '50'),
                  const SizedBox(height: 5),
                  buildShuttleTimeline('09', '00'),
                  const SizedBox(height: 5),
                  buildShuttleTimeline('10', '10'),
                  const SizedBox(height: 5),
                  buildShuttleTimeline('11', '30'),
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
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/menu');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/shuttle');
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

  Widget buildShuttleTimeline(String hour, String minute) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 55,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFF7B2D35)),
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
                        decoration: const ShapeDecoration(
                          color: Color(0xFF7B2D35),
                          shape: OvalBorder(),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 9,
                      top: 8,
                      child: Text(
                        hour,
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
              child: Text(
                minute,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w800,
                  height: 0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
