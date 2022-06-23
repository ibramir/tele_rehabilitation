import 'package:flutter/material.dart';
import 'package:tele_rehabilitation/screens/exercises_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tele-Rehabilitation',
      theme: ThemeData.from(
          colorScheme: const ColorScheme.light(
              primary: Color(0xFF58B472),
              secondary: Color(0xFF56AA67),
              onSecondary: Colors.white,
              tertiary: Color(0xFF4F995F),
              onTertiary: Colors.white,
              background: Color(0xFFF0F0F0))
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TeleRehab.'),
        ),
        body: ExercisesScreen(),
      ),
    );
  }
}
