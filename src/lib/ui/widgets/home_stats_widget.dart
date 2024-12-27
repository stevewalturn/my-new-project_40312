import 'package:flutter/material.dart';
import 'package:my_app_123/ui/common/app_colors.dart';
import 'package:my_app_123/ui/common/ui_helpers.dart';

class HomeStatsWidget extends StatelessWidget {
  final int counter;

  const HomeStatsWidget({
    required this.counter,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Stats',
            style: TextStyle(
              fontSize: getResponsiveMediumFontSize(context),
              fontWeight: FontWeight.bold,
              color: kcDarkGreyColor,
            ),
          ),
          verticalSpaceMedium,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatItem(
                title: 'Counter',
                value: counter.toString(),
                icon: Icons.timer,
                color: kcPrimaryColor,
              ),
              _StatItem(
                title: 'Level',
                value: (counter ~/ 10 + 1).toString(),
                icon: Icons.star,
                color: Colors.amber,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatItem({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        verticalSpaceSmall,
        Text(
          value,
          style: TextStyle(
            fontSize: getResponsiveLargeFontSize(context),
            fontWeight: FontWeight.bold,
            color: kcDarkGreyColor,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            color: kcMediumGrey,
          ),
        ),
      ],
    );
  }
}
