import 'package:flutter/material.dart';
import 'package:tele_rehabilitation/screens/home_screen.dart';
import 'package:tele_rehabilitation/screens/login_screen.dart';
import 'package:tele_rehabilitation/utils/auth_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TeleRehab.',
        theme: ThemeData.from(
            colorScheme: const ColorScheme.light(
                primary: Color(0xFF58B472),
                secondary: Color(0xFF56AA67),
                onSecondary: Colors.white,
                tertiary: Color(0xFF4F995F),
                onTertiary: Colors.white,
                background: Color(0xFFF0F0F0))),
        home: FutureBuilder(
          future: AuthService().sessionLoggedIn(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data! ? HomeScreen() : const LoginScreen();
            }
            return const Center(
              child: Image(image: AssetImage('assets/logo-color.png')),
            );
          },
        ));
  }
}
