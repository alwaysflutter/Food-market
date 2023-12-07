import 'package:flutter/material.dart';
import 'package:food_magazine/controller/cart_controller.dart';
import 'package:food_magazine/controller/popular_product_controller.dart';
import 'package:food_magazine/controller/recommended_product_controller.dart';
import 'package:food_magazine/pages/home/cart/cart_page.dart';
import 'package:food_magazine/routes/route_helper.dart';
import 'package:food_magazine/utils/app_contans.dart';
import 'package:food_magazine/utils/colors.dart';
import 'package:food_magazine/utils/dimenisions.dart';
import 'package:food_magazine/widget/app_icon.dart';
import 'package:food_magazine/widget/big_text.dart';
import 'package:food_magazine/widget/exandable_text_widget.dart';
import 'package:get/get.dart';

class RecommendFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendFoodDetail(
      {super.key, required this.pageId, required this.page});

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      if (page == 'cartpage') {
                        Get.toNamed(RouteHelper.getCartPage());
                      } else {
                        Get.toNamed(RouteHelper.getInitial());
                      }
                    },
                    child: AppIcon(icon: Icons.clear)),
                // AppIcon(icon: Icons.shopping_cart_outlined)
                GetBuilder<PopularProductController>(builder: (controller) {
                  return GestureDetector(
                    onTap: () {
                      if (controller.totalItems >= 1)
                        Get.toNamed(RouteHelper.getCartPage());
                    },
                    child: Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined),
                        Get.find<PopularProductController>().totalItems >= 1
                            ? Positioned(
                                right: 0,
                                top: 0,
                                child: AppIcon(
                                  icon: Icons.circle,
                                  size: 20,
                                  iconColor: Colors.transparent,
                                  backroundColor: AppColors.mainColor,
                                ),
                              )
                            : Container(),
                        Get.find<PopularProductController>().totalItems >= 1
                            ? Positioned(
                                right: 3,
                                top: 3,
                                child: BigText(
                                  text: Get.find<PopularProductController>()
                                      .totalItems
                                      .toString(),
                                  size: 12,
                                  color: Colors.white,
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  );
                })
              ],
            ),
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Container(
                  width: double.maxFinite,
                  child: Center(
                      child: BigText(
                    text: product.name!,
                    size: Dimenisions.font26,
                  )),
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimenisions.radius20),
                          topRight: Radius.circular(Dimenisions.radius20))),
                )),
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 320,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppContans.BASE_URL + AppContans.UPLOADS_URL + product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Column(
            children: [
              Container(
                child: ExandableTextWidget(text: product.description!),
                margin: EdgeInsets.only(
                    left: Dimenisions.width20, right: Dimenisions.width20),
              )
            ],
          ))
        ],
      ),
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: Dimenisions.width20 * 2.5,
                  right: Dimenisions.width20 * 2.5,
                  top: Dimenisions.height10,
                  bottom: Dimenisions.height10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.setQuantity(false);
                    },
                    child: AppIcon(
                      iconSize: Dimenisions.iconSize24,
                      iconColor: Colors.white,
                      backroundColor: AppColors.mainColor,
                      icon: Icons.remove,
                    ),
                  ),
                  BigText(
                    text: '\$ ${product.price} X  ${controller.inCartItems}',
                    color: AppColors.mainBlackColor,
                    size: Dimenisions.font26,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.setQuantity(true);
                    },
                    child: AppIcon(
                      iconSize: Dimenisions.iconSize24,
                      iconColor: Colors.white,
                      backroundColor: AppColors.mainColor,
                      icon: Icons.add,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: Dimenisions.bottomHeightBar,
              padding: EdgeInsets.only(
                  top: Dimenisions.height30,
                  bottom: Dimenisions.height30,
                  left: Dimenisions.width20,
                  right: Dimenisions.width20),
              decoration: BoxDecoration(
                  color: AppColors.buttonBackroundColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimenisions.radius20 * 2),
                    topLeft: Radius.circular(Dimenisions.radius20 * 2),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: Dimenisions.height20,
                      bottom: Dimenisions.height20,
                      left: Dimenisions.width20,
                      right: Dimenisions.width20,
                    ),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimenisions.radius20),
                        color: Colors.white),
                    child: Icon(
                      Icons.favorite,
                      color: AppColors.mainColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        top: Dimenisions.height20,
                        bottom: Dimenisions.height20,
                        left: Dimenisions.width20,
                        right: Dimenisions.width20,
                      ),
                      child: BigText(
                        text: '\$ ${product.price!} | Add to cart',
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimenisions.radius20),
                        color: AppColors.mainColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
