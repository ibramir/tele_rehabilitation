import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tele_rehabilitation/screens/home_screen.dart';
import 'package:tele_rehabilitation/screens/login_screen.dart';
import 'package:tele_rehabilitation/utils/auth_service.dart';

import 'model/player_data.dart';
import 'model/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initializes hive and register the adapters.
  await initHive();
  runApp(const MyApp());
}

Future<void> initHive() async {
  // For web hive does not need to be initialized.
  if (!kIsWeb) {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }

  Hive.registerAdapter<PlayerData>(PlayerDataAdapter());
  Hive.registerAdapter<Settings>(SettingsAdapter());
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
            return Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: const FractionallySizedBox(
                alignment: Alignment.center,
                widthFactor: 0.4,
                child: Image(image: AssetImage('assets/logo-color.png')),
              ),
            );
          },
        ));
  }
}
