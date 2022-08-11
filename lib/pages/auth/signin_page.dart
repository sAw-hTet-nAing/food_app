import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:store_app/base/show_custom_snackbar.dart';
import 'package:store_app/controller/auth_controller.dart';
import 'package:store_app/pages/auth/signup_page.dart';
import 'package:store_app/route/route_helper.dart';
import 'package:store_app/util/dimension.dart';
import 'package:store_app/widgets/app_text_field.dart';
import 'package:store_app/widgets/customloader.dart';

import '../../model/signup_body_model.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    var _isloading = false;

    void _login() {
      var authController = Get.find<AuthController>();

      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();
      if (phone.isEmpty) {
        ShowCustomSnackBar("Phone can't be Empty!", title: "Phone");
      } else if (password.isEmpty) {
        ShowCustomSnackBar("Password can't be Empty!", title: "Password");
      } else if (password.length < 6) {
        ShowCustomSnackBar("Password can not be less than 6 characters",
            title: "Password");
      } else {
        authController.login(phone, password).then((status) {
          if (status.isSucess) {
            GetSnackBar(
              title: "Success",
              message: "Logged In",
            );
            Get.toNamed(RouteHelper.getInitial());
          } else {
            ShowCustomSnackBar(status.message);
          }
        });
      }
    }

    return GetBuilder<AuthController>(builder: (_authController) {
      return Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              //logo
              Container(
                margin: EdgeInsets.only(top: Dimensions.height40),
                alignment: Alignment.center,
                // height: Dimensions.screeHigh * 0.25,
                child: Center(
                  child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: Dimensions.size25 * 4,
                      backgroundImage: AssetImage("assets/image/Logofood.png")),
                ),
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              Container(
                margin: EdgeInsets.only(left: Dimensions.width20),
                child: Column(
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.font26 * 1.5,
                          color: Colors.amber),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: Dimensions.height10,
              ),

              AppTextFiled(
                textEditingController: phoneController,
                hintText: "Enter Your Phone",
                icon: Icons.phone_iphone_sharp,
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              AppTextFiled(
                  isObsecure: true,
                  textEditingController: passwordController,
                  hintText: "Enter Your Password",
                  icon: Icons.password_outlined),

              SizedBox(
                height: Dimensions.height20,
              ),
              GestureDetector(
                onTap: (() {
                  _login();
                }),
                child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(Dimensions.height10 / 2),
                    width: Dimensions.screeWidth * 0.4,
                    height: Dimensions.screeHigh / 13,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius30),
                        color: Colors.green),
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimensions.font18,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              SizedBox(
                height: Dimensions.height10,
              ),
              RichText(
                  text: TextSpan(
                text: "Don't have an account?",
                style: TextStyle(
                    color: Colors.black54, fontSize: Dimensions.font16),
                children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.to(
                              SignupPage(),
                              transition: Transition.leftToRightWithFade,
                            ),
                      text: " Create",
                      style: TextStyle(
                          color: Colors.green.withOpacity(0.7),
                          fontSize: Dimensions.font16,
                          fontWeight: FontWeight.bold))
                ],
              )),
              SizedBox(
                height: Dimensions.height10,
              ),
              _authController.isloading ? CustomLoader() : Container()
            ],
          ),
        ),
      );
    });
  }
}
