import 'package:flutter/material.dart';
import 'package:tele_rehabilitation/widgets/mainDrawer.dart';

class ContactScreen extends StatelessWidget {
  ContactScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF0F0F0),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: AppBar(
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              title: Text(
                'Contact Doctor',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'proxima_ssv',
                  fontSize: 35,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image(
                      image: AssetImage('assets/appbar_background.png'),
                      fit: BoxFit.fill),
                ],
              ),
            ),
            title: Text(
              "TeleRehab.",
              style: TextStyle(color: Colors.white, fontFamily: 'proxima_ssv'),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30)),
            ),
          ),
        ),
        drawer: MainDrawer(),
        body: Center(
            child: Container(
                height: 300,
                width: 500,
                margin: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15),
                    ),
                    Text(
                      'Dr. Jane Doe',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'proxima_ssv',
                          fontSize: 25),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                    ),
                    Text(
                      'Phone Number  XXXXXXXXXXX',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'proxima_ssv',
                          fontSize: 15),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                    ),
                    Text(
                      'Landline Number  XXXXXXXXXXX',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'proxima_ssv',
                          fontSize: 15),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                    ),
                    Text(
                      'Location XXXXXXXXXXXX',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'proxima_ssv',
                          fontSize: 15),
                    ),
                  ],
                ))));
  }
}
