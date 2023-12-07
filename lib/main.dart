// ignore: duplicate_ignore
// ignore_for_file: unused_import, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:food_magazine/controller/cart_controller.dart';
import 'package:food_magazine/controller/popular_product_controller.dart';
import 'package:food_magazine/controller/recommended_product_controller.dart';
import 'package:food_magazine/pages/home/cart/cart_page.dart';
import 'package:food_magazine/pages/home/food_page_body.dart';
// ignore: unused_import
import 'package:food_magazine/pages/home/food/popular_food_detail.dart';
import 'package:food_magazine/pages/home/food/recommend_food_detail.dart';
import 'package:food_magazine/pages/home/main_food_page.dart';
import 'package:food_magazine/pages/home/splash/splash_page.dart';
import 'package:food_magazine/routes/route_helper.dart';
import 'package:get/get.dart';
import 'helper/dependensies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(
      builder: (_) {
        return GetBuilder<RecommendedProductController>(builder: (_) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            // home: SplashScreen(),
            initialRoute: RouteHelper.getSplashPage(),
            getPages: RouteHelper.routes,
          );
        });
      },
    );
  }
}
