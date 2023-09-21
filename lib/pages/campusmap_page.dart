import 'package:flutter/material.dart';

class CampusmapPage extends StatefulWidget {
  const CampusmapPage({super.key});

  @override
  State<CampusmapPage> createState() => _CampusmapPageState();
}

class _CampusmapPageState extends State<CampusmapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0.5,
          title: const Text(
            '학교 지도',
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
        body: Center(child: Image.asset('lib/images/campusmap_img.jpg')));
  }
}
