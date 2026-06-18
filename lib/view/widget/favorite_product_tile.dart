import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constant/app_colors.dart';
import '../../controller/favorite_controller.dart';
import '../../models/product.dart';

class FavoriteProductTile extends StatelessWidget {
  final Product product;

  const FavoriteProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final favCtrl = Get.put(FavoriteController());
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: _buildImage(product.image),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => favCtrl.remove(product),
                        child: const Icon(
                          Icons.delete_outline,
                          color: AppColors.primary,
                          size: 26,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    product.price,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDark,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(dynamic image) {
    if (image == null) return const SizedBox();
    final imgStr = image is String ? image : image.toString();
    if (imgStr.startsWith('http')) {
      return Image.network(imgStr, fit: BoxFit.cover);
    }
    return Image.asset(imgStr, fit: BoxFit.cover);
  }
}