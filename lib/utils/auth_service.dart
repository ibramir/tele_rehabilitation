import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tele_rehabilitation/model/doctor_data.dart';
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
  String? _doctorId ='62879ddca9860be979ad4230';
  DoctorData? _doctorData;

  String get name => _name?? '';
  String get email => _email?? '';
  String get historyId => _historyId?? '';
  String get doctorId => _doctorId?? '';

  bool isLoggedIn() {
    return _loggedIn;
  }

  Future<bool> sessionLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('authToken');
    if (authToken == null) {
      return false;
    }
    await _initialize(authToken);
    return true;
  }

  Future<bool> login(String email, String password) async {
    try {
      Response response = await _apiClient.login(email, password);
      String authToken = response.data['token'];
      await _initialize(authToken);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', authToken);
      return true;
    } on DioError catch (e) {
      log('Login failed', error: e);
      return false;
    }
  }

  Future<void> _initialize(String authToken) async {
    _apiClient.authToken = authToken;
    _loggedIn = true;
    var response = await _apiClient.getPatient();
    var patient = response.data['patient'];
    _historyId = patient['history'];
    _name = patient['name'];
    _email = patient['email'];
    _doctorId = patient['doctor'];
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
    _apiClient.authToken = '';
    _doctorData = null;
    _loggedIn = false;
  }

  Future<DoctorData> getDoctor() async {
    if (_doctorData != null) {
      return _doctorData!;
    }
    var response = await _apiClient.getDoctor(doctorId);
    _doctorData = DoctorData.fromJson(response.data['doctor']);
    return _doctorData!;
  }
}