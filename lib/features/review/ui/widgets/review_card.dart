import 'package:assignment_ecommerce_project_final/features/review/data/models/review_list_model.dart';
import 'package:flutter/material.dart';

class reviewCard extends StatefulWidget {
  const reviewCard({
    super.key,
    required this.reviewItem,
  });

  final ReviewListModel reviewItem;
  @override
  State<reviewCard> createState() => _reviewCardState();
}

class _reviewCardState extends State<reviewCard> {
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
          CircleAvatar(
              backgroundColor: Colors.grey,
              child: const Icon(Icons.person, size: 40, color: Colors.white)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(widget.reviewItem.firstName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(width: 8),
                    Text(widget.reviewItem.lastName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 6),
                  ],
                ),
                Text(
                  widget.reviewItem.review,
                  style: const TextStyle(
                      color: Colors.grey, fontSize: 14, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
