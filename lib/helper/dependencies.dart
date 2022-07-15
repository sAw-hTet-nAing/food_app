import 'package:get/get.dart';
import 'package:store_app/controller/cart_controller.dart';
import 'package:store_app/controller/popular_product_controller.dart';
import 'package:store_app/data/api/api_client.dart';
import 'package:store_app/data/repository/cart_repo.dart';
import 'package:store_app/data/repository/popular_product_repo.dart';
import 'package:store_app/util/app_constant.dart';

import '../controller/recommended_product_controller.dart';
import '../data/repository/recommended_product_repo.dart';

Future<void> init() async {
  //api
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstant.BASE_URL));
  //repo
  Get.lazyPut(() => CartRepo());
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  //controller
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
}
