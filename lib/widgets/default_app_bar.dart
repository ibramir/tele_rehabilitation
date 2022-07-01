import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget {
  const DefaultAppBar({Key? key, this.title}) : super(key: key);

  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        title: title,
        background: ClipRRect(
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30)),
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/appbar_background.png'),
                  fit: BoxFit.fill),
            ),
          ),
        ),
      ),
      title: const Text(
        "TeleRehab.",
        style: TextStyle(color: Colors.white, fontFamily: 'proxima_ssv'),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
      ),
    );
  }
}
