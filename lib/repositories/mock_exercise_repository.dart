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
      Exercise('3', today, 'Left Arm Stretch', 10, 8),
      Exercise('4', today, 'Right Elbow Bend', 10, 4),
      Exercise('5', today, 'Left Elbow Bend', 10, 10),
      Exercise('6', today, 'Hand Raise', 10, 2),
      Exercise('7', today.subtract(const Duration(days: 1)), 'Left Arm Stretch',
          20, 2),
      Exercise('8', today.subtract(const Duration(days: 2)),
          'Right Arm Stretch', 10, 3),
      Exercise('9', today.subtract(const Duration(days: 3)), 'Left Arm Stretch',
          20, 8),
      Exercise('10', today.subtract(const Duration(days: 4)),
          'Right Arm Stretch', 20, 4),
      Exercise('11', today.subtract(const Duration(days: 5)), 'Left Arm Stretch',
          20, 6),
      Exercise('12', today.subtract(const Duration(days: 6)),
          'Right Arm Stretch', 20, 4),
      Exercise('13', today.add(const Duration(days: 1)),
          'Right Arm Stretch', 20, 1),
      Exercise('14', today.add(const Duration(days: 2)),
          'Right Arm Stretch', 20, 19),
      Exercise('15', today.add(const Duration(days: 3)),
          'Right Arm Stretch', 20, 11),
      Exercise('16', today.add(const Duration(days: 4)),
          'Right Arm Stretch', 20, 10),
      Exercise('17', today.add(const Duration(days: 5)),
          'Right Arm Stretch', 20, 20),
      Exercise('18', today.add(const Duration(days: 6)),
          'Right Arm Stretch', 20, 12),
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

  @override
  Future<List<Exercise>> getExercises(DateTime startDate, DateTime endDate) async {
    return _exercises.where((e) => e.date.compareTo(startDate) >= 0 && e.date.compareTo(endDate) <= 0).toList();
  }
}
