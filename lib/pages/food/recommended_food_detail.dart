import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/route/route_helper.dart';
import 'package:store_app/util/app_constant.dart';
import 'package:store_app/util/dimension.dart';
import 'package:store_app/widgets/app_column.dart';
import 'package:store_app/widgets/app_icon.dart';
import 'package:store_app/widgets/expandable_text.dart';

import '../../controller/cart_controller.dart';
import '../../controller/popular_product_controller.dart';
import '../../controller/recommended_product_controller.dart';
import '../../widgets/big_text.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedFoodDetail(
      {Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    // print("Page id is" + pageId.toString());
    // print("product name is " + product.name.toString());
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: Dimensions.height40,
                title: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: (() {
                            if (page == "cartpage") {
                              Get.toNamed(RouteHelper.getCartPage());
                            } else {
                              Get.toNamed(RouteHelper.getInitial());
                            }
                          }),
                          child: AppIcon(icon: Icons.arrow_back_ios)),
                      GetBuilder<PopularProductController>(
                          builder: (controller) {
                        return Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(RouteHelper.getCartPage());
                              },
                              child: AppIcon(
                                icon: Icons.shopping_cart_outlined,
                              ),
                            ),
                            Get.find<PopularProductController>().totalItems >= 1
                                ? Positioned(
                                    right: 0,
                                    top: 0,
                                    child: AppIcon(
                                      icon: Icons.circle,
                                      size: 18,
                                      iconColor: Colors.transparent,
                                      backgroundColor: Colors.green,
                                    ),
                                  )
                                : Container(),
                            Get.find<PopularProductController>().totalItems >= 1
                                ? Positioned(
                                    right: 4,
                                    top: 3,
                                    child: BigText(
                                      text: Get.find<PopularProductController>()
                                          .totalItems
                                          .toString(),
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                  )
                                : Container()
                          ],
                        );
                      })
                    ],
                  ),
                ),
                pinned: true,
                backgroundColor: Colors.transparent,
                bottom: PreferredSize(
                    preferredSize: Size.fromHeight(0), child: Container()),
                expandedHeight: MediaQuery.of(context).size.height * 0.4,
                flexibleSpace: FlexibleSpaceBar(
                  background: CachedNetworkImage(
                    imageUrl: AppConstant.BASE_URL +
                        AppConstant.UPLOAD_URL +
                        product.img!,
                    fit: BoxFit.fitHeight,
                    width: double.maxFinite,
                  ),
                )),
            SliverToBoxAdapter(
                child: Container(
              padding: EdgeInsets.all(Dimensions.radius15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20))),
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              child: Column(
                children: [
                  Container(
                    child: AppColumn(
                      text: product.name!,
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BigText(text: "Discription"),
                      Container(
                        // margin: EdgeInsets.only(bottom: 60),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius15),
                            color: Colors.black12),
                        child: Row(
                          children: [
                            BigText(text: "Price"),
                            SizedBox(
                              width: Dimensions.width5,
                            ),
                            Text(
                              "-",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            SizedBox(
                              width: Dimensions.width5,
                            ),
                            BigText(text: "${product.price!} MMK")
                          ],
                        ),
                      )
                    ],
                  )),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  ExpandableText(text: product.description!),
                ],
              ),
            )),
          ],
        ),
        bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (recommendedProduct) {
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
                  color: Color.fromARGB(95, 155, 153, 153)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        // top: Dimensions.height20,
                        // bottom: Dimensions.height20,
                        left: Dimensions.width20,
                        right: Dimensions.width20),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: Colors.transparent),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            recommendedProduct.setQuantity(false);
                          },
                          child: AppIcon(
                            icon: Icons.remove,
                            size: 40,
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.width10,
                        ),
                        BigText(
                          text: recommendedProduct.inCartItems.toString(),
                        ),
                        SizedBox(
                          width: Dimensions.width10,
                        ),
                        GestureDetector(
                          onTap: () {
                            recommendedProduct.setQuantity(true);
                          },
                          child: AppIcon(
                            icon: Icons.add,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      recommendedProduct.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.all(14),
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: Colors.green),
                      child: BigText(text: "Add To Cart"),
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
