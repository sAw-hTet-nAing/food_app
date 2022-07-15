import 'package:get/get.dart';
import 'package:store_app/data/api/api_client.dart';
import 'package:store_app/util/app_constant.dart';

class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;
  RecommendedProductRepo({required this.apiClient});
  Future<Response> getRecommendedProductList() async {
    return await apiClient.getData(AppConstant.RECOMMENDED_PRODUCT_URI);
  }
}
