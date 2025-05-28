import 'package:assignment_ecommerce_project_final/app/app_urls.dart';
import 'package:assignment_ecommerce_project_final/core/network_caller/network_caller.dart';
import 'package:assignment_ecommerce_project_final/features/review/data/models/review_list_model.dart';
import 'package:get/get.dart';

class ReviewListController extends GetxController {
  bool _getReviewListInProgress = false;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  List<ReviewListModel> _reviewItemList = [];

  List<ReviewListModel> get reviewItemList => _reviewItemList;

  bool get getReviewListInProgress => _getReviewListInProgress;

  Future<bool> getReviewList(String productId) async {
    bool isSuccess = false;
    _getReviewListInProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: AppUrls.reviewListUrl,
      queryParams: {'product': productId},
    );

    if (response.isSuccess) {
      List<ReviewListModel> list = [];
      final results =
          response.responseData!['data']['results'] as List<dynamic>?;
      if (results != null) {
        for (Map<String, dynamic> json in results) {
          list.add(ReviewListModel.fromJson(json));
        }
      }
      _reviewItemList = list;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _getReviewListInProgress = false;
    update();
    return isSuccess;
  }
}
