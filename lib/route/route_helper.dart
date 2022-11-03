import 'package:get/get.dart';
import 'package:store_app/home/main_food_page.dart';
import 'package:store_app/pages/Address/add_address_page.dart';
import 'package:store_app/pages/Address/pick_address_map.dart';

import 'package:store_app/pages/auth/signin_page.dart';
import 'package:store_app/pages/cart/cart_page.dart';
import 'package:store_app/home/home_page.dart';
import 'package:store_app/pages/food/popular_food_detail.dart';
import 'package:store_app/pages/splash/splash.dart';

import '../pages/food/recommended_food_detail.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String loginPage = "/loginpage";
  static const String mainFoodPage = "/mainfoodpage";
  static const String addAddressPage = "/addAddressPage";
  static const String pickAddressMap = '/pick-address';

  static String getSplashPage() => '$splashPage';
  static String getInitial() => '$initial';
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';

  static String getCartPage() => '$cartPage';
  static String getLoginPage() => "$loginPage";
  static String getMainFoodPage() => '$mainFoodPage';
  static String getAddAddressPage() => '$addAddressPage';
  static String getPickAddressPage() => '$pickAddressMap';

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => SplashScreen()),
    GetPage(
        name: initial,
        page: () => HomePage(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 200)),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters["page"];
          return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 200)),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters["page"];
          return RecommendedFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 200)),
    GetPage(
        name: cartPage,
        page: () {
          return CartPage();
        },
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 200)),
    GetPage(
        name: loginPage,
        page: () {
          return SignInPage();
        },
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 200)),
    GetPage(
        name: mainFoodPage,
        page: () => MainFoodPage(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 200)),
    GetPage(
      name: addAddressPage,
      page: () => AddAddressPage(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: pickAddressMap,
      page: () {
        PickAddressMap _pickAddress = Get.arguments;
        return _pickAddress;
      },
      transition: Transition.leftToRightWithFade,
    ),
  ];
}
