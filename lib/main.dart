import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kustart/pages/main_page.dart';
import 'package:kustart/pages/campusmap_page.dart';
import 'firebase_options.dart';
import 'pages/shuttle_page.dart';
import 'pages/settings_page.dart';
import 'pages/menu_page.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // 투명색
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ko_KR', null);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
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
        '/shuttle' : (context) => ShuttlePage(),
        '/campusmap' : (context) => CampusmapPage()
      },
    );
  }
}
