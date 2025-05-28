import 'package:assignment_ecommerce_project_final/core/widgets/show_snack_bar_message.dart';
import 'package:assignment_ecommerce_project_final/features/review/data/models/create_review_model.dart';
import 'package:assignment_ecommerce_project_final/features/review/ui/controllers/create_review_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class CreateReviewScreen extends StatefulWidget {
  final String productId;

  const CreateReviewScreen({Key? key, required this.productId})
      : super(key: key);

  static const String name = '/create-review';

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _writeReviewTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final CreateReviewController _createReviewController;
  double _rating = 0;

  @override
  void initState() {
    super.initState();
    _createReviewController = Get.find<CreateReviewController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Review'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0.5,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Rating Section
                const Text(
                  'Your Rating',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Center(
                  child: RatingBar.builder(
                    initialRating: _rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemSize: 40,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _rating = rating;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // Name Fields
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _firstNameTEController,
                        decoration: buildInputDecoration().copyWith(
                          hintText: 'First Name',
                          labelText: 'First Name',
                        ),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return 'Enter your first name';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _lastNameTEController,
                        decoration: buildInputDecoration().copyWith(
                          hintText: 'Last Name',
                          labelText: 'Last Name',
                        ),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return 'Enter your last name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Review Field
                TextFormField(
                  controller: _writeReviewTEController,
                  maxLines: 5,
                  decoration: buildInputDecoration().copyWith(
                    hintText: 'Write your review...',
                    labelText: 'Your Review',
                  ),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Please write your review';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Submit Button
                GetBuilder<CreateReviewController>(builder: (controller) {
                  return SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: controller.createReviewInProgress
                          ? null
                          : _onTapReviewSubmitButton,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: controller.createReviewInProgress
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Submit Review',
                              style: TextStyle(fontSize: 16),
                            ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapReviewSubmitButton() async {
    if (_rating < 1) {
      showSnackBarMessage(context, 'Please select a rating', true);
      return;
    }

    if (_formKey.currentState!.validate()) {
      final createReviewModel = CreateReviewModel(
        firstName: _firstNameTEController.text.trim(),
        lastName: _lastNameTEController.text.trim(),
        review: _writeReviewTEController.text.trim(),
        rating: _rating.toInt(),
        product: widget.productId,
      );

      final bool isSuccess = await _createReviewController.createReview(
        widget.productId,
        CreateReviewModel(
          firstName: _firstNameTEController.text.trim(),
          lastName: _lastNameTEController.text.trim(),
          review: _writeReviewTEController.text.trim(),
          rating: _rating.toInt(),
          product: widget.productId,
        ),
      );

      if (isSuccess) {
        showSnackBarMessage(context, 'Review submitted successfully!', false);
        // Clear form after successful submission
        _firstNameTEController.clear();
        _lastNameTEController.clear();
        _writeReviewTEController.clear();
        setState(() => _rating = 0);

        // Navigate back to product screen or review list
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pop(context);
        });
      } else {
        showSnackBarMessage(
            context,
            _createReviewController.errorMessage ?? 'Failed to submit review',
            true);
      }
    }
  }

  InputDecoration buildInputDecoration() {
    return const InputDecoration(
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _writeReviewTEController.dispose();
    super.dispose();
  }
}
