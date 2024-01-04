import 'dart:convert';

import 'package:e_commerce_app/data/api/api_client.dart';
import 'package:e_commerce_app/models/login_model.dart';
import 'package:e_commerce_app/models/sign_up_model.dart';
import 'package:e_commerce_app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.sharedPreferences,required this.apiClient});

  Future<Response> registration(SignUpModel signUpBody) {
    return apiClient.postData(AppConstants.REGISTRATION_URI, jsonEncode(signUpBody));
  }

  Future<Response> login(LoginModel loginBody) {
    return apiClient.postData(AppConstants.LOGIN_URI, jsonEncode(loginBody));
  }

  saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader();
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

}