import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:task_minder/pages/pages.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('toDOListBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
