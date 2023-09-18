import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:kustart/pages/main_page.dart';
import 'firebase_options.dart';
import 'pages/shuttle_page.dart';
import 'pages/settings_page.dart';
import 'pages/menu_page.dart';

void getMenu() async {
  Map<int, String> day = {
    0: 'Mon',
    1: 'Tue',
    2: 'Wed',
    3: 'Thu',
    4: 'Fri',
  };

  for (int i = 0; i <= 4; i++) {
    final ref = FirebaseDatabase.instance.ref();
    final menu = await ref.child('교직원식당').child(day[i]!).get();
    if (menu.exists) {
      var menuList = menu.value;
      print(menuList);
    } else {
      print('No data available.');
    }
  }
}

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // 투명색
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
  // getMenu();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => MainPage(),
        '/settings': (context) => SettingsPage(),
        '/menu' : (context) => MenuPage(),
        '/shuttle' : (context) => ShuttlePage()
      },
    );
  }
}
