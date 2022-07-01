import 'package:dio/dio.dart';
import 'package:tele_rehabilitation/model/exercise.dart';
import 'package:tele_rehabilitation/repositories/exercise_repository.dart';
import 'package:tele_rehabilitation/utils/api_client.dart';
import 'package:tele_rehabilitation/utils/helpers.dart';

class RemoteExerciseRepository extends ExerciseRepository {
  static late final RemoteExerciseRepository _instance;

  factory RemoteExerciseRepository() {
    return _instance;
  }

  factory RemoteExerciseRepository.initialize(String historyId) {
    _instance = RemoteExerciseRepository._(historyId);
    return _instance;
  }

  RemoteExerciseRepository._(this._historyId);

  late final String _historyId;
  final ApiClient _apiClient = ApiClient();

  @override
  Future<List<Exercise>> getDayExercises() async {
    DateTime startDate = DateTime.now().dayOnly();
    DateTime endDate = startDate.addDay();
    return getExercises(startDate, endDate);
  }

  @override
  Future<List<Exercise>> getExercises(DateTime? startDate, DateTime? endDate) async {
    Response response = await _apiClient.getRecords(_historyId,
        startDate: startDate, endDate: endDate);
    List<Map<String, dynamic>> records = response.data['records'];
    return records.map((e) => Exercise.fromJson(e)).toList();
  }

  @override
  Future<void> update(Exercise exercise) async {
    await _apiClient.updateRecord(exercise.id, exercise.done);
  }

  @override
  Future<List<Exercise>> getAllExercises() async {
    return getExercises(null, null);
  }
}
