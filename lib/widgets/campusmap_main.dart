import 'package:flutter/material.dart';

class CampusMapMain extends StatefulWidget {
  const CampusMapMain({super.key});

  @override
  State<CampusMapMain> createState() => _CampusMapMainState();
}

class _CampusMapMainState extends State<CampusMapMain> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/campusmap', arguments: {"update": true});
      },
      child: Container(
        height: 110,
        decoration: ShapeDecoration(
          color: const Color(0xFFD9D9D9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Schul_map'),
          ],
        ),
      ),
    );
  }
}