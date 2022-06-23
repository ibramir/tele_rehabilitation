import 'package:flutter/material.dart';
import 'package:tele_rehabilitation/model/exercise.dart';

class DummyGame extends StatefulWidget {
  const DummyGame({Key? key, required this.exercise})
      : super(key: key);

  final Exercise exercise;

  @override
  State<StatefulWidget> createState() => _GameState();
}

class _GameState extends State<DummyGame> {
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
