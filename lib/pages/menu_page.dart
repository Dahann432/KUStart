import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:kustart/responsive/breakpoint.dart';
import 'package:kustart/responsive/responsive_center.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String selectedDayButton = 'Mon'; // 선택한 요일 버튼 초기화
  String selectedMenuButton = 'breakfast'; // 선택한 메뉴 버튼 초기화

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
    dayMenuList = MenuListText(dayOfWeek: currentDayOfWeek, menu: 'breakfast');
    selectedDayButton = currentDayOfWeek;
  }

  void updateDayMenuList(String selectedDayButton, String selectedMenuButton) {

    setState(() {
      dayMenuList = MenuListText(
          dayOfWeek: selectedDayButton,
          menu: selectedMenuButton);
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
                          buildDayButton('일', 'Sun'),
                          const SizedBox(width: 10),
                          buildDayButton('월', 'Mon'),
                          const SizedBox(width: 10),
                          buildDayButton('화', 'Tue'),
                          const SizedBox(width: 10),
                          buildDayButton('수', 'Wed'),
                          const SizedBox(width: 10),
                          buildDayButton('목', 'Thu'),
                          const SizedBox(width: 10),
                          buildDayButton('금', 'Fri'),
                          const SizedBox(width: 10),
                          buildDayButton('토', 'Sat'),
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
                          buildMenuButton('조식', 'breakfast'),
                          buildVerticalDivider(),
                          buildMenuButton('중식', 'lunch'),
                          buildVerticalDivider(),
                          buildMenuButton('석식', 'dinner'),
                        ],
                      ),
                      const SizedBox(height: 50),
                      dayMenuList,
                      const SizedBox(height: 50)
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
  Widget buildDayButton(String label, String dayOfWeek) {
    final bool isSelected = dayOfWeek == selectedDayButton;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDayButton = dayOfWeek;
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
  Widget buildMenuButton(String label, String menu) {
    final bool isSelected = menu == selectedMenuButton;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMenuButton = menu;
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

  MenuListText({Key? key, required this.dayOfWeek, required this.menu})
      : super(key: key);

  @override
  State<MenuListText> createState() => _MenuListTextState();
}

class _MenuListTextState extends State<MenuListText> {
  final databaseReference = FirebaseDatabase.instance.ref();
  Map<String, dynamic> jsonData = {};
  final String dataKey = 'firebaseData';
  bool isDataLoaded = false;

  Map<String, Map<String, List<String>>> menuList = {
    'Mon': {
      'breakfast': [],
      'lunch': [],
      'dinner': [],
    },
    'Tue': {
      'breakfast': [],
      'lunch': [],
      'dinner': [],
    },
    'Wed': {
      'breakfast': [],
      'lunch': [],
      'dinner': [],
    },
    'Thu': {
      'breakfast': [],
      'lunch': [],
      'dinner': [],
    },
    'Fri': {
      'breakfast': [],
      'lunch': [],
      'dinner': [],
    },
  };

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    if (!isDataLoaded) {
      // Firebase에서 데이터 가져오기
      final dataSnapshot = await databaseReference.child('학생식당').once();

      if (dataSnapshot.snapshot.value != null) {
        final dynamic data = dataSnapshot.snapshot.value;
        if (data is Map<String, dynamic>) {
          setState(() {
            jsonData = data;
            isDataLoaded = true;
          });

          // Firebase에서 가져온 데이터를 로컬 캐시에 저장
          await _saveDataToLocalCache();
        }
      }
    } else {
      // 이미 데이터를 가져온 경우 로컬 캐시에서 데이터 불러오기
      await _loadDataFromLocalCache();
    }
  }

  Future<void> _saveDataToLocalCache() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonDataString = json.encode(menuList);
    await prefs.setString(dataKey, jsonDataString);
  }

  Future<void> _loadDataFromLocalCache() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonDataString = prefs.getString(dataKey);

    if (jsonDataString != null) {
      final decodedData = json.decode(jsonDataString);
      if (decodedData is Map<String, dynamic>) {
        setState(() {
          jsonData = decodedData;
        });
      }
    }
  }

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
    if (jsonData.containsKey(widget.dayOfWeek) &&
        jsonData[widget.dayOfWeek]![widget.menu]!.isNotEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (String menu in jsonData[widget.dayOfWeek]![widget.menu]!)
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






