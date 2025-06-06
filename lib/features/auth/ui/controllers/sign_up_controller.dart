import 'package:assignment_ecommerce_project_final/app/app_urls.dart';
import 'package:assignment_ecommerce_project_final/core/network_caller/network_caller.dart';
import 'package:assignment_ecommerce_project_final/features/auth/data/models/sign_up_model.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  bool _signUpInProgress = false;

  bool get signUpInProgress => _signUpInProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> signUp(SignUpModel signUpModel) async {
    bool isSuccess = false;
    _signUpInProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(url: AppUrls.signUpUrl, body: signUpModel.toJson());
    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _signUpInProgress = false;
    update();
    return isSuccess;
  }
}
