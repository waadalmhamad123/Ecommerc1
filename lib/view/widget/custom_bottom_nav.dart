import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/home_controller.dart';
import '../../core/constant/app_colors.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 62,
          child: Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.home_rounded,
                  index: 0,
                  currentIndex: controller.currentIndex.value,
                  onTap: controller.changeIndex,
                ),
                _NavItem(
                  icon: Icons.notifications_outlined,
                  index: 1,
                  currentIndex: controller.currentIndex.value,
                  onTap: controller.changeIndex,
                ),
                GestureDetector(
                  onTap: () => controller.changeIndex(2),
                  child: Container(
                    width: 54,
                    height: 54,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.shopping_basket_outlined,
                      color: AppColors.white,
                      size: 26,
                    ),
                  ),
                ),
                _NavItem(
                  icon: Icons.person_outline_rounded,
                  index: 3,
                  currentIndex: controller.currentIndex.value,
                  onTap: controller.changeIndex,
                ),
                _NavItem(
                  icon: Icons.settings_outlined,
                  index: 4,
                  currentIndex: controller.currentIndex.value,
                  onTap: controller.changeIndex,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final int index;
  final int currentIndex;
  final void Function(int) onTap;

  const _NavItem({
    required this.icon,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Icon(
          icon,
          size: 26,
          color: isSelected ? AppColors.primary : AppColors.grey,
        ),
      ),
    );
  }
}
