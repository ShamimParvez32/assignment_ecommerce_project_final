import 'package:assignment_ecommerce_project_final/core/network_caller/network_caller.dart';
import 'package:assignment_ecommerce_project_final/features/auth/ui/controllers/auth_controller.dart';
import 'package:assignment_ecommerce_project_final/features/auth/ui/controllers/sign_in_controller.dart';
import 'package:assignment_ecommerce_project_final/features/auth/ui/controllers/sign_up_controller.dart';
import 'package:assignment_ecommerce_project_final/features/auth/ui/controllers/verify_otp_controller.dart';
import 'package:assignment_ecommerce_project_final/features/cart/ui/controllers/cart_list_controller.dart';
import 'package:assignment_ecommerce_project_final/features/common/controllers/category_controller.dart';
import 'package:assignment_ecommerce_project_final/features/common/controllers/home_slider_controller.dart';
import 'package:assignment_ecommerce_project_final/features/common/controllers/main_bottom_nav_bar_controller.dart';
import 'package:assignment_ecommerce_project_final/features/review/ui/controllers/create_review_controller.dart';
import 'package:assignment_ecommerce_project_final/features/review/ui/controllers/review_list_controller.dart';
import 'package:assignment_ecommerce_project_final/features/wishlist/ui/controllers/wish_list_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(NetworkCaller());
    Get.put(HomeSliderController());
    Get.put(CategoryController());
    Get.put(MainBottomNavBarController());
    Get.put(SignInController());
    Get.put(SignUpController());
    Get.put(VerifyOtpController());
    Get.put(CartListController());
    Get.put(ReviewListController());
    Get.put(WishlistController());
    Get.put(CreateReviewController());
  }
}
