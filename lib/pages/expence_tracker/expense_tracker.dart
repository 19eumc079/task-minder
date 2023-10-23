import 'package:flutter/material.dart';

class ExpenceTracker extends StatefulWidget {
  const ExpenceTracker({super.key});

  @override
  State<ExpenceTracker> createState() => _ExpenceTrackerState();
}

class _ExpenceTrackerState extends State<ExpenceTracker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(19, 24, 38, 1),
      body: Center(
        child: Image.asset(
          'assets/coming-soon.png',
          height: 150,
          width: 150,
        ),
      ),
    );
  }
}
