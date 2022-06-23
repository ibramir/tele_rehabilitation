import 'package:tele_rehabilitation/model/exercise.dart';
import 'package:tele_rehabilitation/repositories/exercise_repository.dart';

class MockExerciseRepository extends ExerciseRepository {
  static final MockExerciseRepository _instance = MockExerciseRepository._();

  factory MockExerciseRepository() {
    return _instance;
  }

  late final List<Exercise> _exercises;
  late final DateTime today;

  MockExerciseRepository._() {
    today = DateTime.now();

    _exercises = [
      Exercise('1', today, 'Right Arm Stretch', 10, 0),
      Exercise('2', today, 'Left Arm Stretch', 10, 8),
      Exercise('3', today.subtract(const Duration(days: 1)), 'Left Leg Stretch',
          10, 7),
      Exercise('4', today.subtract(const Duration(days: 2)),
          'Right Leg Stretch', 10, 10),
      Exercise('5', today.subtract(const Duration(days: 3)), 'Left Leg Stretch',
          10, 5),
      Exercise('6', today.subtract(const Duration(days: 4)),
          'Right Leg Stretch', 6, 10),
      Exercise('7', today.subtract(const Duration(days: 5)), 'Left Leg Stretch',
          10, 7),
      Exercise('8', today.subtract(const Duration(days: 6)),
          'Right Leg Stretch', 10, 4),
      Exercise('9', today.subtract(const Duration(days: 7)),
          'Right Leg Stretch', 10, 9),
    ];
  }

  @override
  Future<List<Exercise>> getAllExercises() async {
    return _exercises;
  }

  @override
  Future<List<Exercise>> getDayExercises() async {
    return _exercises.where((e) => e.date == today).toList();
  }

  @override
  Future<void> update(Exercise exercise) async {
    int i = _exercises.indexWhere((element) => element.id == exercise.id);
    _exercises[i] = exercise;
  }
}
