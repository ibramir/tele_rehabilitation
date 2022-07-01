import 'package:flutter/material.dart';
import 'package:tele_rehabilitation/screens/exercises_screen.dart';
import 'package:tele_rehabilitation/screens/game_screen.dart';
import 'package:tele_rehabilitation/utils/auth_service.dart';
import 'package:tele_rehabilitation/utils/exercise_controller.dart';
import 'package:tele_rehabilitation/utils/helpers.dart';
import 'package:tele_rehabilitation/utils/widget_factory.dart';
import 'package:tele_rehabilitation/widgets/checklist.dart';
import 'package:tele_rehabilitation/widgets/default_app_bar.dart';
import 'package:tele_rehabilitation/widgets/histogram.dart';
import 'package:tele_rehabilitation/widgets/main_drawer.dart';
import '../model/exercise.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final ExerciseController _controller = ExerciseController();

  @override
  Widget build(BuildContext context) {
    AuthService auth = AuthService();
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: DefaultAppBar(
            title: RichText(
              text: TextSpan(
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  children: [
                    const TextSpan(
                        text: 'Welcome,\n',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontFamily: 'din',
                          fontSize: 24,
                        )),
                    TextSpan(
                        text: auth.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'proxima_ssv',
                          fontSize: 30,
                        ))
                  ]),
            ),
          )),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: FutureBuilder(
          future: _controller.fetchWeekExercises(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Exercise>> snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  WidgetFactory.card(
                      child: Checklist(
                          exercises: _sumDayProgress(snapshot.data!))),
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
                              onTap: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GameScreen()))
                              },
                              child: Image.asset('assets/Dashboard-button1.png',
                                  fit: BoxFit.fill),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(8),
                            child: GestureDetector(
                              onTap: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ExercisesScreen()))
                              },
                              child: Image.asset('assets/Dashboard-button2.png',
                                  fit: BoxFit.fill),
                            ),
                          )
                        ],
                      )),
                  const Text('History', textScaleFactor: 1.3),
                  WidgetFactory.card(
                      child: Container(
                    height: 225,
                    padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                    child: Histogram(exercises: snapshot.data!),
                  ))
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

  List<Exercise> _sumDayProgress(List<Exercise> exercises) {
    int dayCount = 0;
    int dayDone = 0;
    DateTime today = DateTime.now();
    for (final e in exercises) {
      if (!e.date.isSameDate(today)) {
        continue;
      }
      dayCount += e.count;
      dayDone += e.done > e.count ? e.count : e.done;
    }
    return [Exercise('0', today, '', dayCount, dayDone)];
  }
}
