import 'package:food_magazine/data/api/api_client.dart';
import 'package:food_magazine/utils/app_contans.dart';
import 'package:get/get.dart';

class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;
  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async {
    return await apiClient.getData(AppContans.RECOMMENDED_PRODUCT_URI);
  }
}
