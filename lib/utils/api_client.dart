import 'package:dio/dio.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._();

  factory ApiClient() {
    return _instance;
  }

  final Dio _dio =
      Dio(BaseOptions(baseUrl: 'https://telerehabapi.herokuapp.com/api/'));
  bool _authToken = false;

  ApiClient._();

  set authKey(String authToken) {
    _dio.options.headers['auth_token'] = authToken;
    _authToken = true;
  }

  void _checkAuthToken() {
    if (!_authToken) {
      throw StateError('No auth key found');
    }
  }

  Future<Response> login(String email, String password) {
    return _dio.post('login', data: {email, password});
  }

  Future<Response> getPatient() {
    _checkAuthToken();
    return _dio.get('patient/records/getPatient');
  }

  Future<Response> getDoctor(String doctorId) {
    return _dio.get('doctor/getDoctor/id=$doctorId');
  }

  Future<Response> getRecords(
      String historyId, {DateTime? startDate, DateTime? endDate}) {
    _checkAuthToken();
    String date = '';
    if (startDate != null && endDate != null) {
      date =
          '&gt=${startDate.toIso8601String()}&ls=${endDate.toIso8601String()}';
    }
    return _dio.get('patient/records/getPatientRecords/id=$historyId$date');
  }

  Future<Response> updateRecord(String record, int done) {
    _checkAuthToken();
    return _dio
        .post('patient/records/updatePatientRecord', data: {record, done});
  }
}
