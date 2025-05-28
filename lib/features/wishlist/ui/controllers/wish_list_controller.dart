// wishlist_controller.dart
import 'package:assignment_ecommerce_project_final/app/app_urls.dart';
import 'package:assignment_ecommerce_project_final/core/network_caller/network_caller.dart';
import 'package:assignment_ecommerce_project_final/features/wishlist/data/models/wish_list_model.dart';
import 'package:get/get.dart';

class WishlistController extends GetxController {
  final NetworkCaller _networkCaller = Get.find<NetworkCaller>();

  bool _getWishlistInProgress = false;
  bool get getWishlistInProgress => _getWishlistInProgress;

  List<WishlistModel> _wishlistItems = [];
  List<WishlistModel> get wishlistItems => _wishlistItems;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> getWishlist() async {
    _getWishlistInProgress = true;
    update();

    final response = await _networkCaller.getRequest(url: AppUrls.wishlistUrl);
    _getWishlistInProgress = false;

    if (response.isSuccess) {
      _wishlistItems = [];
      for (var item in response.responseData!['data']) {
        _wishlistItems.add(WishlistModel.fromJson(item));
      }
      _errorMessage = null;
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }

  Future<bool> addToWishlist(String productId) async {
    final response = await _networkCaller.postRequest(
      url: AppUrls.wishlistUrl,
      body: {'product': productId},
    );

    if (response.isSuccess) {
      // Refresh wishlist after adding
      getWishlist();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> removeFromWishlist(String wishlistItemId) async {
    final response = await _networkCaller.deleteRequest(
      url: AppUrls.deleteFromWishlistUrl(wishlistItemId),
    );

    if (response.isSuccess) {
      // Refresh wishlist after removal
      getWishlist();
      return true;
    } else {
      return false;
    }
  }
}
