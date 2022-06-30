import 'package:flutter/material.dart';
import 'package:tele_rehabilitation/screens/exercises_screen.dart';
import 'package:tele_rehabilitation/screens/game_screen.dart';
import 'package:tele_rehabilitation/screens/home_screen.dart';
import 'package:tele_rehabilitation/screens/contact_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.green,
            child: Center(
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: const Text(
                      "JD",
                      style: TextStyle(
                          color: Color.fromARGB(255, 147, 225, 188),
                          fontFamily: 'proxima_ssv',
                          fontSize: 25),
                    ),
                  ),
                  Text(
                    "John Doe",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'proxima_ssv'),
                  ),
                  Text(
                    "johndoe@gmail.com",
                    style: TextStyle(
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
            leading: ImageIcon(
              AssetImage('assets/home.png'),
              size: 20,
            ),
            title: Text(
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
            leading: ImageIcon(
              AssetImage('assets/pilates.png'),
              size: 20,
            ),
            title: Text(
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
            leading: ImageIcon(
              AssetImage('assets/console.png'),
              size: 20,
            ),
            title: Text(
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
            leading: ImageIcon(
              AssetImage('assets/phone-call.png'),
              size: 20,
            ),
            title: Text(
              'Contact Doctor',
              style: TextStyle(
                  color: Colors.black, fontFamily: 'din', fontSize: 18),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ContactScreen()));
            },
          ),
        ],
      ),
    );
  }
}
