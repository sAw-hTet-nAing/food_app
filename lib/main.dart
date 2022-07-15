import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/controller/recommended_product_controller.dart';
import 'package:store_app/controller/popular_product_controller.dart';
import 'package:store_app/home/food_page_body.dart';
import 'package:store_app/home/main_food_page.dart';
import 'package:store_app/helper/dependencies.dart' as dep;
import 'package:store_app/pages/cart/cart_page.dart';
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
    Get.find<PopularProductController>().getPoppularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food-Order',
      home: MainFoodPage(),
      initialRoute: RouteHelper.initial,
      getPages: RouteHelper.routes,
    );
  }
}
