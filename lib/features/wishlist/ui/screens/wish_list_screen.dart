// wishlist_screen.dart
import 'package:assignment_ecommerce_project_final/app/app_colors.dart';
import 'package:assignment_ecommerce_project_final/core/widgets/centered_circular_progress_indicator.dart';
import 'package:assignment_ecommerce_project_final/features/wishlist/data/models/wish_list_model.dart';
import 'package:assignment_ecommerce_project_final/features/wishlist/ui/controllers/wish_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishlistScreen extends StatelessWidget {
  static const String name = '/wishlist';

  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WishlistController controller = Get.find<WishlistController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wish List'),
      ),
      body: GetBuilder<WishlistController>(
        init: controller,
        builder: (controller) {
          if (controller.getWishlistInProgress) {
            return const CenteredCircularProgressIndicator();
          }

          if (controller.errorMessage != null) {
            return Center(child: Text(controller.errorMessage!));
          }

          if (controller.wishlistItems.isEmpty) {
            return const Center(child: Text('No items in your wishlist'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: controller.wishlistItems.length,
            itemBuilder: (context, index) {
              return _buildWishlistItem(controller.wishlistItems[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildWishlistItem(WishlistModel item) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                image: item.imageUrl.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(item.imageUrl),
                        fit: BoxFit.cover,
                      )
                    : null,
                color: AppColors.themeColor.withOpacity(0.1),
              ),
              child: item.imageUrl.isEmpty
                  ? const Center(child: Icon(Icons.image, size: 40))
                  : null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '\$${item.price}',
                      style: const TextStyle(
                        color: AppColors.themeColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    Text('${item.rating}'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
