import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/home/food_page_body.dart';
import 'package:store_app/util/dimension.dart';
import 'package:store_app/widgets/big_text.dart';
import 'package:store_app/widgets/small_text.dart';

import '../controller/popular_product_controller.dart';
import '../controller/recommended_product_controller.dart';

class MainFoodPage extends StatefulWidget {
  MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPoppularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    // print("width is" + MediaQuery.of(context).size.height.toString());
    // print("width is" + MediaQuery.of(context).size.width.toString());
    return Scaffold(
        body: RefreshIndicator(
      child: Column(
        children: [
          //showing header
          Container(
            margin: EdgeInsets.only(
                top: Dimensions.height40, bottom: Dimensions.height15),
            padding: EdgeInsets.only(
                left: Dimensions.width20, right: Dimensions.width20),
            child: Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(
                      text: "Myanmar",
                      color: Colors.green,
                      size: Dimensions.size25,
                    ),
                    Row(
                      children: [
                        Smalltext(
                          text: "Saw",
                          color: Colors.black54,
                          size: Dimensions.size18,
                        ),
                        Icon(Icons.arrow_drop_down_rounded)
                      ],
                    )
                  ],
                ),
                Center(
                  child: Container(
                    width: Dimensions.height40,
                    height: Dimensions.height40,
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: Dimensions.size24,
                    ),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15),
                        color: Colors.green),
                  ),
                )
              ],
            )),
          ),
          //showing body
          Expanded(
              child: SingleChildScrollView(
            child: FoodPageBody(),
          )),
        ],
      ),
      onRefresh: _loadResource,
      color: Colors.green,
    ));
  }
}
