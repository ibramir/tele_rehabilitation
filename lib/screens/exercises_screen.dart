import 'package:flutter/material.dart';
import 'package:tele_rehabilitation/utils/exercise_controller.dart';
import 'package:tele_rehabilitation/utils/widget_factory.dart';
import 'package:tele_rehabilitation/widgets/checklist.dart';
import 'package:tele_rehabilitation/widgets/default_app_bar.dart';
import 'package:tele_rehabilitation/widgets/main_drawer.dart';

import '../model/exercise.dart';

class ExercisesScreen extends StatelessWidget {
  ExercisesScreen({Key? key}) : super(key: key);

  final ExerciseController _controller = ExerciseController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: DefaultAppBar(
          title: RichText(
            text: const TextSpan(
                style: TextStyle(
                  color: Colors.white,
                ),
                children: [
                  TextSpan(
                    text: 'Let\'s do some...\n',
                    style: TextStyle(
                        fontFamily: 'din',
                        fontSize: 20,
                        fontStyle: FontStyle.italic),
                  ),
                  TextSpan(
                      text: 'Exercises',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'proxima_ssv',
                        fontSize: 30,
                      ))
                ]),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: FutureBuilder(
          future: _controller.getDayExercises(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Exercise>> snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                  child: Column(
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
                              onTap: () => {},
                              child: Image.asset('assets/exercise-icon4.png',
                                  fit: BoxFit.fill),
                            ),
                          )
                        ],
                      )),
                  const Text('Checklist', textScaleFactor: 1.3),
                  WidgetFactory.card(
                      child: Checklist(exercises: (snapshot.data!))),
                  const Text('History', textScaleFactor: 1.3)
                ],
              ));
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      drawer: const MainDrawer(),
    );
  }
}
