import 'package:flutter/material.dart';
import 'package:kustart/responsive/breakpoint.dart';
import 'package:kustart/responsive/responsive_center.dart';
import 'package:intl/intl.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int selectedDayButton = 1; // 선택한 요일 버튼 초기화
  int selectedMenuButton = 1; // 선택한 메뉴 버튼 초기화

  var dayMenuList;

  @override
  void initState() {
    super.initState();
    initializeDayMenuList();
  }

  void initializeDayMenuList() {
    final now = DateTime.now();
    final dateFormat = DateFormat('E');
    final currentDayOfWeek = dateFormat.format(now);
    dayMenuList = MenuListText(dayOfWeek: currentDayOfWeek, menu: 'lunch');
  }

  void updateDayMenuList(int selectedDayButton, int selectedMenuButton) {
    Map<int, String> dayOfWeek = {
      7: 'Sun',
      1: 'Mon',
      2: 'Tue',
      3: 'Wed',
      4: 'Thu',
      5: 'Fri',
      6: 'Sat'
    };

    Map<int, String> menu = {
      1: 'breakfast',
      2: 'lunch',
      3: 'dinner',
    };

    setState(() {
      dayMenuList = MenuListText(dayOfWeek: dayOfWeek[selectedDayButton]!, menu: menu[selectedMenuButton]!);
    });
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
        elevation: 0.5,
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
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (route) => false,
                  arguments: {"update": true});
            }),
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
                          buildDayButton('일', 7, 'Sun'),
                          const SizedBox(width: 10),
                          buildDayButton('월', 1, 'Mon'),
                          const SizedBox(width: 10),
                          buildDayButton('화', 2, 'Tue'),
                          const SizedBox(width: 10),
                          buildDayButton('수', 3, 'Wed'),
                          const SizedBox(width: 10),
                          buildDayButton('목', 4, 'Thu'),
                          const SizedBox(width: 10),
                          buildDayButton('금', 5, 'Fri'),
                          const SizedBox(width: 10),
                          buildDayButton('토', 6, 'Sat'),
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
                          buildMenuButton('조식', 1, 'breakfast'),
                          buildVerticalDivider(),
                          buildMenuButton('중식', 2, 'lunch'),
                          buildVerticalDivider(),
                          buildMenuButton('석식', 3, 'dinner'),
                        ],
                      ),
                      const SizedBox(height: 50),
                      dayMenuList
                    ]),
                  ),
                  const SizedBox(height: 100),
                  SizedBox(
                    height: 205,
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
                      // 운영 시간 Text
                      const Column(
                        children: [
                          SizedBox(height: 10),
                          Text(
                            '조식 - 07:00~09:00',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            '중식 - 11:30~13:30',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            '석식 - 17:30~18:30',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            '카페 - 08:00~17:00',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          )
                        ],
                      ),
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
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false,
                arguments: {"update": true});
          } else if (index == 2) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/shuttle', ModalRoute.withName('/home'),
                arguments: {"update": true});
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

  // 요일 버튼 생성
  Widget buildDayButton(String label, int dayButtonNumber, String dayOfWeek) {
    final bool isSelected = dayButtonNumber == selectedDayButton;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDayButton = dayButtonNumber;
          updateDayMenuList(selectedDayButton, selectedMenuButton);
        });
      },
      child: Container(
        width: 25,
        height: 25,
        decoration: ShapeDecoration(
          color: isSelected ? const Color(0xFF862633) : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
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

  // 메뉴 버튼 생성
  Widget buildMenuButton(String label, int menuButtonNumber, String menu) {
    final bool isSelected = menuButtonNumber == selectedMenuButton;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMenuButton = menuButtonNumber;
          updateDayMenuList(selectedDayButton, selectedMenuButton);
        });
      },
      child: Container(
        width: 95,
        height: 35,
        decoration: ShapeDecoration(
          color: isSelected ? const Color(0xFF7B2D35) : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF000000),
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
}

Widget buildVerticalDivider() {
  return Container(
    height: 25,
    width: 0.50,
    color: Colors.black,
  );
}

class MenuListText extends StatefulWidget {
  final String dayOfWeek;
  final String menu;

  const MenuListText({Key? key, required this.dayOfWeek, required this.menu})
      : super(key: key);

  @override
  State<MenuListText> createState() => _MenuListTextState();
}

class _MenuListTextState extends State<MenuListText> {
  Map<String, Map<String, List<String>>> menuList = {
    'Mon': {
      'breakfast': ['쌀밥', '닭곰탕', '떡산적조림', '오이장아찌', '도시락김', '맛김치'],
      'lunch': ['쌀밥', '어묵국', '두부구이&양념간장', '매콤콩나물무침', '마늘쫑지무침', '맛김치'],
      'dinner': ['쌀밥', '근대된장국', '짜장불고기', '국물떡볶이', '쥐어채볶음', '맛김치']
    },
    'Tue': {
      'breakfast': ['쌀밥', '순두부국', '동그랑땡전', '브로콜리참깨무침', '도시락김', '깍두기'],
      'lunch': ['쌀밥', '미역국', '칠리탕수육', '멸치볶음', '쑥갓오이생채', '맛김치'],
      'dinner': ['김치볶음밥', '두부계란국', '치킨까스*소스', '푸실리샐러드', '수제피클', '열무무침']
    },
    'Wed': {
      'breakfast': ['쌀밥', '얼갈이된장국', '돈채버섯볶음', '두부조림', '도시락김', '맛김치'],
      'lunch': ['쌀밥', '짬뽕국', '고추마요미트볼', '우엉잡채', '궁채장아찌', '맛김치'],
      'dinner': ['쌀밥', '유부김치국', '꼬마돈까스&케찹', '빨간어묵볶음', '건파래볶음', '깍두기']
    },
    'Thu': {'breakfast': [], 'lunch': [], 'dinner': []},
    'Fri': {'breakfast': [], 'lunch': [], 'dinner': []}
  };

  Widget preparationImage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('lib/images/dourourung.png', width: 200, height: 200),
        RichText(
          text: const TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: '준비 중 입니',
                style: TextStyle(
                    fontFamily: 'UhBeeSe_hyun',
                    fontSize: 20,
                    color: Color(0xFFF19A3D)),
              ),
              TextSpan(
                text: '드르렁',
                style: TextStyle(
                    fontFamily: 'UhBeeSe_hyun',
                    fontSize: 20,
                    color: Color(0xFF7B2D35)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (menuList.containsKey(widget.dayOfWeek) &&
        menuList[widget.dayOfWeek]![widget.menu]!.isNotEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (String menu in menuList[widget.dayOfWeek]![widget.menu]!)
            Container(
              width: 300,
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 5,
                    height: 5,
                    decoration: const ShapeDecoration(
                      color: Color(0xFF7B2D35),
                      shape: OvalBorder(),
                    ),
                    margin: const EdgeInsets.only(right: 10),
                  ),
                  Text(menu, style: const TextStyle(fontSize: 20)),
                ],
              ),
            ),
        ],
      );
    } else {
      return preparationImage();
    }
  }
}
