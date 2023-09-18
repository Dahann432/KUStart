import 'package:flutter/material.dart';

class SchulMapMain extends StatefulWidget {
  const SchulMapMain({super.key});

  @override
  State<SchulMapMain> createState() => _SchulMapMainState();
}

class _SchulMapMainState extends State<SchulMapMain> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: ShapeDecoration(
        color: const Color(0xFFD9D9D9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}