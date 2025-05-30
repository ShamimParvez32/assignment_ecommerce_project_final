class AppUrls {
  static const String _baseUrl = 'https://ecom-rs8e.onrender.com/api';

  static const String signUpUrl = '$_baseUrl/auth/signUp';
  static const String verifyOtpUrl = '$_baseUrl/auth/verify-otp';
  static const String signInUrl = '$_baseUrl/auth/login';
  static const String slidersUrl = '$_baseUrl/slides';
  static const String categoryListUrl = '$_baseUrl/categories';
  static const String productListUrl = '$_baseUrl/products';
  static const String cartListUrl = '$_baseUrl/cart';
  static const String reviewListUrl = '$_baseUrl/review';
  static const String createReviewUrl = '$_baseUrl/review';
  static String deleteFromCartListUrl(String id) => '$_baseUrl/cart/$id';

  static String productDetailsUrl(String productId) =>
      '$_baseUrl/products/id/$productId';

  static const String addToCartUrl = '$_baseUrl/cart';
  static const String wishlistUrl = '$_baseUrl/wishlist';
  static String deleteFromWishlistUrl(String id) => '$_baseUrl/wishlist/$id';
}
