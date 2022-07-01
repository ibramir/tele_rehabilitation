import 'package:flutter/material.dart';
import 'package:tele_rehabilitation/screens/contact_screen.dart';
import 'package:tele_rehabilitation/screens/exercises_screen.dart';
import 'package:tele_rehabilitation/screens/game_screen.dart';
import 'package:tele_rehabilitation/screens/home_screen.dart';
import 'package:tele_rehabilitation/screens/login_screen.dart';
import 'package:tele_rehabilitation/utils/auth_service.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  String _getInitials(String name) => name.isNotEmpty
      ? name.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join()
      : '';

  @override
  Widget build(BuildContext context) {
    AuthService auth = AuthService();
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Colors.green,
            child: Center(
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      _getInitials(auth.name),
                      style: const TextStyle(
                          color: Color.fromARGB(255, 147, 225, 188),
                          fontFamily: 'proxima_ssv',
                          fontSize: 25),
                    ),
                  ),
                  Text(
                    auth.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'proxima_ssv'),
                  ),
                  Text(
                    auth.email,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontFamily: 'proxima_ssv',
                        fontWeight: FontWeight.w200),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const ImageIcon(
              AssetImage('assets/home.png'),
              size: 20,
            ),
            title: const Text(
              'Home',
              style: TextStyle(
                  color: Colors.black, fontFamily: 'din', fontSize: 18),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),
          ListTile(
            leading: const ImageIcon(
              AssetImage('assets/pilates.png'),
              size: 20,
            ),
            title: const Text(
              'Exercises',
              style: TextStyle(
                  color: Colors.black, fontFamily: 'din', fontSize: 18),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ExercisesScreen()));
            },
          ),
          ListTile(
            leading: const ImageIcon(
              AssetImage('assets/console.png'),
              size: 20,
            ),
            title: const Text(
              'Games',
              style: TextStyle(
                  color: Colors.black, fontFamily: 'din', fontSize: 18),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GameScreen()));
            },
          ),
          ListTile(
            leading: const ImageIcon(
              AssetImage('assets/phone-call.png'),
              size: 20,
            ),
            title: const Text(
              'Contact Doctor',
              style: TextStyle(
                  color: Colors.black, fontFamily: 'din', fontSize: 18),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ContactScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, size: 20),
            title: const Text(
              'Logout',
              style: TextStyle(
                  color: Colors.black, fontFamily: 'din', fontSize: 18),
            ),
            onTap: () {
              auth.logout().then((value) => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false));
            },
          ),
        ],
      ),
    );
  }
}
