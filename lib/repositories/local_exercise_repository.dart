import 'package:tele_rehabilitation/model/exercise.dart';
import 'package:tele_rehabilitation/repositories/exercise_repository.dart';

class LocalExerciseRepository extends ExerciseRepository {
  static final LocalExerciseRepository _instance = LocalExerciseRepository._();

  factory LocalExerciseRepository() {
    return _instance;
  }

  LocalExerciseRepository._();

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