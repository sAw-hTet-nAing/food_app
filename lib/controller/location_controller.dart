import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:store_app/data/api/api_checker.dart';

import 'package:store_app/data/repository/location_repo.dart';
import 'package:store_app/model/address_model.dart';
import 'package:store_app/model/response_model.dart';
import 'package:google_maps_webservice/src/places.dart';

class LocationController extends GetxController implements GetxService {
  LocationRepo locationRepo;
  LocationController({required this.locationRepo});
  bool _loading = false;
  late Position _position;
  late Position _pickPosition;
  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();
  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;

  late List<AddressModel> _allAddressList;
  List<AddressModel> get allAddressList => _allAddressList;

  List<String> _addressTypeList = ["home", "office", "others"];
  List<String> get addressTypeList => _addressTypeList;
  int _addressTypeIndex = 0;
  int get addressTypeIndex => _addressTypeIndex;

  Placemark get placemark => _placemark;
  Placemark get pickPlacemark => _pickPlacemark;

  late GoogleMapController _mapController;

  GoogleMapController get mapController => _mapController;
  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  bool _updateAddressData = true;
  bool _changeAddress = true;

  Position get postion => _position;
  Position get pickPosition => _pickPosition;
  bool get loading => _loading;

  //service Zone
  bool _isloading = false;
  bool get isloading => _isloading;
  //whether the user is in service zone or not
  bool _inZone = false;
  bool get inZone => _inZone;
  //Showing and hiding button
  bool _buttonDisable = true;
  bool get buttonDisable => _buttonDisable;
  //Save the googlemap suggestions for address
  List<Prediction> _predictionList = [];

  void updatePosition(CameraPosition position, bool fromAddress) async {
    if (_updateAddressData) {
      _loading = true;
      update();
      try {
        if (fromAddress) {
          _position = Position(
              latitude: position.target.latitude,
              longitude: position.target.longitude,
              timestamp: DateTime.now(),
              heading: 1,
              accuracy: 1,
              altitude: 1,
              speedAccuracy: 1,
              speed: 1);
        } else {
          _pickPosition = Position(
              latitude: position.target.latitude,
              longitude: position.target.longitude,
              timestamp: DateTime.now(),
              heading: 1,
              accuracy: 1,
              altitude: 1,
              speedAccuracy: 1,
              speed: 1);
        }
        ResponseModel _responseModel = await getZone(
            position.target.latitude.toString(),
            position.target.longitude.toString(),
            false);
        //if button value is false we are in the service area
        _buttonDisable = !_responseModel.isSucess;
        if (_changeAddress) {
          String _address = await getAddressFromGeoCode(
              LatLng(position.target.latitude, position.target.longitude));
          fromAddress
              ? _placemark = Placemark(name: _address)
              : _pickPlacemark = Placemark(name: _address);
        } else {
          _changeAddress = true;
        }
      } catch (e) {
        print(e);
      }
      _loading = false;
      update();
    } else {
      _updateAddressData = true;
    }
  }

  Future<String> getAddressFromGeoCode(LatLng latLng) async {
    String _address = "Unknow Location Found";
    Response response = await locationRepo.getAddressFromGeoCode(latLng);
    if (response.body["status"] == 'OK') {
      _address = response.body["results"][0]['formatted_address'].toString();
      // print("address" + _address);
    } else {
      print("error getting googleapi");
    }
    update();
    return _address;
  }

  late Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;
  AddressModel getUserAddress() {
    late AddressModel _addressModel;
    //Converting to map using json Decode
    _getAddress = jsonDecode(locationRepo.getUserAddress());
    try {
      _addressModel =
          AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
    } catch (e) {}
    return _addressModel;
  }

  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  Future<ResponseModel> addAddress(AddressModel addressModel) async {
    _loading = true;
    update();
    Response response = await locationRepo.addAddress(addressModel);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      await getAddressList();
      String message = response.body["message"];
      responseModel = ResponseModel(true, message);
      await saveUserAddress(addressModel);
    } else {
      print("Cant save the address");
      responseModel = ResponseModel(true, response.statusText!);
    }

    update();
    return responseModel;
  }

  Future<void> getAddressList() async {
    Response response = await locationRepo.getAllAddress();
    if (response.statusCode == 200) {
      _addressList = [];
      _allAddressList = [];
      response.body.forEach((address) {
        _addressList.add(AddressModel.fromJson(address));
        _allAddressList.add(AddressModel.fromJson(address));
      });
    } else {
      _addressList = [];
      _allAddressList = [];
    }
    update();
  }

  Future<bool> saveUserAddress(AddressModel addressModel) async {
    String userAddress = jsonEncode(addressModel.toJson());
    return await locationRepo.saveUserAddress(userAddress);
  }

  void clearAddressList() {
    _addressList = [];
    _allAddressList = [];
    update();
  }

  String getUserAddressFromLocalStorage() {
    return locationRepo.getUserAddress();
  }

  void setAddAddressData() {
    _position = _pickPosition;
    _placemark = _pickPlacemark;
    _updateAddressData = false;
    update();
  }

  Future<ResponseModel> getZone(String lat, String lng, bool markerLoad) async {
    late ResponseModel _responseModel;
    if (markerLoad) {
      _loading = true;
    } else {
      _isloading = true;
    }
    update();
    Response response = await locationRepo.getZone(lat, lng);
    if (response.statusCode == 200) {
      _inZone = true;
      _responseModel = ResponseModel(true, response.body["zone_id"].toString());
    } else {
      _inZone = false;
      _responseModel = ResponseModel(true, response.statusText!);
    }
    if (markerLoad) {
      _loading = false;
    } else {
      _isloading = false;
    }
    //for debuging
    print("Zone response code is" + response.statusCode.toString());
    update();
    return _responseModel;
  }

  Future<AddressModel> getCurrentLocation(bool fromAddress,
      {required GoogleMapController mapController,
      LatLng? defaultLatLng,
      bool notify = true}) async {
    _loading = true;
    if (notify) {
      update();
    }
    AddressModel _addressModel;
    Position _myPosition;
    try {
      Position newLocalData = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      _myPosition = newLocalData;
      // print("I am from getcurrentPos1 "+defaultLatLng!.latitude.toString());
    } catch (e) {
      _myPosition = Position(
        latitude:
            defaultLatLng != null ? defaultLatLng.latitude : double.parse('0'),
        longitude:
            defaultLatLng != null ? defaultLatLng.longitude : double.parse('0'),
        timestamp: DateTime.now(),
        accuracy: 1,
        altitude: 1,
        heading: 1,
        speed: 1,
        speedAccuracy: 1,
      );
    }
    if (fromAddress) {
      _position = _myPosition;
    } else {
      _pickPosition = _myPosition;
    }
    if (mapController != null) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(_myPosition.latitude, _myPosition.longitude),
            zoom: 17),
      ));
    }
    Placemark _myPlaceMark;
    try {
      if (!GetPlatform.isWeb) {
        List<Placemark> placeMarks = await placemarkFromCoordinates(
            _myPosition.latitude, _myPosition.longitude);
        _myPlaceMark = placeMarks.first;
      } else {
        String _address = await getAddressFromGeoCode(
            LatLng(_myPosition.latitude, _myPosition.longitude));
        _myPlaceMark = Placemark(
            name: _address, locality: '', postalCode: '', country: '');
      }
    } catch (e) {
      String _address = await getAddressFromGeoCode(
          LatLng(_myPosition.latitude, _myPosition.longitude));
      _myPlaceMark =
          Placemark(name: _address, locality: '', postalCode: '', country: '');
    }
    fromAddress ? _placemark = _myPlaceMark : _pickPlacemark = _myPlaceMark;
    ResponseModel _responseModel = await getZone(
        _myPosition.latitude.toString(),
        _myPosition.longitude.toString(),
        true);
    _buttonDisable = !_responseModel.isSucess;
    _addressModel = AddressModel(
      latitude: _myPosition.latitude.toString(),
      longitude: _myPosition.longitude.toString(), addressType: 'others',
      //zoneId: _responseModel.isSuccess ? int.parse(_responseModel.message) : 0,
      address: '${_myPlaceMark.name ?? ''}'
          ' ${_myPlaceMark.locality ?? ''} '
          '${_myPlaceMark.postalCode ?? ''} '
          '${_myPlaceMark.country ?? ''}',
    );
    _loading = false;
    update();
    return _addressModel;
  }

  Future<List<Prediction>> searchLocation(
      BuildContext context, String text) async {
    if (text.isNotEmpty) {
      Response response = await locationRepo.searchLocation(text);
      if (response == 200 && response.body['status'] == 'OK') {
        _predictionList = [];
        response.body['predictions'].forEach((prediction) =>
            _predictionList.add(Prediction.fromJson(prediction)));
      } else {
        ApiChecker.checkApi(response);
      }
    }
    return _predictionList;
  }

  setLocation(
      String placeID, String address, GoogleMapController mapController) async {
    _loading = true;
    update();
    PlacesDetailsResponse detail;
    Response response = await locationRepo.setLocation(placeID);
    detail = PlacesDetailsResponse.fromJson(response.body);
    _pickPosition = Position(
        latitude: detail.result.geometry!.location.lat,
        longitude: detail.result.geometry!.location.lng,
        timestamp: DateTime.now(),
        accuracy: 1,
        altitude: 1,
        heading: 1,
        speedAccuracy: 1,
        speed: 1);
    _pickPlacemark = Placemark(name: address);
    _changeAddress = false;
    if (!mapController.isNull) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(detail.result.geometry!.location.lat,
              detail.result.geometry!.location.lng),
          zoom: 17)));
    }
    _loading = false;
    update();
  }
}
