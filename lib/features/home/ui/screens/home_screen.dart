import 'package:assignment_ecommerce_project_final/app/assets_path.dart';
import 'package:assignment_ecommerce_project_final/core/extensions/localization_extension.dart';
import 'package:assignment_ecommerce_project_final/core/widgets/centered_circular_progress_indicator.dart';
import 'package:assignment_ecommerce_project_final/features/common/controllers/category_controller.dart';
import 'package:assignment_ecommerce_project_final/features/common/controllers/main_bottom_nav_bar_controller.dart';
import 'package:assignment_ecommerce_project_final/features/common/data/models/category_model.dart';
import 'package:assignment_ecommerce_project_final/features/common/ui/widgets/category_item.dart';
import 'package:assignment_ecommerce_project_final/features/home/ui/widgets/app_bar_action_button.dart';
import 'package:assignment_ecommerce_project_final/features/home/ui/widgets/home_carousel_slider.dart';
import 'package:assignment_ecommerce_project_final/features/home/ui/widgets/product_card_1.dart';
import 'package:assignment_ecommerce_project_final/features/home/ui/widgets/section_header.dart';
import 'package:assignment_ecommerce_project_final/features/products/ui/controllers/product_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildSearchTextField(),
              const SizedBox(height: 16),
              const HomeCarouselSlider(),
              const SizedBox(height: 16),
              SectionHeader(
                title: context.localization.categories,
                onTapSeeAll: () {
                  Get.find<MainBottomNavBarController>().moveToCategory();
                },
              ),
              const SizedBox(height: 16),
              _buildCategoriesSection(),
              const SizedBox(height: 16),
              SectionHeader(
                title: context.localization.popular,
                onTapSeeAll: () {
                  Get.find<ProductListController>();
                },
              ),
              _buildProductSection(),
              const SizedBox(height: 16),
              _buildProductSection(),
              const SizedBox(height: 16),
              SectionHeader(
                title: context.localization.special,
                onTapSeeAll: () {},
              ),
              const SizedBox(height: 16),
              _buildProductSection(),
              const SizedBox(height: 16),
              SectionHeader(
                title: context.localization.sNew,
                onTapSeeAll: () {},
              ),
              const SizedBox(height: 16),
              _buildCategoriesSection()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductSection() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ProductCard1(),
            ProductCard1(),
            ProductCard1(),
          ],
        ));
  }

  Widget _buildCategoriesSection() {
    return GetBuilder<CategoryController>(
      builder: (controller) {
        if (controller.isInitialLoading) {
          return const SizedBox(
            height: 100,
            child: CenteredCircularProgressIndicator(),
          );
        }

        List<CategoryModel> list = controller.categoryList.length > 10
            ? controller.categoryList.sublist(0, 10)
            : controller.categoryList;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: list.map((e) {
              return CategoryItem(categoryModel: e);
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildSearchTextField() {
    return TextField(
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        fillColor: Colors.grey.shade200,
        filled: true,
        hintText: 'Search',
        prefixIcon: const Icon(Icons.search),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: SvgPicture.asset(AssetsPath.logoNavSvg),
      actions: [
        AppBarActionButton(
          icon: Icons.person_outline,
          onTap: () {},
        ),
        const SizedBox(width: 8),
        AppBarActionButton(
          icon: Icons.call,
          onTap: () {},
        ),
        const SizedBox(width: 8),
        AppBarActionButton(
          icon: Icons.notifications_active_outlined,
          onTap: () {},
        ),
      ],
    );
  }
}
