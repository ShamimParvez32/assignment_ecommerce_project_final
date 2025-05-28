// wishlist_model.dart
class WishlistModel {
  final String id;
  final String productId;
  final String title;
  final int price;
  final double rating;
  final String imageUrl;

  WishlistModel({
    required this.id,
    required this.productId,
    required this.title,
    required this.price,
    required this.rating,
    required this.imageUrl,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) {
    return WishlistModel(
      id: json['_id'],
      productId: json['product']['_id'],
      title: json['product']['title'],
      price: json['product']['current_price'],
      rating: json['product']['rating']?.toDouble() ?? 0.0,
      imageUrl: json['product']['photos']?.isNotEmpty == true
          ? json['product']['photos'][0]
          : '',
    );
  }
}
