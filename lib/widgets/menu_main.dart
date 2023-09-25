import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class MenuMain extends StatefulWidget {
  const MenuMain({Key? key}) : super(key: key);

  @override
  State<MenuMain> createState() => _MenuMainState();
}

class _MenuMainState extends State<MenuMain> {
  Color buttonColor1 = Colors.transparent;
  Color buttonColor2 = Colors.transparent;
  Color buttonColor3 = Colors.transparent;
  bool isFirstRun = true;

  var dayMenuList;

  @override
  void initState() {
    super.initState();
    loadButtonColors();
    initializeDayMenuList();
  }

  void initializeDayMenuList() {
    final now = DateTime.now();
    final dateFormat = DateFormat('E');
    final currentDayOfWeek = dateFormat.format(now);
    dayMenuList = MenuListText(dayOfWeek: currentDayOfWeek);
  }

  void loadButtonColors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // SharedPreferences에서 저장된 값을 불러옵니다. 없을 경우 기본값을 설정합니다.
      buttonColor1 = prefs.getBool('buttonColor1') == true
          ? const Color(0xFF7B2D35)
          : Colors.transparent;
      buttonColor2 = prefs.getBool('buttonColor2') == true
          ? const Color(0xFF7B2D35)
          : Colors.transparent;
      buttonColor3 = prefs.getBool('buttonColor3') == true
          ? const Color(0xFF7B2D35)
          : Colors.transparent;

      isFirstRun = prefs.getBool('isFirstRun') ?? true; // 첫 실행 여부를 가져옵니다.
    });

    if (isFirstRun) {
      // 첫 실행인 경우 Corner 1 버튼을 선택합니다.
      saveButtonColor(1);
    }
  }

  void saveButtonColor(int buttonNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      buttonColor1 =
          buttonNumber == 1 ? const Color(0xFF7B2D35) : Colors.transparent;
      buttonColor2 =
          buttonNumber == 2 ? const Color(0xFF7B2D35) : Colors.transparent;
      buttonColor3 =
          buttonNumber == 3 ? const Color(0xFF7B2D35) : Colors.transparent;

      // 선택한 버튼의 정보를 SharedPreferences에 저장합니다.
      prefs.setBool('buttonColor1', buttonNumber == 1);
      prefs.setBool('buttonColor2', buttonNumber == 2);
      prefs.setBool('buttonColor3', buttonNumber == 3);

      // 첫 실행 여부를 false로 업데이트합니다.
      prefs.setBool('isFirstRun', false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateFormat = DateFormat('yyyy.M.d (E)', 'ko_KR');
    final formattedDate = dateFormat.format(now);

    return Container(
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
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 11, 0, 10),
                child: Text(
                  formattedDate,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildCornerButton('조식', buttonColor1, 1),
              buildVerticalDivider(),
              buildCornerButton('중식', buttonColor2, 2),
              buildVerticalDivider(),
              buildCornerButton('석식', buttonColor3, 3),
            ],
          ),
          const SizedBox(height: 25),
          dayMenuList
        ],
      ),
    );
  }

  Widget buildCornerButton(String label, Color buttonColor, int buttonNumber) {
    return GestureDetector(
      onTap: () {
        saveButtonColor(buttonNumber);
      },
      child: Container(
        width: 95,
        height: 35,
        decoration: ShapeDecoration(
          color: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: buttonColor == Colors.transparent
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

class MenuListText extends StatefulWidget {
  final String dayOfWeek;

  const MenuListText({Key? key, required this.dayOfWeek}) : super(key: key);

  @override
  State<MenuListText> createState() => _MenuListTextState();
}

class _MenuListTextState extends State<MenuListText> {
  Map<String, List<String>> menuList = {
    'Mon': ['쌀밥', '순두부백탕', '파채산적조림', '새송이볶음', '얼갈이된장무침', '맛김치'],
    'Tue': ['쌀밥', '콩나물국', '돈육고추장불고기', '한식잡채', '브로콜리참깨무침', '맛김치'],
    'Wed': ['시래기나물밥*양념간장', '사골만두국', '생선까스*타르타르소스', '건파래볶음', '궁채장아찌', '맛김치'],
    'Thu': ['쌀밥', '수제비국', '순대닭볶음', '만두&춘권튀김', '숙주나물', '맛김치'],
    'Fri': ['쌀밥', '계란파국', '마파두부', '난자완스', '해초오이무침', '맛김치'],
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
        const SizedBox(height: 50)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (menuList.containsKey(widget.dayOfWeek)) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (String menu in menuList[widget.dayOfWeek]!)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
          const SizedBox(height: 40)
        ],
      );
    } else {
      return preparationImage();
    }
  }
}