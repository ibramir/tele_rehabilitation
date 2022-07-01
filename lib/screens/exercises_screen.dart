import 'package:flutter/material.dart';
import 'package:tele_rehabilitation/exercises/ExerciseView.dart';
import 'package:tele_rehabilitation/game_main.dart';
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
          future: _controller.fetchDayExercises(),
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
                        children: _getButtons(context, snapshot.data),
                      )),
                  const Text('Checklist', textScaleFactor: 1.3),
                  WidgetFactory.card(
                      child: Checklist(exercises: (snapshot.data!)))
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

  List<Widget> _getButtons(BuildContext context, List<Exercise>? dayExercises) {
    List<Widget> ret = [];
    if (dayExercises == null || dayExercises.isEmpty) {
      ret.add(const Center(
        child: Text('No exercises today'),
      ));
      return ret;
    }
    for (final e in dayExercises) {
      // TODO pass exercise e to ExerciseView
      Widget button;
      switch (e.type) {
        case 'Left Arm Stretch':
          {
            button = Container(
              margin: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () {
                  // TODO exercise
                  Future.delayed(const Duration(seconds: 5), () {
                    e.done++;
                  });
                  runApp(BirdRunApp(exercise: e));
                  /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ExerciseView()))*/
                },
                child:
                    Image.asset('assets/exercise-icon5.png', fit: BoxFit.fill),
              ),
            );
          }
          break;
        case 'Right Arm Stretch':
          {
            button = Container(
              margin: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ExerciseView()))
                },
                child:
                    Image.asset('assets/exercise-icon3.png', fit: BoxFit.fill),
              ),
            );
          }
          break;
        case 'Left Elbow Bend':
          {
            button = Container(
              margin: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ExerciseView()))
                },
                child:
                    Image.asset('assets/left-elbow-bend.png', fit: BoxFit.fill),
              ),
            );
          }
          break;
        case 'Right Elbow Bend':
          {
            button = Container(
              margin: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ExerciseView()))
                },
                child: Image.asset('assets/right-elbow-bend.png',
                    fit: BoxFit.fill),
              ),
            );
          }
          break;
        default:
          {
            button = Container(
              margin: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ExerciseView()))
                },
                child:
                    Image.asset('assets/exercise-icon1.png', fit: BoxFit.fill),
              ),
            );
          }
      }
      ret.add(button);
    }
    return ret;
  }
}
