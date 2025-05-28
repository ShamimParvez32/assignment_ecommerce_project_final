class ReviewListModel {
  final String id;
  final ReviewProductModel productModel; // CHANGED: Use different model
  final String firstName;
  final String lastName;
  final String review;
  final int rating; // ADDED: Rating field

  ReviewListModel({
    required this.id,
    required this.productModel,
    required this.firstName,
    required this.lastName,
    required this.review,
    required this.rating, // ADDED
  });

  factory ReviewListModel.fromJson(Map<String, dynamic> jsonData) {
    return ReviewListModel(
      id: jsonData['_id'],
      productModel: ReviewProductModel.fromJson(jsonData['product']),
      firstName: jsonData['firstName'] ?? jsonData['user']['first_name'] ?? '',
      lastName: jsonData['lastName'] ?? jsonData['user']['last_name'] ?? '',
      review: jsonData['review'] ?? jsonData['comment'] ?? '',
      rating: jsonData['rating']?.toInt() ?? 0, // ADDED
    );
  }
}

class ReviewProductModel {
  final String id;
  final String title;
  final List<String> photos;

  ReviewProductModel({
    required this.id,
    required this.title,
    required this.photos,
  });

  factory ReviewProductModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> photoList = json['photos'] ?? [];
    return ReviewProductModel(
      id: json['_id'],
      title: json['title'] ?? 'No Title',
      photos: List<String>.from(photoList),
    );
  }
}
