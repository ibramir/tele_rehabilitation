import 'package:tele_rehabilitation/model/exercise.dart';
import 'package:tele_rehabilitation/repositories/exercise/sources/exercise_data_source.dart';

class LocalExerciseDataSource extends ExerciseDataSource {
  static final LocalExerciseDataSource _instance = LocalExerciseDataSource._();

  factory LocalExerciseDataSource() {
    return _instance;
  }

  LocalExerciseDataSource._();

  @override
  Future<List<Exercise>> getAllExercises() {
    // TODO: implement getAllExercises
    throw UnimplementedError();
  }

  @override
  Future<List<Exercise>> getDayExercises() {
    // TODO: implement getDayExercises
    throw UnimplementedError();
  }

  @override
  Future<List<Exercise>> getExercises(DateTime startDate, DateTime endDate) {
    // TODO: implement getExercises
    throw UnimplementedError();
  }

  @override
  Future<void> update(Exercise exercise) {
    // TODO: implement update
    throw UnimplementedError();
  }

}