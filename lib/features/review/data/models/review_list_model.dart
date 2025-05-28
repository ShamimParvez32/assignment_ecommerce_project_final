import 'package:assignment_ecommerce_project_final/features/common/data/models/product_model.dart';

class ReviewListModel {
  final String id;
  final ProductModel productModel;
  final String firstName;
  final String lastName;
  final String review;

  ReviewListModel({
    required this.id,
    required this.productModel,
    required this.firstName,
    required this.lastName,
    required this.review,
  });

  factory ReviewListModel.fromJson(Map<String, dynamic> jsonData) {
    return ReviewListModel(
      id: jsonData['_id'],
      productModel: ProductModel.fromJson(jsonData['product']),
      firstName: jsonData['firstName'],
      lastName: jsonData['lastName'],
      review: jsonData['review'],
    );
  }
}
