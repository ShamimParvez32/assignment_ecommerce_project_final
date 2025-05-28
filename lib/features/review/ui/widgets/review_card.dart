import 'package:assignment_ecommerce_project_final/features/review/data/models/review_list_model.dart';
import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.reviewItem,
  });

  final ReviewListModel reviewItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, size: 40, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // User name with null safety
                    Text(
                      '${reviewItem.firstName} ${reviewItem.lastName}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),

                    // Rating with null safety
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          reviewItem.rating?.toString() ?? '0.0',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Review text with null safety
                Text(
                  reviewItem.review ?? 'No review text',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),

                // Product name with null safety
                if (reviewItem.productModel?.title != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'For: ${reviewItem.productModel!.title}',
                      style: const TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: Colors.blueGrey),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
