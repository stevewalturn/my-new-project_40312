import 'package:flutter/material.dart';
import 'package:my_app_123/ui/common/app_colors.dart';
import 'package:my_app_123/ui/common/ui_helpers.dart';

class TamagotchiActionButtons extends StatelessWidget {
  final VoidCallback onFeed;
  final VoidCallback onPlay;
  final VoidCallback onHeal;
  final bool isAlive;

  const TamagotchiActionButtons({
    required this.onFeed,
    required this.onPlay,
    required this.onHeal,
    required this.isAlive,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _ActionButton(
          icon: Icons.restaurant,
          label: 'Feed',
          color: Colors.orange,
          onTap: isAlive ? onFeed : null,
        ),
        _ActionButton(
          icon: Icons.sports_esports,
          label: 'Play',
          color: Colors.pink,
          onTap: isAlive ? onPlay : null,
        ),
        _ActionButton(
          icon: Icons.healing,
          label: 'Heal',
          color: Colors.green,
          onTap: isAlive ? onHeal : null,
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: onTap != null ? 1.0 : 0.5,
      child: Column(
        children: [
          MaterialButton(
            onPressed: onTap,
            color: color.withOpacity(0.1),
            padding: const EdgeInsets.all(16),
            shape: const CircleBorder(),
            child: Icon(
              icon,
              color: color,
              size: 32,
            ),
          ),
          verticalSpaceSmall,
          Text(
            label,
            style: TextStyle(
              color: kcDarkGreyColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
