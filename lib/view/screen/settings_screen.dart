import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/settings_controller.dart';
import '../../core/constant/app_colors.dart';
import '../widget/settings_avatar_header.dart';
import '../widget/settings_options_card.dart';
import '../widget/settings_option_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Container(
                  height: 210,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                ),
                Expanded(child: Container(color: AppColors.background)),
              ],
            ),
          ),
          Positioned.fill(
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 130),
                  const SettingsAvatarHeader(),
                  const SizedBox(height: 28),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(22, 0, 22, 22),
                        child: SettingsOptionsCard(
                          children: [
                            Obx(
                              () => SettingsOptionTile(
                                title: 'Disable Notifications',
                                trailing: Switch(
                                  value: controller.notificationsEnabled.value,
                                  onChanged: controller.toggleNotifications,
                                  activeThumbColor: AppColors.white,
                                  activeTrackColor: Colors.blue,
                                  inactiveThumbColor: AppColors.white,
                                  inactiveTrackColor: AppColors.grey,
                                ),
                              ),
                            ),
                            const SettingsOptionTile(
                              title: 'Address',
                              trailing: Icon(
                                Icons.location_on,
                                color: Color(0xFF666666),
                                size: 30,
                              ),
                            ),
                            const SettingsOptionTile(
                              title: 'About us',
                              trailing: Icon(
                                Icons.help_outline,
                                color: Color(0xFF666666),
                                size: 28,
                              ),
                            ),
                            const SettingsOptionTile(
                              title: 'Contact us',
                              trailing: Icon(
                                Icons.call_outlined,
                                color: Color(0xFF666666),
                                size: 28,
                              ),
                            ),
                            const SettingsOptionTile(
                              title: 'Logout',
                              isLast: true,
                              trailing: Icon(
                                Icons.logout_outlined,
                                color: Color(0xFF666666),
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                      ),
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
}
