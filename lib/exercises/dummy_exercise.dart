import 'package:flutter/material.dart';
import 'package:tele_rehabilitation/model/exercise.dart';

class DummyExercise extends StatefulWidget {
  const DummyExercise({Key? key, required this.exercise})
      : super(key: key);

  final Exercise exercise;

  @override
  State<StatefulWidget> createState() => _ExerciseState();
}

class _ExerciseState extends State<DummyExercise> {
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
