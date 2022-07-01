import 'package:tele_rehabilitation/repositories/exercise_repository.dart';
import 'package:tele_rehabilitation/repositories/mock_exercise_repository.dart';
import 'package:tele_rehabilitation/utils/helpers.dart';

import '../model/exercise.dart';

class ExerciseController {
  static final ExerciseController _instance = ExerciseController._();

  factory ExerciseController() {
    return _instance;
  }

  ExerciseController._() {
    _repository = MockExerciseRepository();
  }

  late final ExerciseRepository _repository;
  List<Exercise>? _dayExercises;

  Future<List<Exercise>> fetchWeekExercises() async {
    DateTime today = DateTime.now().dayOnly();
    DateTime weekStart = today.subtract(Duration(days: today.weekday - 1));
    DateTime weekEnd = today
        .add(Duration(days: DateTime.daysPerWeek - today.weekday))
        .endOfDay();
    List<Exercise> ret = await getExercises(weekStart, weekEnd);
    _dayExercises ??=
        ret.where((element) => element.date.isSameDate(today)).toList();
    return ret;
  }

  List<Exercise>? getDayExercises() {
    return _dayExercises;
  }

  Future<List<Exercise>> fetchDayExercises() async {
    if (_dayExercises != null) {
      return _dayExercises!;
    }
    List<Exercise> ret = await _repository.getDayExercises();
    _dayExercises = ret;
    return ret;
  }

  Future<void> update(Exercise exercise) {
    return _repository.update(exercise);
  }

  Future<List<Exercise>> getAllExercises() {
    return _repository.getAllExercises();
  }

  Future<List<Exercise>> getExercises(DateTime startDate, DateTime endDate) {
    return _repository.getExercises(startDate, endDate);
  }
}
