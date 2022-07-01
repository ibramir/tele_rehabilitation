import 'package:flutter/material.dart';
import 'package:tele_rehabilitation/utils/exercise_controller.dart';
import 'package:tele_rehabilitation/utils/helpers.dart';
import 'package:tele_rehabilitation/utils/widget_factory.dart';
import 'package:tele_rehabilitation/widgets/checklist.dart';
import 'package:tele_rehabilitation/widgets/default_app_bar.dart';
import 'package:tele_rehabilitation/widgets/main_drawer.dart';

import '../model/exercise.dart';

class GameScreen extends StatelessWidget {
  GameScreen({Key? key}) : super(key: key);

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
          future: _controller.getAllExercises(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Exercise>> snapshot) {
            if (snapshot.hasData) {
              DateTime today = DateTime.now();
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
                              child: Image.asset('assets/game-icon.png',
                                  fit: BoxFit.fill),
                            ),
                          ),
                        ],
                      )),
                  const Text('Checklist', textScaleFactor: 1.3),
                  WidgetFactory.card(
                      child: Checklist(
                          exercises: (snapshot.data ?? [])
                              .where((e) => e.date.isSameDate(today))
                              .toList()))
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
