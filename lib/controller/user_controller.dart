import 'package:get/get.dart';
import 'package:store_app/data/repository/user_repo.dart';
import 'package:store_app/model/response_model.dart';
import 'package:store_app/model/user_model.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  UserController({required this.userRepo});
  late UserModel _userModel;
  bool _isloading = false;
  bool get isloading => _isloading;

  UserModel get userModel => _userModel;
  Future<ResponseModel> getUserInfo() async {
    late ResponseModel _responseModel;
    Response response = await userRepo.getUserInfo();

    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);

      _responseModel = ResponseModel(true, "successful");
      _isloading = true;
    } else {
      _responseModel = ResponseModel(true, response.statusText!);
    }
    _isloading = false;
    update();
    return _responseModel;
  }
}
