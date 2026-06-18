import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/favorite_controller.dart';
import '../../core/constant/app_colors.dart';
import '../widget/favorite_page_header.dart';
import '../widget/favorite_product_tile.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoriteController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.white),
        title: const Text(
          'Favourite',
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          const FavoritePageHeader(),
          Expanded(
            child: Obx(
              () => controller.favoriteProducts.isEmpty
                  ? const Center(
                      child: Text(
                        'No favourite items yet',
                        style: TextStyle(fontSize: 16, color: AppColors.grey),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: controller.favoriteProducts.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 14),
                      itemBuilder: (context, index) {
                        final product = controller.favoriteProducts[index];
                        return FavoriteProductTile(product: product);
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
