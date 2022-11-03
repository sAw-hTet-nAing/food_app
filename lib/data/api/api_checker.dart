import 'package:get/get.dart';
import 'package:store_app/base/show_custom_snackbar.dart';
import 'package:store_app/route/route_helper.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      Get.offNamed(RouteHelper.getLoginPage());
    } else {
      ShowCustomSnackBar(response.statusText!);
    }
  }
}
