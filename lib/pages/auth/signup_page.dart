import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/base/show_custom_snackbar.dart';
import 'package:store_app/controller/auth_controller.dart';
import 'package:store_app/model/signup_body_model.dart';
import 'package:store_app/pages/auth/signin_page.dart';
import 'package:store_app/route/route_helper.dart';
import 'package:store_app/util/dimension.dart';
import 'package:store_app/widgets/app_text_field.dart';
import 'package:store_app/widgets/customloader.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var usernameController = TextEditingController();
    var phoneController = TextEditingController();
    var signupImg = ['t.png', 'f.png', 'g.png'];
    void _registration() {
      var authController = Get.find<AuthController>();
      String name = usernameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      if (name.isEmpty) {
        ShowCustomSnackBar("Name can't be Empty!", title: "Name");
      } else if (phone.isEmpty) {
        ShowCustomSnackBar("Phone can't be Empty!", title: "Phone");
      } else if (email.isEmpty) {
        ShowCustomSnackBar("Email can't be Empty!", title: "Email");
      } else if (!GetUtils.isEmail(email)) {
        ShowCustomSnackBar("Type valid Email address", title: "Email is valid");
      } else if (password.isEmpty) {
        ShowCustomSnackBar("Password can't be Empty!", title: "Password");
      } else if (password.length < 6) {
        ShowCustomSnackBar("Password can not be less than 6 characters",
            title: "Password");
      } else {
        SignupBody signupBody = SignupBody(
            name: name, phone: phone, email: email, password: password);
        authController.registration(signupBody).then((status) {
          if (status.isSucess) {
            ShowCustomSnackBar("Your account has been successfully created",
                title: "Success");
            // print("Success registration");
            Get.toNamed(RouteHelper.getInitial());
          } else {
            ShowCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: GetBuilder<AuthController>(
            builder: (_authController) {
              return Column(
                children: [
                  //logo
                  Container(
                    alignment: Alignment.center,
                    // height: Dimensions.screeHigh * 0.25,
                    child: Center(
                      child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: Dimensions.size25 * 4,
                          backgroundImage:
                              AssetImage("assets/image/Logofood.png")),
                    ),
                  ),

                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  AppTextFiled(
                      textEditingController: usernameController,
                      hintText: "Enter Your Name",
                      icon: Icons.person),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  AppTextFiled(
                      textEditingController: emailController,
                      hintText: "Enter Your Email",
                      icon: Icons.email_outlined),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  AppTextFiled(
                    textEditingController: phoneController,
                    hintText: "Enter Your Phone",
                    icon: Icons.phone_iphone_outlined,
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
                    onTap: () {
                      _registration();
                    },
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
                          "Sign up",
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
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.to(SignInPage(),
                                transition: Transition.leftToRightWithFade,
                                duration: Duration(milliseconds: 200)),
                          text: "Already have an account?",
                          style: TextStyle(
                              color: Colors.green.withOpacity(0.7),
                              fontSize: Dimensions.font16,
                              fontWeight: FontWeight.bold))),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  RichText(
                      text: TextSpan(
                          text: "Sign up With",
                          style: TextStyle(
                              color: Colors.green.withOpacity(0.7),
                              fontSize: Dimensions.font16))),
                  Wrap(
                    children: List.generate(
                        3,
                        (index) => Padding(
                              padding: EdgeInsets.all(8),
                              child: CircleAvatar(
                                  radius: Dimensions.radius20,
                                  backgroundImage: AssetImage(
                                      "assets/image/" + signupImg[index])),
                            )),
                  ),
                  _authController.isloading ? CustomLoader() : Container()
                ],
              );
            },
          )),
    );
  }
}
