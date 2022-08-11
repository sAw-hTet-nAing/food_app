import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/controller/recommended_product_controller.dart';
import 'package:store_app/controller/popular_product_controller.dart';
import 'package:store_app/route/route_helper.dart';
import 'package:store_app/util/app_constant.dart';
import 'package:store_app/util/dimension.dart';
import 'package:store_app/widgets/app_column.dart';
import 'package:store_app/widgets/big_text.dart';
import 'package:store_app/widgets/small_text.dart';

class FoodPageBody extends StatefulWidget {
  FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PopularProductController popularProductController = Get.find();
  RecommendedProductController recommendedProductController = Get.find();
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  double _scalefacto = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GetBuilder<PopularProductController>(builder: (popularProducts) {
        return popularProducts.isloaded
            ? Container(
                height: Dimensions.pageView,
                child: PageView.builder(
                    controller: pageController,
                    itemCount: popularProducts.poppularProductList.length,
                    itemBuilder: (context, position) {
                      return _buildPageItem(position,
                          popularProducts.poppularProductList[position]);
                    }),
              )
            : CircularProgressIndicator(
                color: Colors.green,
                semanticsLabel: "Loading",
              );
      }),

      GetBuilder<PopularProductController>(builder: (popularProduct) {
        return DotsIndicator(
          //DOts
          dotsCount: popularProduct.poppularProductList.length <= 0
              ? 1
              : popularProduct.poppularProductList.length,
          position: _currentPageValue,

          decorator: DotsDecorator(
            activeColor: Colors.green,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        );
      }),
      SizedBox(
        height: Dimensions.height10,
      ),
      // Popular Text
      Row(
        children: [
          Container(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius15),
                color: Colors.black12,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(left: Dimensions.width30),
              child: BigText(
                color: Colors.green,
                text: "Recommend",
              ),
            ),
          )
        ],
      ),
      SizedBox(
        height: Dimensions.height10,
      ),
      // GetBuilder<RecommendedProductController>(
      //   builder: (recommendedproduct) {
      //     return ListView.builder(
      //         physics: NeverScrollableScrollPhysics(),
      //         shrinkWrap: true,
      //         itemCount: recommendedproduct.recommendedProductList.length,
      //         itemBuilder: (context, index) {
      //           return Container(
      //             margin: EdgeInsets.only(
      //                 left: Dimensions.width20,
      //                 right: Dimensions.width20,
      //                 bottom: Dimensions.height15),
      //             child: Row(
      //               children: [
      //                 //image
      //                 Container(
      //                     width: 120,
      //                     height: 120,
      //                     decoration: BoxDecoration(
      //                         borderRadius:
      //                             BorderRadius.circular(Dimensions.radius15),
      //                         color: Colors.white38,
      //                         image: DecorationImage(
      //                             image: NetworkImage(AppConstant.BASE_URL +
      //                                 AppConstant.UPLOAD_URL +
      //                                 recommendedproduct
      //                                     .recommendedProductList[index].img!),
      //                             fit: BoxFit.cover))),
      //                 Expanded(
      //                   child: Container(
      //                     height: 100,
      //                     decoration: BoxDecoration(
      //                         borderRadius: BorderRadius.only(
      //                             topRight:
      //                                 Radius.circular(Dimensions.radius20),
      //                             bottomRight:
      //                                 Radius.circular(Dimensions.radius20)),
      //                         color: Colors.white),
      //                     child: Padding(
      //                       padding: EdgeInsets.only(
      //                           left: Dimensions.width10,
      //                           right: Dimensions.width10),
      //                       child: Column(
      //                         crossAxisAlignment: CrossAxisAlignment.start,
      //                         mainAxisAlignment: MainAxisAlignment.center,
      //                         children: [
      //                           BigText(text: "Indian Foods"),
      //                           SizedBox(
      //                             height: Dimensions.height10,
      //                           ),
      //                           Smalltext(
      //                             text: "with Indian Characteristics",
      //                             size: Dimensions.font16,
      //                             color: Colors.green,
      //                           ),
      //                           SizedBox(
      //                             height: Dimensions.height10,
      //                           ),
      //                           Row(
      //                             mainAxisAlignment:
      //                                 MainAxisAlignment.spaceAround,
      //                             children: [
      //                               IconandTextWidget(
      //                                 color: Color(0xffccc7c5),
      //                                 icon: Icons.circle_sharp,
      //                                 text: "Normal",
      //                                 iconcolor: Colors.yellow,
      //                               ),
      //                               SizedBox(
      //                                 width: Dimensions.width10,
      //                               ),
      //                               IconandTextWidget(
      //                                 color: Color(0xffccc7c5),
      //                                 icon: Icons.location_on,
      //                                 text: "1.3km",
      //                                 iconcolor: Colors.cyanAccent,
      //                               ),
      //                               SizedBox(
      //                                 width: Dimensions.width10,
      //                               ),
      //                               IconandTextWidget(
      //                                 color: Color(0xffccc7c5),
      //                                 icon: Icons.access_time,
      //                                 text: "32min",
      //                                 iconcolor: Colors.redAccent,
      //                               )
      //                             ],
      //                           )
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 )
      //               ],
      //             ),
      //           );
      //         });
      //   },
      // ),

      //product scroll
      //recommended foods

      GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
        return recommendedProduct.isloaded
            ? SingleChildScrollView(
                physics: ScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                        left: Dimensions.width10, right: Dimensions.width10),
                    shrinkWrap: true,
                    itemCount: recommendedProduct.recommendedProductList.length,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(
                              RouteHelper.getRecommendedFood(index, "home"));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: Dimensions.width10,
                              right: Dimensions.width10),
                          child: Column(
                            children: [
                              //image
                              Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(
                                              Dimensions.radius15),
                                          topRight: Radius.circular(
                                              Dimensions.radius15)),
                                      image: DecorationImage(
                                          image: NetworkImage(AppConstant
                                                  .BASE_URL +
                                              AppConstant.UPLOAD_URL +
                                              recommendedProduct
                                                  .recommendedProductList[index]
                                                  .img!),
                                          fit: BoxFit.cover),
                                      color: Colors.white10)),

                              Container(
                                height: 70,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(
                                            Dimensions.radius15),
                                        bottomRight: Radius.circular(
                                            Dimensions.radius15)),
                                    color: Colors.white),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: Dimensions.width5,
                                          right: Dimensions.width5),
                                      child: BigText(
                                        text: recommendedProduct
                                            .recommendedProductList[index]
                                            .name!,
                                        size: Dimensions.font18,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimensions.width5,
                                    ),
                                    Smalltext(
                                      text: "Wiht chese",
                                      color: Colors.green,
                                      size: Dimensions.font12,
                                    ),
                                    SizedBox(
                                      height: Dimensions.width5,
                                    ),
                                    Container(
                                      child: Text(
                                        "${recommendedProduct.recommendedProductList[index].price!} MMK",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            : CircularProgressIndicator(
                color: Colors.green,
              );
      })
    ]);
  }

  Widget _buildPageItem(int index, poppularProduct) {
    Matrix4 matrix = new Matrix4.identity(); //Transform
    if (index == _currentPageValue.floor()) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scalefacto);

      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currScale =
          _scalefacto + (_currentPageValue - index + 1) * (1 - _scalefacto);

      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scalefacto);

      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scalefacto) / 2, 1);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index, "home"));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width5, right: Dimensions.width5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: index.isEven
                      ? Color(0xFF69dc5df)
                      : Color.fromARGB(255, 146, 204, 182),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(AppConstant.BASE_URL +
                          AppConstant.UPLOAD_URL +
                          poppularProduct.img!))),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: Dimensions.pageViewTextContainer,
                margin: EdgeInsets.only(
                    left: Dimensions.width30,
                    right: Dimensions.width30,
                    bottom: Dimensions.height30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFFe8e8e8),
                          blurRadius: 5.0,
                          offset: Offset(0, 5)),
                      BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                      BoxShadow(color: Colors.white, offset: Offset(5, 0))
                    ]),
                child: Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height10,
                        left: Dimensions.width10,
                        right: Dimensions.width10),
                    child: AppColumn(
                      text: poppularProduct.name!,
                    ))),
          )
        ],
      ),
    );
  }
}
