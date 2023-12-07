
import 'package:food_magazine/data/api/api_client.dart';
import 'package:food_magazine/utils/app_contans.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    return await apiClient.getData(AppContans.POPULAR_PRODUCT_URI);
  }
}
