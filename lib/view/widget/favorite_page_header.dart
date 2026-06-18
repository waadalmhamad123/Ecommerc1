import 'package:flutter/material.dart';
import '../../core/constant/app_colors.dart';

class FavoritePageHeader extends StatelessWidget {
  const FavoritePageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 26),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Text(
            'Your saved items',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Favourite Products',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}