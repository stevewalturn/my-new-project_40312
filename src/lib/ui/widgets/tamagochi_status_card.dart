import 'package:flutter/material.dart';
import 'package:my_app_123/models/tamagochi.dart';
import 'package:my_app_123/ui/common/app_colors.dart';
import 'package:my_app_123/ui/common/ui_helpers.dart';

class TamagotchiStatusCard extends StatelessWidget {
  final Tamagotchi tamagotchi;

  const TamagotchiStatusCard({
    required this.tamagotchi,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tamagotchi.name,
                style: TextStyle(
                  fontSize: getResponsiveLargeFontSize(context),
                  fontWeight: FontWeight.bold,
                  color: kcPrimaryColor,
                ),
              ),
              Icon(
                tamagotchi.isAlive ? Icons.favorite : Icons.heart_broken,
                color: tamagotchi.isAlive ? Colors.red : Colors.grey,
              ),
            ],
          ),
          verticalSpaceMedium,
          _StatusBar(
            label: 'Hunger',
            value: tamagotchi.hunger,
            color: Colors.orange,
          ),
          verticalSpaceSmall,
          _StatusBar(
            label: 'Happiness',
            value: tamagotchi.happiness,
            color: Colors.pink,
          ),
          verticalSpaceSmall,
          _StatusBar(
            label: 'Health',
            value: tamagotchi.health,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}

class _StatusBar extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const _StatusBar({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: $value%',
          style: const TextStyle(
            color: kcMediumGrey,
            fontSize: 14,
          ),
        ),
        verticalSpaceTiny,
        LinearProgressIndicator(
          value: value / 100,
          backgroundColor: color.withOpacity(0.2),
          valueColor: AlwaysStoppedAnimation<Color>(color),
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}
