import 'package:flutter/material.dart';
import 'package:tele_rehabilitation/utils/exercise_controller.dart';
import 'package:tele_rehabilitation/widgets/checklist_card.dart';
import 'package:tele_rehabilitation/widgets/mainDrawer.dart';
import '../model/exercise.dart';

class GameScreen extends StatelessWidget {
  GameScreen({Key? key}) : super(key: key);

  final ExerciseController _controller = ExerciseController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: AppBar(
          centerTitle: true,
          flexibleSpace: ClipRRect(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30)),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/appbar_background.png'),
                    fit: BoxFit.fill),
              ),
            ),
          ),
          title: Text(
            "TeleRehab.",
            style: TextStyle(color: Colors.white, fontFamily: 'proxima_ssv'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30)),
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
                              child: Image.asset('assets/game-icon.png',
                                  fit: BoxFit.fill),
                            ),
                          ),
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
      ),
      drawer: MainDrawer(),
    );
  }
}
