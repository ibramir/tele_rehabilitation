import 'package:tele_rehabilitation/repositories/exercise_repository.dart';
import 'package:tele_rehabilitation/repositories/mock_exercise_repository.dart';

import '../model/exercise.dart';

class ExerciseController {
  late final ExerciseRepository _repository;

  ExerciseController() {
    _repository = MockExerciseRepository();
  }

  Future<List<Exercise>> getDayExercises() {
    return _repository.getDayExercises();
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