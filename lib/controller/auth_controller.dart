import 'package:get/get.dart';
import 'package:store_app/data/repository/auth_repo.dart';
import 'package:store_app/model/response_model.dart';
import 'package:store_app/model/signup_body_model.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  bool _isloading = false;
  bool get isloading => _isloading;

  Future<ResponseModel> registration(SignupBody signupBody) async {
    _isloading = true;
    update();
    Response response = await authRepo.registration(signupBody);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isloading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String phone, String password) async {
    authRepo.getUserToken();
    _isloading = true;
    update();
    Response response = await authRepo.login(phone, password);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isloading = false;
    update();
    return responseModel;
  }

  Future<void> saveUserNumberAndPassword(String phone, String password) async {
    authRepo.saveUserNumberAndPassword(phone, password);
  }

  bool UserLogin() {
    return authRepo.UserLogin();
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }
}
