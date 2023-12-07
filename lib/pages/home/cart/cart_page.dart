import 'package:flutter/material.dart';
import 'package:food_magazine/base/no_data_page.dart';
import 'package:food_magazine/controller/cart_controller.dart';
import 'package:food_magazine/controller/popular_product_controller.dart';
import 'package:food_magazine/controller/recommended_product_controller.dart';
import 'package:food_magazine/pages/home/main_food_page.dart';
import 'package:food_magazine/routes/route_helper.dart';
import 'package:food_magazine/utils/app_contans.dart';
import 'package:food_magazine/utils/colors.dart';
import 'package:food_magazine/utils/dimenisions.dart';
import 'package:food_magazine/widget/app_icon.dart';
import 'package:food_magazine/widget/big_text.dart';
import 'package:food_magazine/widget/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: Dimenisions.height20 * 3,
                left: Dimenisions.width20,
                right: Dimenisions.width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppIcon(
                      icon: Icons.arrow_back_ios,
                      iconColor: Colors.white,
                      backroundColor: AppColors.mainColor,
                      iconSize: Dimenisions.iconSize24,
                    ),
                    SizedBox(
                      width: Dimenisions.width20 * 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getInitial());
                      },
                      child: AppIcon(
                        icon: Icons.home_rounded,
                        iconColor: Colors.white,
                        backroundColor: AppColors.mainColor,
                        iconSize: Dimenisions.iconSize24,
                      ),
                    ),
                    AppIcon(
                      icon: Icons.shopping_cart,
                      iconColor: Colors.white,
                      backroundColor: AppColors.mainColor,
                      iconSize: Dimenisions.iconSize24,
                    ),
                  ],
                )),
            GetBuilder<CartController>(builder: (_cartController) {
              return _cartController.getItems.length > 0
                  ? Positioned(
                      top: Dimenisions.height20 * 5,
                      left: Dimenisions.width20,
                      right: Dimenisions.width20,
                      bottom: 0,
                      child: Container(
                        margin: EdgeInsets.only(top: Dimenisions.height15),
                        // color: Colors.red,
                        child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: GetBuilder<CartController>(
                                builder: (cartController) {
                              var _cartList = cartController.getItems;
                              return ListView.builder(
                                  itemCount: _cartList.length,
                                  itemBuilder: (_, index) {
                                    return Container(
                                      width: double.maxFinite,
                                      height: Dimenisions.height20 * 5,
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              var popularIndex = Get.find<
                                                      PopularProductController>()
                                                  .popularProductList
                                                  .indexOf(_cartList[index]
                                                      .product!);
                                              if (popularIndex >= 0) {
                                                Get.toNamed(
                                                    RouteHelper.getPopularFood(
                                                        popularIndex,
                                                        'cartpage'));
                                              } else {
                                                var recommendedIndex = Get.find<
                                                        RecommendedProductController>()
                                                    .recommendedProductList
                                                    .indexOf(_cartList[index]
                                                        .product!);
                                                if (recommendedIndex < 0) {
                                                  Get.snackbar(
                                                      'History product',
                                                      "Product review is not availble for history products",
                                                      backgroundColor:
                                                          AppColors.mainColor,
                                                      colorText: Colors.white);
                                                } else {
                                                  Get.toNamed(RouteHelper
                                                      .getRecommendedFood(
                                                          recommendedIndex,
                                                          'cartpage'));
                                                }
                                              }
                                            },
                                            child: Container(
                                              width: Dimenisions.height20 * 5,
                                              height: Dimenisions.height20 * 5,
                                              margin: EdgeInsets.only(
                                                  bottom: Dimenisions.height10),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          AppContans.BASE_URL +
                                                              AppContans
                                                                  .UPLOADS_URL +
                                                              cartController
                                                                  .getItems[
                                                                      index]
                                                                  .img!)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimenisions.radius20),
                                                  color: Colors.white),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Dimenisions.width10,
                                          ),
                                          Expanded(
                                              child: Container(
                                            height: Dimenisions.height20 * 5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                BigText(
                                                  text: cartController
                                                      .getItems[index].name!,
                                                  color: Colors.black54,
                                                ),
                                                SmallText(text: 'Spicy'),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    BigText(
                                                      text: '\$ ' +
                                                          cartController
                                                              .getItems[index]
                                                              .price!
                                                              .toString(),
                                                      color: Colors.redAccent,
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                        top: Dimenisions
                                                            .height10,
                                                        bottom: Dimenisions
                                                            .height10,
                                                        left:
                                                            Dimenisions.width10,
                                                        right:
                                                            Dimenisions.width10,
                                                      ),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  Dimenisions
                                                                      .radius20),
                                                          color: Colors.white),
                                                      child: Row(children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            cartController.addItem(
                                                                _cartList[index]
                                                                    .product!,
                                                                -1);
                                                          },
                                                          child: Icon(
                                                            Icons.remove,
                                                            color: AppColors
                                                                .singColor,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: Dimenisions
                                                                  .width10 /
                                                              2,
                                                        ),
                                                        BigText(
                                                            text: _cartList[
                                                                    index]
                                                                .quantity
                                                                .toString()), //popularProduct.inCartItems.toString()),
                                                        SizedBox(
                                                          width: Dimenisions
                                                                  .width10 /
                                                              2,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            cartController.addItem(
                                                                _cartList[index]
                                                                    .product!,
                                                                1);
                                                          },
                                                          child: Icon(
                                                            Icons.add,
                                                            color: AppColors
                                                                .singColor,
                                                          ),
                                                        ),
                                                      ]),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ))
                                        ],
                                      ),
                                    );
                                  });
                            })),
                      ))
                  : NoDataPage(text: 'Your cart is empty!');
            })
          ],
        ),
        bottomNavigationBar:
            GetBuilder<CartController>(builder: (cartController) {
          return Container(
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
            child: cartController.getItems.length>0? Row(
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
                      borderRadius: BorderRadius.circular(Dimenisions.radius20),
                      color: Colors.white),
                  child: Row(children: [
                    SizedBox(
                      width: Dimenisions.width10 / 2,
                    ),
                    BigText(
                        text: '\$ ' + cartController.totalAmount.toString()),
                    SizedBox(
                      width: Dimenisions.width10 / 2,
                    ),
                  ]),
                ),
                GestureDetector(
                  onTap: () {
                    cartController.addToHistoryCart();
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                      top: Dimenisions.height20,
                      bottom: Dimenisions.height20,
                      left: Dimenisions.width20,
                      right: Dimenisions.width20,
                    ),
                    child: BigText(
                      text: 'Check out',
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimenisions.radius20),
                      color: AppColors.mainColor,
                    ),
                  ),
                )
              ],
            ):Container()
          );
        }));
  }
}
