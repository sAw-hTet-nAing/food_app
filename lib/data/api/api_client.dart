import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/util/app_constant.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;
  SharedPreferences sharedPreferences;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 30); //AppConstant.Token
    token = sharedPreferences.getString(AppConstant.TOKEN) ?? "";
    // sharedPreferences.getString(AppConstant.TOKEN)
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      "HttpHeaders.contentTypeHeader": "application/json"
    };
  }
  Future<Response> getData(
    String uri, {
    Map<String, String>? headers,
  }) async {
    try {
      Response response = await get(uri, headers: headers ?? _mainHeaders);

      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body) async {
    print(body.toString());
    try {
      Response response = await post(uri, body, headers: _mainHeaders);
      print(response.toString());
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  void updateHeader(String token) {
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      "HttpHeaders.contentTypeHeader": "application/json"
    };
  }
}
