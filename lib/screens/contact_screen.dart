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
            flexibleSpace: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30)),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/appbar_background.png'),
                      fit: BoxFit.fill),
                ),
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
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 500,
                    height: 300,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
