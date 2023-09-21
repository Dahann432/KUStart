import 'package:flutter/material.dart';
import 'package:kustart/responsive/responsive_center.dart';
import 'package:kustart/responsive/breakpoint.dart';
import 'package:kustart/widgets/shuttle_main.dart';
import 'package:kustart/widgets/menu_main.dart';
import 'package:kustart/widgets/campusmap_main.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _SignInState();
}

class _SignInState extends State<MainPage> {
  int _backButtonPressedCount = 0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 134, 38, 51),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'KUStart',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFFF6C944),
            fontSize: 30,
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/settings');
            },
          )
        ],
      ),
      body: WillPopScope(
        onWillPop: _onBackPressed,
        child: Container(
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
                    ShuttleMain(),
                    const SizedBox(height: 20),
                    MenuMain(),
                    const SizedBox(height: 20),
                    CampusMapMain()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
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
          // type: BottomNavigationBarType.fixed, // item이 4개 이상일 경우 추가
          selectedItemColor: const Color(0xFF862633), // 선택된 요소 색
          unselectedItemColor: Colors.grey, // 선택되지 않은 요소 색
          showSelectedLabels: true, // 선택된 라벨 보이기/숨기기
          showUnselectedLabels: false, // 선택되지 않은 라벨 보이기/숨기기
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
          ]),
    );
  }

  Future<bool> _onBackPressed() async {
    if (_backButtonPressedCount == 1) {
      // 뒤로가기 버튼이 두 번 눌렸을 때 앱 종료
      return true;
    } else {
      // 뒤로가기 버튼이 한 번 눌렸을 때 안내 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('한 번 더 뒤로가기 버튼을 누르면 종료됩니다.'),
        ),
      );
      _backButtonPressedCount++;
      // 2초 동안 다시 뒤로가기 버튼을 누르면 앱 종료
      await Future.delayed(Duration(seconds: 2));
      _backButtonPressedCount = 0;
      return false;
    }
  }
}
