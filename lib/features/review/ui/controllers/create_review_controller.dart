import 'package:assignment_ecommerce_project_final/app/app_urls.dart';
import 'package:assignment_ecommerce_project_final/core/network_caller/network_caller.dart';
import 'package:assignment_ecommerce_project_final/features/review/data/models/create_review_model.dart';
import 'package:get/get.dart';

class CreateReviewController extends GetxController {
  bool _createReviewInProgress = false;
  bool get createReviewInProgress => _createReviewInProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> createReview(
      String productId, CreateReviewModel createReviewModel) async {
    _createReviewInProgress = true;
    update();

    try {
      final NetworkResponse response =
          await Get.find<NetworkCaller>().postRequest(
        url: AppUrls.createReviewUrl,
        body: {...createReviewModel.toJson(), 'product': productId},
      );

      _createReviewInProgress = false;

      if (response.isSuccess) {
        _errorMessage = null;
        update();
        return true;
      } else {
        // Parse API error message
        final errorMsg = response.responseData?['msg'] ??
            response.errorMessage ??
            'Failed to create review';
        _errorMessage = errorMsg;
        update();
        return false;
      }
    } catch (e) {
      _createReviewInProgress = false;
      _errorMessage = 'Network error: ${e.toString()}';
      update();
      return false;
    }
  }
}
