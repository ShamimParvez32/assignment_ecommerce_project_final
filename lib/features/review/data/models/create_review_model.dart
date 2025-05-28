class CreateReviewModel {
  final String firstName;
  final String lastName;
  final String review;
  final int rating;
  final String product; // Product ID

  CreateReviewModel({
    required this.firstName,
    required this.lastName,
    required this.review,
    required this.rating,
    required this.product,
  });

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "review": review,
      "rating": rating,
      "product": product,
    };
  }
}
