import 'package:tele_rehabilitation/model/exercise.dart';

abstract class ExerciseDataSource {
  Future<List<Exercise>> getDayExercises();

  Future<void> update(Exercise exercise);

  Future<List<Exercise>> getAllExercises();

  Future<List<Exercise>> getExercises(DateTime startDate, DateTime endDate);
}
