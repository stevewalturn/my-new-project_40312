import 'package:flutter/material.dart';
import 'package:my_app_123/ui/common/app_colors.dart';
import 'package:my_app_123/ui/common/ui_helpers.dart';

class HomeActionButtons extends StatelessWidget {
  final VoidCallback onShowDialog;
  final VoidCallback onShowBottomSheet;

  const HomeActionButtons({
    required this.onShowDialog,
    required this.onShowBottomSheet,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ActionButton(
            icon: Icons.info_outline,
            title: 'Show Info',
            color: kcPrimaryColor,
            onTap: onShowDialog,
          ),
        ),
        horizontalSpaceMedium,
        Expanded(
          child: _ActionButton(
            icon: Icons.arrow_upward,
            title: 'Show Sheet',
            color: kcDarkGreyColor,
            onTap: onShowBottomSheet,
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Icon(icon, color: color, size: 30),
              verticalSpaceSmall,
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
