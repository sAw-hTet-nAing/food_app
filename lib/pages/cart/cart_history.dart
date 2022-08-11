import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:store_app/base/no_data_page.dart';
import 'package:store_app/controller/cart_controller.dart';
import 'package:store_app/model/cart_model.dart';
import 'package:store_app/route/route_helper.dart';
import 'package:store_app/util/app_constant.dart';
import 'package:store_app/util/dimension.dart';
import 'package:store_app/widgets/app_icon.dart';
import 'package:store_app/widgets/big_text.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemPerOrder = Map();
    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList() {
      return cartItemPerOrder.entries.map((e) {
        return e.value;
      }).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemPerOrder.entries.map((e) {
        return e.key;
      }).toList();
    }

    List<int> orderTimes = cartItemsPerOrderToList();
    var listCounter = 0;
    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();
      if (index < getCartHistoryList.length) {
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
        var outputDate = outputFormat.format(inputDate);
        return BigText(text: outputDate);
      }
      return BigText(text: outputDate);
    }

    for (int x = 0; x < cartItemPerOrder.length; x++) {
      for (int y = 0; y < orderTimes[x]; y++) {}
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.shopping_cart_checkout,
            color: Colors.black,
          ),
          onPressed: () {
            Get.toNamed(RouteHelper.getCartPage());
          },
        ),
        title: Text("Cart History",
            style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 26)),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Get.offNamed(RouteHelper.getInitial());
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
      body: Column(
        children: [
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.getCartHistoryList().length > 0
                ? Expanded(
                    child: Container(
                        margin: EdgeInsets.all(
                          Dimensions.height20,
                        ),
                        child: MediaQuery.removePadding(
                          removeTop: true,
                          context: context,
                          child: ListView(children: [
                            for (int i = 0; i < cartItemPerOrder.length; i++)
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: Dimensions.height10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    timeWidget(listCounter),
                                    // SizedBox(
                                    //   height: Dimensions.height10,
                                    // ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Wrap(
                                          direction: Axis.horizontal,
                                          children: List.generate(orderTimes[i],
                                              (index) {
                                            if (listCounter <
                                                getCartHistoryList.length) {
                                              listCounter++;
                                            }
                                            return index <= 2
                                                ? Container(
                                                    margin: EdgeInsets.only(
                                                        right:
                                                            Dimensions.width5),
                                                    height:
                                                        Dimensions.height10 * 8,
                                                    width:
                                                        Dimensions.width10 * 8,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Colors.amber[100],
                                                        borderRadius: BorderRadius
                                                            .circular(Dimensions
                                                                    .radius15 /
                                                                2),
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(AppConstant
                                                                    .BASE_URL +
                                                                AppConstant
                                                                    .UPLOAD_URL +
                                                                getCartHistoryList[
                                                                        listCounter -
                                                                            1]
                                                                    .img!))),
                                                  )
                                                : Container();
                                          }),
                                        ),
                                        Container(
                                          height: Dimensions.height10 * 12,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Total",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.green,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              BigText(
                                                text: orderTimes[i].toString() +
                                                    " Items",
                                              ),
                                              GestureDetector(
                                                onTap: (() {
                                                  var orderTime =
                                                      cartOrderTimeToList();
                                                  Map<int, CartModel>
                                                      moreOrder = {};
                                                  for (int j = 0;
                                                      j <
                                                          getCartHistoryList
                                                              .length;
                                                      j++) {
                                                    if (getCartHistoryList[j]
                                                            .time ==
                                                        orderTime[i]) {
                                                      moreOrder.putIfAbsent(
                                                          getCartHistoryList[j]
                                                              .id!,
                                                          () => CartModel.fromJson(
                                                              jsonDecode(jsonEncode(
                                                                  getCartHistoryList[
                                                                      j]))));
                                                    }
                                                  }
                                                  Get.find<CartController>()
                                                      .setItems = moreOrder;

                                                  Get.find<CartController>()
                                                      .addTocartList();

                                                  Get.toNamed(RouteHelper
                                                      .getCartPage());
                                                }),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          Dimensions.width10,
                                                      vertical:
                                                          Dimensions.height10 /
                                                              2),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(Dimensions
                                                                  .radius15 /
                                                              3),
                                                      border: Border.all(
                                                          color: Colors.green,
                                                          width: 1)),
                                                  child: Text("one more"),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                          ]),
                        )))
                : Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: Center(
                      child: NoDataPage(
                        text: "You Didn't Buy Anything Yet",
                        imgPath: "assets/image/box.png",
                      ),
                    ),
                  );
          })
        ],
      ),
    );
  }
}
