import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/controller/cart_controller.dart';
import 'package:store_app/controller/recommended_product_controller.dart';
import 'package:store_app/controller/popular_product_controller.dart';

import 'package:store_app/helper/dependencies.dart' as dep;

import 'package:store_app/route/route_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(
      builder: (_) {
        return GetBuilder<RecommendedProductController>(builder: (_) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Food-Order',
            // home: SignInPage(),
            initialRoute: RouteHelper.getSplashPage(),
            getPages: RouteHelper.routes,
          );
        });
      },
    );
  }
}
