import 'package:flutter/material.dart';
import '../../core/constant/app_colors.dart';

class SettingsAvatarHeader extends StatelessWidget {
  const SettingsAvatarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 104,
        height: 104,
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const CircleAvatar(
          backgroundColor: AppColors.white,
          child: Icon(Icons.person, size: 72, color: AppColors.grey),
        ),
      ),
    );
  }
}
