import 'package:dio/dio.dart';
import 'package:tele_rehabilitation/model/exercise.dart';
import 'package:tele_rehabilitation/repositories/exercise/sources/exercise_data_source.dart';
import 'package:tele_rehabilitation/utils/api_client.dart';
import 'package:tele_rehabilitation/utils/helpers.dart';

class RemoteExerciseDataSource extends ExerciseDataSource {
  static late final RemoteExerciseDataSource _instance;

  factory RemoteExerciseDataSource() {
    return _instance;
  }

  factory RemoteExerciseDataSource.initialize(String historyId) {
    _instance = RemoteExerciseDataSource._(historyId);
    return _instance;
  }

  RemoteExerciseDataSource._(this._historyId);

  late final String _historyId;
  final ApiClient _apiClient = ApiClient();

  @override
  Future<List<Exercise>> getDayExercises() async {
    DateTime startDate = DateTime.now().dayOnly();
    DateTime endDate = startDate.endOfDay();
    return getExercises(startDate, endDate);
  }

  @override
  Future<List<Exercise>> getExercises(
      DateTime? startDate, DateTime? endDate) async {
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
