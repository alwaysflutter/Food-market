import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:food_magazine/controller/popular_product_controller.dart';
import 'package:food_magazine/controller/recommended_product_controller.dart';
import 'package:food_magazine/routes/route_helper.dart';
import 'package:food_magazine/utils/colors.dart';
import 'package:food_magazine/utils/dimenisions.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  Future<void> _loaderResourse() async {
    await Get.find<PopularProductController>().getPopularList();
    await Get.find<RecommendedProductController>().getRecommendedList();
  }

  @override
  void initState() {
    super.initState();
    _loaderResourse();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);

    Timer(const Duration(seconds: 3),
        () => Get.offNamed(RouteHelper.getInitial()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
              scale: animation,
              child: Center(
                  child: Image.asset(
                'assets/images/logo.png',
                width: Dimenisions.splashImg,
              ))),
          Center(
              child: Image.asset(
            'assets/images/splash_name.jpg',
            width: Dimenisions.splashImg,
          )),
        ],
      ),
    );
  }
}
