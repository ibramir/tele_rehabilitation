import 'package:flutter/material.dart';
import 'package:tele_rehabilitation/utils/exercise_controller.dart';
import 'package:tele_rehabilitation/widgets/checklist_card.dart';
import 'package:tele_rehabilitation/exercises/ExerciseView.dart';
import 'package:tele_rehabilitation/exercises/TrialView.dart';
import '../model/exercise.dart';

class ExercisesScreen extends StatelessWidget {
  ExercisesScreen({Key? key}) : super(key: key);

  final ExerciseController _controller = ExerciseController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: FutureBuilder(
        future: _controller.getDayExercises(),
        builder: (BuildContext context, AsyncSnapshot<List<Exercise>> snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Therapy', textScaleFactor: 1.3),
                LimitedBox(
                    maxHeight: 200,
                    child: ListView(
                      clipBehavior: Clip.none,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: GestureDetector(
                            onTap: () => {},
                            child: Image.asset('assets/exercise-icon5.png',
                                fit: BoxFit.fill),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: GestureDetector(
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ExerciseView() ),
                              )
                            },
                            child: Image.asset('assets/exercise-icon4.png',
                                fit: BoxFit.fill),
                          ),
                        )
                      ],
                    )),
                const Text('Checklist', textScaleFactor: 1.3),
                ChecklistCard(exercises: snapshot.data ?? [])
              ],
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );

        },
      ),
    );
  }
}
