import 'package:flutter/material.dart';
import 'package:my_app_123/ui/common/app_colors.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome to',
          style: TextStyle(
            fontSize: 24,
            color: kcMediumGrey.withOpacity(0.8),
          ),
        ),
        const Text(
          'Stacked Architecture',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w900,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}
