import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/data/api/api_client.dart';
import 'package:store_app/model/signup_body_model.dart';
import 'package:store_app/util/app_constant.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> registration(SignupBody signupBody) async {
    return await apiClient.postData(
        AppConstant.REGISTRATION_URI, signupBody.toJson());
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstant.TOKEN, token);
  }

  Future<Response> login(String phone, String password) async {
    return await apiClient.postData(
        AppConstant.SIGN_IN_URI, {"phone": phone, "password": password});
  }

  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstant.PHONE, number);
      await sharedPreferences.setString(AppConstant.PASSWORD, password);
    } catch (e) {
      throw e;
    }
  }

  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppConstant.TOKEN) ?? "None";
  }

  bool UserLogin() {
    return sharedPreferences.containsKey(AppConstant.TOKEN);
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstant.TOKEN);
    sharedPreferences.remove(AppConstant.PASSWORD);
    sharedPreferences.remove(AppConstant.PHONE);
    apiClient.token = "";
    apiClient.updateHeader('');
    return true;
  }
}
