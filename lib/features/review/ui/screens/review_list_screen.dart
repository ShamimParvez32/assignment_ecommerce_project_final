import 'package:assignment_ecommerce_project_final/core/widgets/centered_circular_progress_indicator.dart';
import 'package:assignment_ecommerce_project_final/features/review/data/models/review_list_model.dart';
import 'package:assignment_ecommerce_project_final/features/review/ui/controllers/review_list_controller.dart';
import 'package:assignment_ecommerce_project_final/features/review/ui/screens/create_review_screen.dart';
import 'package:assignment_ecommerce_project_final/features/review/ui/widgets/review_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewListScreen extends StatefulWidget {
  final String productId;

  const ReviewListScreen({Key? key, required this.productId}) : super(key: key);
  static const String name = '/review-list';

  @override
  State<ReviewListScreen> createState() => _ReviewListScreenState();
}

class _ReviewListScreenState extends State<ReviewListScreen> {
  final ReviewListController _reviewListController =
      Get.find<ReviewListController>();

  late String productId;

  @override
  void initState() {
    super.initState();
    if (widget.productId.isNotEmpty) {
      _reviewListController.getReviewList(widget.productId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0.5,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: GetBuilder<ReviewListController>(builder: (controller) {
        if (controller.getReviewListInProgress) {
          return const CenteredCircularProgressIndicator();
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 16, bottom: 80),
                itemCount: controller.reviewItemList.length,
                itemBuilder: (context, index) {
                  ReviewListModel reviewItem = controller.reviewItemList[index];
                  return reviewCard(reviewItem: reviewItem);
                },
              ),
            ),
            buildContainer(context),
          ],
        );
      }),
    );
  }

  Container buildContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFE1F4F4),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Reviews  (1000)',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, CreateReviewScreen.name,
                  arguments: productId);
            },
            child: const CircleAvatar(
              radius: 22,
              backgroundColor: Colors.teal,
              child: Icon(Icons.add, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
    );
  }
}
