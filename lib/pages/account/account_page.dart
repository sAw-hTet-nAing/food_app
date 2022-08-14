import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:store_app/controller/auth_controller.dart';
import 'package:store_app/controller/cart_controller.dart';
import 'package:store_app/controller/location_controller.dart';
import 'package:store_app/controller/user_controller.dart';
import 'package:store_app/route/route_helper.dart';
import 'package:store_app/util/dimension.dart';
import 'package:store_app/widgets/account_widget.dart';
import 'package:store_app/widgets/app_icon.dart';
import 'package:store_app/widgets/big_text.dart';
import 'package:store_app/widgets/customloader.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  _loadUserInfo() async {
    await Get.find<LocationController>().getAddressList();
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      var address = Get.find<LocationController>().addressList[0];
      await Get.find<LocationController>().saveUserAddress(address);
      print("I am in home page ............");
    } else {
      print("addresslist is empty");
    }
  }

  @override
  Widget build(BuildContext context) {
    bool _userLoggedin = Get.find<AuthController>().UserLogin();

    if (_userLoggedin) {
      Get.find<UserController>().getUserInfo();
      // print("user logged in");
    }
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.green,
            title: BigText(
              text: "Profile",
              size: 24,
              color: Colors.white,
            )),
        body: GetBuilder<UserController>(
          builder: (userController) {
            return _userLoggedin == true
                ? (userController.isloading
                    ? CustomLoader()
                    : SingleChildScrollView(
                        child: Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(top: Dimensions.height20),
                          child: Column(
                            children: [
                              //profile pic
                              AppIcon(
                                icon: Icons.person,
                                backgroundColor: Colors.green,
                                iconColor: Colors.white,
                                iconSize: Dimensions.height15 * 5,
                                size: Dimensions.height15 * 10,
                              ),
                              SizedBox(
                                height: Dimensions.height30,
                              ),
                              //name
                              AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.person,
                                    backgroundColor: Colors.green,
                                    iconColor: Colors.white,
                                    size: Dimensions.height10 * 5,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                  ),
                                  bigText: BigText(
                                    text: '${userController.userModel.fName}',
                                  )),
                              SizedBox(
                                height: Dimensions.width10,
                              ),
                              //phone
                              AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.phone,
                                    backgroundColor: Colors.amber,
                                    iconColor: Colors.white,
                                    size: Dimensions.height10 * 5,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                  ),
                                  bigText: BigText(
                                      text:
                                          '${userController.userModel.phone}')),
                              SizedBox(
                                height: Dimensions.width10,
                              ),
                              //email
                              AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.email_outlined,
                                    backgroundColor: Colors.amber,
                                    iconColor: Colors.white,
                                    size: Dimensions.height10 * 5,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                  ),
                                  bigText: BigText(
                                      text:
                                          '${userController.userModel.email}')),
                              SizedBox(
                                height: Dimensions.width10,
                              ),
                              //address
                              AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.location_on_outlined,
                                    backgroundColor: Colors.amber,
                                    iconColor: Colors.white,
                                    size: Dimensions.height10 * 5,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                  ),
                                  bigText: BigText(
                                    text: "Fill your address",
                                  )),
                              SizedBox(
                                height: Dimensions.width10,
                              ),
                              //messages
                              AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.message,
                                    backgroundColor: Colors.redAccent,
                                    iconColor: Colors.white,
                                    size: Dimensions.height10 * 5,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                  ),
                                  bigText: BigText(
                                    text: "SawHtetNaing",
                                  )),
                              SizedBox(
                                height: Dimensions.width10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (Get.find<AuthController>().UserLogin()) {
                                    Get.find<AuthController>()
                                        .clearSharedData();
                                    Get.find<CartController>().clear();
                                    Get.find<CartController>()
                                        .clearCartHistory();
                                    Get.offNamed(RouteHelper.getSplashPage());
                                  }
                                },
                                child: AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.logout_outlined,
                                      backgroundColor: Colors.redAccent,
                                      iconColor: Colors.white,
                                      size: Dimensions.height10 * 5,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                    ),
                                    bigText: BigText(
                                      text: "Logout",
                                    )),
                              ),
                              SizedBox(
                                height: Dimensions.width20,
                              ),
                            ],
                          ),
                        ),
                      ))
                : Column(
                    children: [
                      SizedBox(
                        height: Dimensions.screeHigh * 0.03,
                      ),
                      Container(
                        child: Center(
                            child: Container(
                          child: Image.asset("assets/image/signuptocon.png"),
                        )),
                      ),
                      Container(
                        padding: EdgeInsets.all(Dimensions.height10 / 2),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius15)),
                        child: TextButton(
                            onPressed: () {
                              Get.toNamed(RouteHelper.getLoginPage());
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.font18,
                                  fontWeight: FontWeight.bold),
                            )),
                      )
                    ],
                  );
          },
        ));
  }
}
