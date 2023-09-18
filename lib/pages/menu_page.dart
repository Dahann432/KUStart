import 'package:flutter/material.dart';
import 'package:kustart/responsive/breakpoint.dart';
import 'package:kustart/responsive/responsive_center.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<Color> menuButtonColors = [
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
  ];

  late Color dayButtonColor1 = Colors.transparent;
  late Color dayButtonColor2 = Colors.transparent;
  late Color dayButtonColor3 = Colors.transparent;
  late Color dayButtonColor4 = Colors.transparent;
  late Color dayButtonColor5 = Colors.transparent;
  late Color dayButtonColor6 = Colors.transparent;
  late Color dayButtonColor7 = Colors.transparent;

  @override
  void initState() {
    super.initState();
    loadButtonColors();
    updateDayButtonColors();

    checkFirstRun();
  }

  void checkFirstRun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // 처음 실행한 경우
    if (!prefs.containsKey('firstRun') || prefs.getBool('firstRun') == true) {
      // 초기 실행 여부를 저장합니다.
      prefs.setBool('firstRun', false);

      // 첫 번째 메뉴 버튼을 선택합니다.
      saveButtonColor(1);
    }
  }

  void loadButtonColors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // SharedPreferences에서 저장된 값을 불러옵니다. 없을 경우 기본값을 설정합니다.
      for (int i = 0; i < 3; i++) {
        menuButtonColors[i] = prefs.getBool('menuButtonColor$i') == true
            ? const Color(0xFF7B2D35)
            : Colors.transparent;
      }
    });
  }

  void saveButtonColor(int menuButtonNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      for (int i = 0; i < 3; i++) {
        menuButtonColors[i] = menuButtonNumber == i + 1
            ? const Color(0xFF7B2D35)
            : Colors.transparent;

        // 선택한 버튼의 정보를 SharedPreferences에 저장합니다.
        prefs.setBool('menuButtonColor$i', menuButtonNumber == i + 1);
      }
    });
  }

  void updateDayButtonColors() {
    final now = DateTime.now();
    final currentDay = now.weekday;

    // 요일별 버튼 색상 초기화
    dayButtonColor1 = Colors.transparent;
    dayButtonColor2 = Colors.transparent;
    dayButtonColor3 = Colors.transparent;
    dayButtonColor4 = Colors.transparent;
    dayButtonColor5 = Colors.transparent;
    dayButtonColor6 = Colors.transparent;
    dayButtonColor7 = Colors.transparent;

    // 현재 요일에 따라 색상 변경
    switch (currentDay) {
      case 1:
        dayButtonColor1 = const Color(0xFF862633);
        break;
      case 2:
        dayButtonColor2 = const Color(0xFF862633);
        break;
      case 3:
        dayButtonColor3 = const Color(0xFF862633);
        break;
      case 4:
        dayButtonColor4 = const Color(0xFF862633);
        break;
      case 5:
        dayButtonColor5 = const Color(0xFF862633);
        break;
      case 6:
        dayButtonColor6 = const Color(0xFF862633);
        break;
      case 7:
        dayButtonColor7 = const Color(0xFF862633);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    final now = DateTime.now();
    final dateFormat = DateFormat('yyyy.MM.dd (E)', 'ko_KR');
    final formattedDate = dateFormat.format(now);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          '식단표',
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
            }),
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
                children: [
                  Container(
                    height: 500,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1, color: Color(0xFF6F6F6F)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 25, 0, 20),
                        child: Row(
                          children: [
                            Container(
                              width: 75,
                              height: 30,
                              decoration: ShapeDecoration(
                                color: const Color(0xFF862633),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Center(
                                child: Text('Closed',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Text(
                                formattedDate,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                  letterSpacing: 1.70,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildDayButton('일', dayButtonColor7, 7),
                          const SizedBox(width: 10),
                          buildDayButton('월', dayButtonColor1, 1),
                          const SizedBox(width: 10),
                          buildDayButton('화', dayButtonColor2, 2),
                          const SizedBox(width: 10),
                          buildDayButton('수', dayButtonColor3, 3),
                          const SizedBox(width: 10),
                          buildDayButton('목', dayButtonColor4, 4),
                          const SizedBox(width: 10),
                          buildDayButton('금', dayButtonColor5, 5),
                          const SizedBox(width: 10),
                          buildDayButton('토', dayButtonColor6, 6),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: 284,
                        decoration: const ShapeDecoration(
                          color: Color(0xFFD9D9D9),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 0.1,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildMenuButton('Menu 1', menuButtonColors[0], 1),
                          buildVerticalDivider(),
                          buildMenuButton('Menu 2', menuButtonColors[1], 2),
                          buildVerticalDivider(),
                          buildMenuButton('Menu 3', menuButtonColors[2], 3),
                        ],
                      )
                    ]),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 190,
                    child: Column(children: [
                      Container(
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              strokeAlign: BorderSide.strokeAlignCenter,
                              color: Color(0xFF7B2D35),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 9),
                      const Text(
                        '운영 시간 ',
                        style: TextStyle(
                          color: Color(0xFF7B2D35),
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      const SizedBox(height: 9),
                      Container(
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              strokeAlign: BorderSide.strokeAlignCenter,
                              color: Color(0xFF7B2D35),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 9),
                      const Text(
                        '조식 - 07:00~09:00',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        '중식 - 11:30~13:30',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        '석식 - 17:30~18:30',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        '카페 - 08:00~17:00',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      )
                    ]),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
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

  Widget buildDayButton(
      String label, Color dayButtonColor, int dayButtonNumber) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // DayButton이 선택되면 색상을 변경
          dayButtonColor1 = dayButtonNumber == 1
              ? const Color(0xFF862633)
              : Colors.transparent;
          dayButtonColor2 = dayButtonNumber == 2
              ? const Color(0xFF862633)
              : Colors.transparent;
          dayButtonColor3 = dayButtonNumber == 3
              ? const Color(0xFF862633)
              : Colors.transparent;
          dayButtonColor4 = dayButtonNumber == 4
              ? const Color(0xFF862633)
              : Colors.transparent;
          dayButtonColor5 = dayButtonNumber == 5
              ? const Color(0xFF862633)
              : Colors.transparent;
          dayButtonColor6 = dayButtonNumber == 6
              ? const Color(0xFF862633)
              : Colors.transparent;
          dayButtonColor7 = dayButtonNumber == 7
              ? const Color(0xFF862633)
              : Colors.transparent;
        });
      },
      child: Container(
        width: 25,
        height: 25,
        decoration: ShapeDecoration(
          color: dayButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: dayButtonColor == Colors.transparent
                  ? Colors.black // 버튼 색이 투명이면 검정색
                  : Colors.white, // 버튼 색이 흰색이면 흰색
              fontSize: 15,
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMenuButton(
      String label, Color menuButtonColor, int menuButtonNumber) {
    return GestureDetector(
      onTap: () {
        saveButtonColor(menuButtonNumber);
      },
      child: Container(
        width: 95,
        height: 35,
        decoration: ShapeDecoration(
          color: menuButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: menuButtonColor == Colors.transparent
                  ? const Color(0xFF000000)
                  : const Color(0xFFFFFFFF),
              fontSize: 15,
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildVerticalDivider() {
    return Container(
      height: 25,
      width: 0.50,
      color: Colors.black,
    );
  }
}
