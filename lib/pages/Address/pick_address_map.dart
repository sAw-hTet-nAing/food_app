import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:store_app/base/custom_buttom.dart';
import 'package:store_app/controller/location_controller.dart';
import 'package:store_app/pages/Address/widgets/search_location_dialog.dart';
import 'package:store_app/route/route_helper.dart';
import 'package:store_app/util/dimension.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSingup;
  final bool fromAddress;
  final GoogleMapController? googleMapController;
  PickAddressMap(
      {Key? key,
      required this.fromSingup,
      required this.fromAddress,
      this.googleMapController})
      : super(key: key);

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Get.find<LocationController>().addressList.isEmpty) {
      _initialPosition = LatLng(45.521708425968995, -122.67854869365692);
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        _initialPosition = LatLng(
            double.parse(Get.find<LocationController>().getAddress["latitude"]),
            double.parse(
                Get.find<LocationController>().getAddress["longtitude"]));
        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController) {
      return Scaffold(
        body: SafeArea(
            child: Center(
          child: SizedBox(
            width: double.maxFinite,
            child: Stack(children: [
              GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: _initialPosition, zoom: 17),
                zoomControlsEnabled: false,
                onCameraMove: (CameraPosition cameraPosition) {
                  _cameraPosition = cameraPosition;
                },
                onCameraIdle: () {
                  Get.find<LocationController>()
                      .updatePosition(_cameraPosition, false);
                },
                onMapCreated: (GoogleMapController mapController) {
                  _mapController = mapController;
                  if (!widget.fromAddress) {
                    // print("pick from web");
                    Get.find<LocationController>().getCurrentLocation(false,
                        mapController: mapController);
                  }
                },
              ),
              Center(
                  child: !locationController.loading
                      ? Image.asset(
                          "assets/image/pick_marker.png",
                          height: 50,
                          width: 50,
                        )
                      : CircularProgressIndicator()),
              //Showing and selecting address
              Positioned(
                  top: Dimensions.height15 * 3,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  child: InkWell(
                    onTap: () {
                      Get.dialog(
                          LocationDialogue(mapController: _mapController));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: Dimensions.width10),
                      height: Dimensions.height40,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15)),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.amber,
                          ),
                          Expanded(
                              child: Text(
                            "${locationController.pickPlacemark.name ?? ''}",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )),
                          SizedBox(
                            width: Dimensions.width10,
                          ),
                          Icon(
                            Icons.search,
                            size: 25,
                            color: Colors.amber,
                          )
                        ],
                      ),
                    ),
                  )),
              Positioned(
                  bottom: Dimensions.height20 * 3,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  child: locationController.isloading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : CustomButton(
                          width: Dimensions.width30 * 9,
                          buttonText: widget.fromAddress
                              ? "Pick Address"
                              : "Pick Location",
                          onPressed: (locationController.buttonDisable ||
                                  locationController.loading)
                              ? null
                              : () {
                                  if (locationController
                                              .pickPosition.latitude !=
                                          0 &&
                                      locationController.pickPlacemark.name !=
                                          null) {
                                    if (widget.fromAddress) {
                                      if (widget.googleMapController != null) {
                                        // print("now u can cliked onthis");
                                        widget.googleMapController!.moveCamera(
                                            CameraUpdate.newCameraPosition(
                                                CameraPosition(
                                                    target: LatLng(
                                                        locationController
                                                            .pickPosition
                                                            .latitude,
                                                        locationController
                                                            .pickPosition
                                                            .longitude))));
                                        locationController.setAddAddressData();
                                      }
                                      Get.toNamed(
                                          RouteHelper.getAddAddressPage());
                                    }
                                  }
                                },
                        ))
            ]),
          ),
        )),
      );
    });
  }
}
