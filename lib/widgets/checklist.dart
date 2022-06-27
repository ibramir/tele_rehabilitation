import 'package:flutter/material.dart';
import 'package:tele_rehabilitation/widgets/progress_bar.dart';

import '../model/exercise.dart';

class Checklist extends StatelessWidget {
  const Checklist({Key? key, required this.exercises}) : super(key: key);

  final List<Exercise> exercises;

  @override
  Widget build(BuildContext context) {
    Map<String, double> progress = {};
    int done;
    if (exercises.isEmpty) {
      done = -1;
    } else {
      done = 1;
      for (final exercise in exercises) {
        double value = exercise.done / exercise.count;
        progress[exercise.id] = value;
        if (value != 1.0) done = 0;
      }
    }

    TextSpan progressText;
    switch (done) {
      case 0:
        progressText = const TextSpan(
            text: 'in progress...', style: TextStyle(color: Colors.amber));
        break;
      case 1:
        progressText = const TextSpan(
            text: 'Done!', style: TextStyle(color: Colors.green));
        break;
      default:
        progressText = const TextSpan(
            text: 'No exercises today', style: TextStyle(color: Colors.grey));
    }

    List<Widget> cardContent = [];
    for (final exercise in exercises) {
      cardContent.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(exercise.type),
            Text('${exercise.done}/${exercise.count}')
          ]));
      double progressValue = progress[exercise.id]!;
      if (progressValue < 0.05) {
        progressValue = 0.05;
      }

      cardContent.add(ProgressBar(value: progressValue, height: 14.0));
    }

    return Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          RichText(
              text: TextSpan(children: <TextSpan>[
            const TextSpan(
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16),
                text: 'Today\'s Goal '),
            progressText
          ])),
          Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: cardContent))
        ]));
  }
}
