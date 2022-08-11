import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map_location_picker_flutter/google_map_location_picker_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:store_app/controller/auth_controller.dart';
import 'package:store_app/controller/location_controller.dart';
import 'package:store_app/controller/user_controller.dart';
import 'package:store_app/model/address_model.dart';
import 'package:store_app/util/dimension.dart';
import 'package:store_app/widgets/app_text_field.dart';
import 'package:store_app/widgets/big_text.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _islogged;
  CameraPosition _cameraPosition = CameraPosition(
      target: LatLng(19.668090000000063, 97.21409000000006), zoom: 17);
  late LatLng _initialPosition = LatLng(19.668090000000063, 97.21409000000006);

  @override
  void initState() {
    super.initState();
    _islogged = Get.find<AuthController>().UserLogin();
    if (_islogged && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      _cameraPosition = CameraPosition(
          target: LatLng(
              double.parse(
                  Get.find<LocationController>().getAddress['latitude']),
              double.parse(
                  Get.find<LocationController>().getAddress['longtitude'])));
      _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress['latitude']),
          double.parse(
              Get.find<LocationController>().getAddress['longtitude']));
    }
    Get.find<UserController>().getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Address"),
          backgroundColor: Colors.green,
        ),
        body: GetBuilder<UserController>(
          builder: (userController) {
            if (userController.userModel != null &&
                _contactPersonName.text.isEmpty) {
              _contactPersonName.text = '${userController.userModel.fName}';
              _contactPersonNumber.text = '${userController.userModel.phone}';
              if (Get.find<LocationController>().addressList.isNotEmpty) {
                _addressController.text =
                    Get.find<LocationController>().getUserAddress().address;
              }
            }
            return GetBuilder<LocationController>(
              builder: (locationcontroller) {
                _addressController.text =
                    '${locationcontroller.placemark.name ?? ''}'
                    '${locationcontroller.placemark.locality ?? ''}'
                    '${locationcontroller.placemark.postalCode ?? ''}'
                    '${locationcontroller.placemark.country ?? ''}';
                // print("Address in my view" + _addressController.text);
                return SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: Dimensions.height10 / 2,
                              left: Dimensions.height10 / 2,
                              right: Dimensions.height10 / 2),
                          height: 140,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(width: 2, color: Colors.black)),
                          child: Stack(children: [
                            GoogleMap(
                              initialCameraPosition: CameraPosition(
                                  target: _initialPosition, zoom: 17),
                              zoomControlsEnabled: false,
                              compassEnabled: false,
                              indoorViewEnabled: true,
                              mapToolbarEnabled: false,
                              myLocationButtonEnabled: true,
                              onCameraIdle: (() {
                                locationcontroller.updatePosition(
                                    _cameraPosition, true);
                              }),
                              onCameraMove: ((position) {
                                _cameraPosition = position;
                              }),
                              onMapCreated: (GoogleMapController controller) {
                                locationcontroller.setMapController(controller);
                              },
                            )
                            // showGoogleMapLocationPicker(
                            //     pinWidget: Icon(
                            //       Icons.location_pin,
                            //       color: Colors.red,
                            //       size: 55,
                            //     ),
                            //     pinColor: Colors.blue,
                            //     context: context,
                            //     addressPlaceHolder: " saw1",
                            //     addressTitle: "saw",
                            //     apiKey:
                            //         "YAIzaSyBVW5p63EEGvf7vjdRg2p7KGhU5o8_8MOw",
                            //     appBarTitle: "user address",
                            //     confirmButtonColor: Colors.blue,
                            //     confirmButtonText: " ",
                            //     confirmButtonTextColor: Colors.black,
                            //     country: "MM",
                            //     language: "Eng",
                            //     searchHint: " ",
                            //     initialLocation: _initialPosition,
                            //     ),
                          ]),
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        SizedBox(
                          height: 50,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  locationcontroller.addressTypeList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    locationcontroller
                                        .setAddressTypeIndex(index);
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          left: Dimensions.width10,
                                          right: Dimensions.width10),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Dimensions.width20,
                                          vertical: Dimensions.height10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius20 / 4),
                                          color: Theme.of(context).canvasColor,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey[200]!,
                                                spreadRadius: 1,
                                                blurRadius: 5)
                                          ]),
                                      child: Icon(
                                        index == 0
                                            ? Icons.home_outlined
                                            : index == 1
                                                ? Icons.work
                                                : Icons.location_on,
                                        color: locationcontroller
                                                    .addressTypeIndex ==
                                                index
                                            ? Colors.amber
                                            : Theme.of(context).disabledColor,
                                      )),
                                );
                              }),
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: Dimensions.width20),
                            child: BigText(
                              text: "Delivery Address",
                              color: Colors.green,
                            )),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        AppTextFiled(
                            textEditingController: _addressController,
                            hintText: "Your Address",
                            icon: Icons.map_outlined),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: Dimensions.width20),
                            child: BigText(
                              text: "Contact Name",
                              color: Colors.green,
                            )),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        AppTextFiled(
                            textEditingController: _contactPersonName,
                            hintText: "Your Name",
                            icon: Icons.person),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: Dimensions.width20),
                            child: BigText(
                              text: "Contact Number",
                              color: Colors.green,
                            )),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        AppTextFiled(
                            textEditingController: _contactPersonNumber,
                            hintText: "Your Number",
                            icon: Icons.contact_phone),
                      ]),
                );
              },
            );
          },
        ),
        bottomNavigationBar: GetBuilder<LocationController>(
          builder: (locationController) {
            return Container(
              height: Dimensions.bottomHeightbar,
              padding: EdgeInsets.only(
                  top: Dimensions.height20,
                  bottom: Dimensions.height20,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20 * 2),
                    topRight: Radius.circular(Dimensions.radius20 * 2)),
                // color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      print("I am from adding address screen " +
                          _addressController.text);
                      AddressModel _addressModel = AddressModel(
                          addressType: locationController
                              .addressList[locationController.addressTypeIndex],
                          contactPersonName: _contactPersonName.text,
                          contactPersonNumber: _contactPersonNumber.text,
                          address: _addressController.text,
                          latitude:
                              locationController.postion.latitude.toString(),
                          longitude:
                              locationController.postion.longitude.toString());
                      locationController
                          .addAddress(_addressModel)
                          .then((response) {
                        if (response.isSucess) {
                          Get.back();
                          Get.snackbar("Address", "Address Save Successfully");
                        } else {
                          Get.snackbar("Error", "Address Didn't Save");
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(Dimensions.size18),
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: Colors.green),
                      child: BigText(
                        text: "Save Address",
                        color: Colors.white,
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
