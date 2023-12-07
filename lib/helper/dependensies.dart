import 'package:food_magazine/controller/cart_controller.dart';
import 'package:food_magazine/controller/popular_product_controller.dart';
import 'package:food_magazine/controller/recommended_product_controller.dart';
import 'package:food_magazine/data/api/api_client.dart';
import 'package:food_magazine/data/repository/cart_repo.dart';
import 'package:food_magazine/data/repository/popular_product_repo.dart';
import 'package:food_magazine/data/repository/recommended_product_repo.dart';
import 'package:food_magazine/utils/app_contans.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  // api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppContans.BASE_URL));

  // repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  // controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
