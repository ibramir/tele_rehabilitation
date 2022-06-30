import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tele_rehabilitation/utils/api_client.dart';

class AuthService {
  static final AuthService _instance = AuthService._();

  factory AuthService() {
    return _instance;
  }

  AuthService._();

  final ApiClient _apiClient = ApiClient();
  bool _loggedIn = false;
  String? _name;
  String? _email;
  String? _historyId;
  String? _doctorId;

  String? get name => _name;
  String? get email => _email;
  String? get historyId => _historyId;
  String? get doctorId => _doctorId;

  bool isLoggedIn() {
    return _loggedIn;
  }

  Future<bool> login(String email, String password) async {
    try {
      Response response = await _apiClient.login(email, password);
      _apiClient.authKey = response.data['auth_key'];
      _loggedIn = true;
      response = await _apiClient.getPatient();
      var patient = response.data['patient'];
      _historyId = patient['history'];
      _name = patient['name'];
      _email = patient['email'];
      _doctorId = patient['doctor'];
      return true;
    } on DioError catch (e) {
      log('Login failed', error: e);
      return false;
    }
  }
}