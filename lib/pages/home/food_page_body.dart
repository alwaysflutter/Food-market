// ignore_for_file: unused_import

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_magazine/controller/popular_product_controller.dart';
import 'package:food_magazine/controller/recommended_product_controller.dart';
import 'package:food_magazine/model/product_model.dart';
import 'package:food_magazine/pages/home/food/popular_food_detail.dart';
import 'package:food_magazine/pages/home/food/recommend_food_detail.dart';
import 'package:food_magazine/routes/route_helper.dart';
import 'package:food_magazine/utils/app_contans.dart';
import 'package:food_magazine/utils/colors.dart';
import 'package:food_magazine/utils/dimenisions.dart';
import 'package:food_magazine/widget/app_column.dart';
import 'package:food_magazine/widget/big_text.dart';
import 'package:food_magazine/widget/icon_and_text_widget.dart';
import 'package:food_magazine/widget/small_text.dart';
import 'dart:ffi' as ffi;
import 'dart:ui' as ui;

// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = 220;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispoce() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // slider section
        GetBuilder<PopularProductController>(
          builder: (popularProducts) {
            return popularProducts.isLoaded
                ? Container(
                    // color: Colors.redAccent,
                    height: Dimenisions.pageView,
                    child: PageView.builder(
                        controller: pageController,
                        itemCount: popularProducts.popularProductList.length,
                        itemBuilder: (context, position) {
                          return _buildPageItem(position,
                              popularProducts.popularProductList[position]);
                        }),
                  )
                : CircularProgressIndicator(
                    color: AppColors.mainColor,
                  );
          },
        ),
        // dots
        GetBuilder<PopularProductController>(
          builder: (popularProducts) {
            return DotsIndicator(
              dotsCount: popularProducts.popularProductList.isEmpty
                  ? 1
                  : popularProducts.popularProductList.length,
              position: _currPageValue,
              decorator: DotsDecorator(
                activeColor: AppColors.mainColor,
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            );
          },
        ),
        // Popular text
        SizedBox(
          height: Dimenisions.height30,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimenisions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: 'Recommended'),
              SizedBox(
                width: Dimenisions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: '.',
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimenisions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: 'Food pairing'),
              ),
            ],
          ),
        ),
        // list of food and images
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
          return recommendedProduct.isLoaded
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recommendedProduct.recommendedProductList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(
                            RouteHelper.getRecommendedFood(index, 'home'));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimenisions.width20,
                            right: Dimenisions.width20,
                            bottom: Dimenisions.height10),
                        child: Row(
                          children: [
                            // image section
                            Container(
                              width: Dimenisions.listViewImgSize,
                              height: Dimenisions.listViewImgSize,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimenisions.radius20),
                                  color: Colors.white38,
                                  image: DecorationImage(
                                      image: NetworkImage(AppContans.BASE_URL +
                                          AppContans.UPLOADS_URL +
                                          recommendedProduct
                                              .recommendedProductList[index]
                                              .img!),
                                      fit: BoxFit.cover)),
                            ),
                            // text container
                            Expanded(
                              child: Container(
                                height: Dimenisions.listViewTextContSize,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight:
                                        Radius.circular(Dimenisions.radius20),
                                    bottomRight:
                                        Radius.circular(Dimenisions.radius20),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: Dimenisions.width10,
                                      right: Dimenisions.width10),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        BigText(
                                            text: recommendedProduct
                                                .recommendedProductList[index]
                                                .name!),
                                        SizedBox(
                                          height: Dimenisions.height10,
                                        ),
                                        SmallText(
                                            text:
                                                'With Chinese characteristics'),
                                        SizedBox(
                                          height: Dimenisions.height10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconAndTextWidget(
                                                icon: Icons.circle_sharp,
                                                text: 'Normal',
                                                iconColor:
                                                    AppColors.iconColor1),
                                            IconAndTextWidget(
                                                icon: Icons.location_on,
                                                text: '1.7km',
                                                iconColor: AppColors.mainColor),
                                            IconAndTextWidget(
                                                icon: Icons.access_time_rounded,
                                                text: '32min',
                                                iconColor: AppColors.iconColor2)
                                          ],
                                        )
                                      ]),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        })
      ],
    );
  }

  Widget _buildPageItem(
    int index,
    popularProduct,
  ) {
    Matrix4 matrix = new Matrix4.identity();

    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 0);
    }

    return Transform(
      transform: matrix,
      child: Stack(children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(RouteHelper.getPopularFood(index, 'home'));
          },
          child: Container(
            height: Dimenisions.pageViewContainer,
            margin: EdgeInsets.only(
                right: Dimenisions.width10, left: Dimenisions.width10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimenisions.radius30),
              color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
              image: DecorationImage(
                  image: NetworkImage(AppContans.BASE_URL +
                      AppContans.UPLOADS_URL +
                      popularProduct.img!),
                  fit: BoxFit.cover),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: Dimenisions.pageViewTextContainer,
            margin: EdgeInsets.only(
                right: Dimenisions.width30,
                left: Dimenisions.width30,
                bottom: Dimenisions.height30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimenisions.radius20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    offset: Offset(-3, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5, 0),
                  )
                ]),
            child: Container(
              padding: EdgeInsets.only(
                  top: Dimenisions.height15, left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(text: popularProduct.name!),
                  SizedBox(
                    height: Dimenisions.height10,
                  ),
                  Row(
                    children: [
                      Wrap(
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.star,
                            color: AppColors.mainColor,
                            size: 15,
                          );
                        }),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SmallText(
                        text: '4.5',
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SmallText(
                        text: '1287',
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SmallText(
                        text: 'comments',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dimenisions.height20,
                  ),
                  // time and distance
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconAndTextWidget(
                          icon: Icons.circle_sharp,
                          text: 'Normal',
                          iconColor: AppColors.iconColor1),
                      IconAndTextWidget(
                          icon: Icons.location_on,
                          text: '1.7km',
                          iconColor: AppColors.mainColor),
                      IconAndTextWidget(
                          icon: Icons.access_time_rounded,
                          text: '32min',
                          iconColor: AppColors.iconColor2)
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
