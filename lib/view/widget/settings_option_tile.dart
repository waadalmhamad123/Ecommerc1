import 'package:flutter/material.dart';

class SettingsOptionTile extends StatelessWidget {
  final String title;
  final Widget trailing;
  final bool isLast;

  const SettingsOptionTile({
    super.key,
    required this.title,
    required this.trailing,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isLast ? Colors.transparent : const Color(0xFFEDEDED),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                color: Color(0xFF303030),
                fontWeight: FontWeight.w400,
                fontFamily: 'Times New Roman',
              ),
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}
