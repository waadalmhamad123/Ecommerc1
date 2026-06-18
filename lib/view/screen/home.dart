import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/home_content_controller.dart';
import '../../controller/home_controller.dart';
import '../../core/constant/app_colors.dart';
import 'favorite_screen.dart';
import 'settings_screen.dart';
import '../widget/ads_banner.dart';
import '../widget/category_section.dart';
import '../widget/custom_bottom_nav.dart';
import '../widget/home_appbar.dart';
import '../widget/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final contentController = Get.put(HomeContentController());

    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.background,
        appBar: controller.currentIndex.value == 0
            ? HomeAppBar(
                onFavoriteTap: () => Get.to(() => const FavoriteScreen()),
                onSearch: contentController.updateSearch,
              )
            : null,
        body: _buildPage(controller, contentController),
        bottomNavigationBar: const CustomBottomNav(),
      ),
    );
  }

  Widget _buildPage(
    HomeController controller,
    HomeContentController contentController,
  ) {
    switch (controller.currentIndex.value) {
      case 4:
        return const SettingsScreen();
      case 1:
      case 2:
      case 3:
        return const Center(
          child: Text(
            'Coming soon',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
        );
      case 0:
      default:
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const AdsBanner(),
              const SizedBox(height: 24),
              Obx(() => CategorySection(categories: contentController.categories.toList())),
              const SizedBox(height: 24),
              const Text(
                'Product for you',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 14),
              Obx(() {
                if (contentController.isLoading.value) {
                  return const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (contentController.error.value.isNotEmpty) {
                  return SizedBox(
                    height: 200,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            contentController.error.value,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: AppColors.black),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () => contentController.fetchProducts(),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final filtered = contentController.filteredProducts;

                if (filtered.isEmpty) {
                  return const SizedBox(
                    height: 120,
                    child: Center(
                      child: Text('No products found'),
                    ),
                  );
                }

                return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    return ProductCard(product: filtered[index]);
                  },
                );
              }),
              const SizedBox(height: 20),
            ],
          ),
        );
    }
  }
}
