import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:tele_rehabilitation/repositories/exercise/exercise_repository.dart';
import 'package:tele_rehabilitation/utils/widget_factory.dart';
import 'package:tele_rehabilitation/widgets/checklist.dart';
import 'package:tele_rehabilitation/widgets/default_app_bar.dart';
import 'package:tele_rehabilitation/widgets/main_drawer.dart';

import '../game_main.dart';
import '../model/exercise.dart';

class GameScreen extends StatelessWidget {
  GameScreen({Key? key}) : super(key: key);

  final ExerciseRepository _controller = ExerciseRepository();

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
                        text: 'It\'s time for...\n',
                        style: TextStyle(
                          fontFamily: 'din',
                          fontSize: 20,
                        )),
                    TextSpan(
                        text: 'Games',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'proxima_ssv',
                          fontSize: 30,
                        ))
                  ]),
            ),
          )),
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
                        children: _getButtons(context, snapshot.data!),
                      )),
                  const Text('Checklist', textScaleFactor: 1.3),
                  WidgetFactory.card(
                      child: Checklist(exercises: snapshot.data!))
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
      Widget button;
      switch (e.type) {
        case 'Left Arm Stretch':
          {
            button = Container(
              margin: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () {
                  Flame.device.fullScreen();
                  Flame.device.setLandscape();
                  runApp(BirdRunApp(exercise: e));
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
                onTap: () {
                  Flame.device.fullScreen();
                  Flame.device.setLandscape();
                  runApp(BirdRunApp(exercise: e));
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
                onTap: () {
                  Flame.device.fullScreen();
                  Flame.device.setLandscape();
                  runApp(BirdRunApp(exercise: e));
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
                onTap: () {
                  Flame.device.fullScreen();
                  Flame.device.setLandscape();
                  runApp(BirdRunApp(exercise: e));
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
                onTap: () {
                  Flame.device.fullScreen();
                  Flame.device.setLandscape();
                  runApp(BirdRunApp(exercise: e));
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
