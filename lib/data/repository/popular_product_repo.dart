import 'package:get/get.dart';
import 'package:store_app/data/api/api_client.dart';
import 'package:store_app/util/app_constant.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});
  Future<Response> getPopularProductList() async {
    return await apiClient.getData(AppConstant.POPULAR_PRODUCT_URI);
  }
}
