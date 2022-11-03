import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/data/api/api_client.dart';
import 'package:store_app/model/address_model.dart';
import 'package:store_app/util/app_constant.dart';

class LocationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  LocationRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });
  Future<Response> getAddressFromGeoCode(LatLng latLng) async {
    return await apiClient.getData('${AppConstant.GEOCODE_URI}'
        '?lat=${latLng.latitude}&lng=${latLng.longitude}');
  }

  String getUserAddress() {
    return sharedPreferences.getString(AppConstant.USER_ADDRESS) ?? "";
  }

  Future<Response> addAddress(AddressModel addressModel) async {
    return await apiClient.postData(
        AppConstant.ADD_USERADDRESS, addressModel.toJson());
  }

  Future<Response> getAllAddress() async {
    return await apiClient.getData(AppConstant.ADDRESS_LIST_URI);
  }

  Future<bool> saveUserAddress(String address) async {
    apiClient.updateHeader(sharedPreferences.getString(AppConstant.TOKEN)!);
    return await sharedPreferences.setString(
        AppConstant.ADD_USERADDRESS, address);
  }

  Future<Response> getZone(String lat, String lng) async {
    return await apiClient.getData("${AppConstant.ZONE_URI}?lat=$lat&lng=$lng");
  }

  Future<Response> searchLocation(String text) async {
    return await apiClient
        .getData('${AppConstant.SEARCH_LOCATION_URI}?search_text=$text');
  }

  Future<Response> setLocation(String placeID) async {
    return await apiClient
        .getData('${AppConstant.PLACE_DETAILS_URI}?placeid=$placeID');
  }
}
