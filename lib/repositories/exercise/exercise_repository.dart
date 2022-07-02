import 'package:tele_rehabilitation/repositories/exercise/sources/exercise_data_source.dart';
import 'package:tele_rehabilitation/repositories/exercise/sources/mock_exercise_data_source.dart';
import 'package:tele_rehabilitation/utils/helpers.dart';

import '../../model/exercise.dart';

class ExerciseRepository {
  static final ExerciseRepository _instance = ExerciseRepository._();

  factory ExerciseRepository() {
    return _instance;
  }

  ExerciseRepository._() {
    _dataSource = MockExerciseDataSource();
  }

  late final ExerciseDataSource _dataSource;
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
    List<Exercise> ret = await _dataSource.getDayExercises();
    _dayExercises = ret;
    return ret;
  }

  Future<void> update(Exercise exercise) {
    return _dataSource.update(exercise);
  }

  Future<List<Exercise>> getAllExercises() {
    return _dataSource.getAllExercises();
  }

  Future<List<Exercise>> getExercises(DateTime startDate, DateTime endDate) {
    return _dataSource.getExercises(startDate, endDate);
  }
}
