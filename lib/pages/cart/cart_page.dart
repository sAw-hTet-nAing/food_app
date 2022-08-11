import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/base/no_data_page.dart';
import 'package:store_app/controller/auth_controller.dart';
import 'package:store_app/controller/cart_controller.dart';
import 'package:store_app/controller/location_controller.dart';
import 'package:store_app/controller/popular_product_controller.dart';
import 'package:store_app/route/route_helper.dart';
import 'package:store_app/util/app_constant.dart';
import 'package:store_app/util/dimension.dart';
import 'package:store_app/widgets/app_icon.dart';
import 'package:store_app/widgets/big_text.dart';
import 'package:store_app/widgets/small_text.dart';

import '../../controller/recommended_product_controller.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text("Your Shopping Cart",
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 26)),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.getMainFoodPage());
              },
              child: Container(
                  margin: EdgeInsets.only(right: Dimensions.width10 * 2),
                  child: Icon(
                    Icons.home_outlined,
                    color: Colors.black,
                  )),
            )
            // IconButton(
            //     onPressed: (() {}),
            //     icon: Icon(Icons.shopping_cart_checkout_outlined))
          ],
        ),
        body: Stack(
          children: [
            // Positioned(
            //   left: Dimensions.width20,
            //   right: Dimensions.width20,
            //   height: Dimensions.height20 * 4.5,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       GestureDetector(
            //         onTap: () {
            //           // Get.to();
            //         },
            //         child: AppIcon(
            //           icon: Icons.arrow_back_ios_outlined,
            //           iconColor: Colors.white,
            //           backgroundColor: Colors.green,
            //           size: 40,
            //         ),
            //       ),
            //       SizedBox(
            //         width: Dimensions.width20 * 7,
            //       ),
            //       GestureDetector(
            //         onTap: () {
            //           Get.to(MainFoodPage());
            //         },
            //         child: AppIcon(
            //           icon: Icons.home_outlined,
            //           iconColor: Colors.white,
            //           backgroundColor: Colors.black38,
            //           size: 40,
            //         ),
            //       ),
            //       AppIcon(
            //         icon: Icons.shopping_cart_outlined,
            //         iconColor: Colors.white,
            //         backgroundColor: Colors.green,
            //         size: 40,
            //       ),
            //       SizedBox(
            //         width: Dimensions.width10 / 8,
            //       )
            //     ],
            //   ),
            // ),
            GetBuilder<CartController>(builder: (_cartController) {
              return _cartController.getItems.length > 0
                  ? Positioned(
                      top: Dimensions.height10,
                      left: Dimensions.width10,
                      right: Dimensions.width10,
                      bottom: 0,
                      child: Container(
                          margin: EdgeInsets.only(top: Dimensions.height10),
                          child: MediaQuery.removePadding(
                              removeTop: true,
                              context: context,
                              child: GetBuilder<CartController>(
                                builder: (cartcontroller) {
                                  var _cartList = cartcontroller.getItems;
                                  return ListView.builder(
                                      itemCount: _cartList.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius20),
                                            border:
                                                Border.all(color: Colors.green),
                                          ),
                                          margin: EdgeInsets.only(
                                              bottom: Dimensions.height10),
                                          height: 100,
                                          width: double.maxFinite,
                                          child: Row(children: [
                                            GestureDetector(
                                              child: Container(
                                                width: Dimensions.width20 * 5,
                                                height: Dimensions.width20 * 5,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                .radius20),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            AppConstant
                                                                    .BASE_URL +
                                                                AppConstant
                                                                    .UPLOAD_URL +
                                                                cartcontroller
                                                                    .getItems[
                                                                        index]
                                                                    .img!),
                                                        fit: BoxFit.fitHeight)),
                                              ),
                                              onTap: () {
                                                var popularIndex = Get.find<
                                                        PopularProductController>()
                                                    .poppularProductList
                                                    .indexOf(_cartList[index]
                                                        .product!);
                                                if (popularIndex >= 0) {
                                                  Get.toNamed(RouteHelper
                                                      .getPopularFood(
                                                          popularIndex,
                                                          "cartpage"));
                                                } else {}
                                                var recommendedIndex = Get.find<
                                                        RecommendedProductController>()
                                                    .recommendedProductList
                                                    .indexOf(_cartList[index]
                                                        .product!);
                                                if (recommendedIndex < 0) {
                                                  Get.snackbar(
                                                      "History Product",
                                                      "Product review is not availble for history products",
                                                      backgroundColor:
                                                          Colors.white70,
                                                      colorText: Colors.green);
                                                } else {
                                                  Get.toNamed(RouteHelper
                                                      .getRecommendedFood(
                                                          recommendedIndex,
                                                          "cartpage"));
                                                }
                                              },
                                            ),
                                            Expanded(
                                                child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(
                                                        Dimensions.radius20),
                                                    bottomRight:
                                                        Radius.circular(
                                                            Dimensions
                                                                .radius20)),
                                              ),
                                              padding: EdgeInsets.only(
                                                  left: Dimensions.width10),
                                              height: Dimensions.height20 * 5,
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    BigText(
                                                      text: _cartList[index]
                                                          .name!,
                                                      color: Colors.black87,
                                                    ),
                                                    Smalltext(
                                                      text: "Spicy",
                                                      color: Colors.black26,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        BigText(
                                                          text:
                                                              "${cartcontroller.getItems[index].price!} MMK",
                                                          color: Colors.black87,
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets.only(
                                                              right: Dimensions
                                                                  .width5),
                                                          child: Row(
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  cartcontroller.addItem(
                                                                      _cartList[
                                                                              index]
                                                                          .product!,
                                                                      -1);
                                                                },
                                                                child: AppIcon(
                                                                  icon: Icons
                                                                      .remove,
                                                                  size: 35,
                                                                  iconColor:
                                                                      Colors
                                                                          .white,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .green,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: Dimensions
                                                                    .width10,
                                                              ),
                                                              BigText(
                                                                // text: popularProduct.inCartItems.toString(),
                                                                text: _cartList[
                                                                        index]
                                                                    .quantity
                                                                    .toString(),
                                                              ),
                                                              SizedBox(
                                                                width: Dimensions
                                                                    .width10,
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  cartcontroller.addItem(
                                                                      _cartList[
                                                                              index]
                                                                          .product!,
                                                                      1);
                                                                },
                                                                child: AppIcon(
                                                                  icon:
                                                                      Icons.add,
                                                                  iconColor:
                                                                      Colors
                                                                          .white,
                                                                  size: 35,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .green,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ]),
                                            ))
                                          ]),
                                        );
                                      });
                                },
                              ))),
                    )
                  : NoDataPage(text: "Your Cart is Empty");
            })
          ],
        ),
        //bottom
        bottomNavigationBar: GetBuilder<CartController>(builder: (cartProduct) {
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
                  color: Colors.transparent),
              child: cartProduct.getItems.length > 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Text(
                                "Total Amount:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(
                                height: Dimensions.height10 / 2,
                              ),
                              Container(
                                height: Dimensions.height40,
                                width: 180,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius15)),
                                child: BigText(
                                    text:
                                        "${cartProduct.totalAmount.toString()}MMK"),
                                alignment: Alignment.center,
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (Get.find<AuthController>().UserLogin()) {
                              if (Get.find<LocationController>()
                                  .addressList
                                  .isEmpty) {
                                Get.toNamed(RouteHelper.getAddAddressPage());
                              }
                              cartProduct.addTOHistory();
                            } else {
                              Get.toNamed(RouteHelper.loginPage);
                            }
                            // popularProduct.addItem(product);
                          },
                          child: Container(
                            padding: EdgeInsets.all(14),
                            height: 70,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                color: Colors.green),
                            child: BigText(text: "Check Out"),
                            alignment: Alignment.center,
                          ),
                        ),
                      ],
                    )
                  : Container());
        }));
  }
}
