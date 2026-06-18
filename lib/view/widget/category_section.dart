import 'package:flutter/material.dart';
import '../../core/constant/app_colors.dart';

class CategorySection extends StatelessWidget {
  final List<Map<String, dynamic>> categories;

  const CategorySection({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Categories',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (context, index) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final cat = categories[index];
              return Column(
                children: [
                  Container(
                    width: 68,
                    height: 68,
                    decoration: BoxDecoration(
                      color: AppColors.categoryCard,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(
                      cat['icon'] as IconData,
                      size: 32,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    cat['name'] as String,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.black,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
