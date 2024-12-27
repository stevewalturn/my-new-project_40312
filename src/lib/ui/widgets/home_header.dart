import 'package:flutter/material.dart';
import 'package:my_app_123/ui/common/app_colors.dart';
import 'package:my_app_123/ui/common/ui_helpers.dart';

class HomeHeader extends StatelessWidget {
  final String username;
  const HomeHeader({
    required this.username,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kcPrimaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back,',
                style: TextStyle(
                  fontSize: getResponsiveMediumFontSize(context),
                  color: kcMediumGrey,
                ),
              ),
              verticalSpaceTiny,
              Text(
                username,
                style: TextStyle(
                  fontSize: getResponsiveLargeFontSize(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          CircleAvatar(
            radius: 30,
            backgroundColor: kcPrimaryColor,
            child: Text(
              username.substring(0, 1).toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: getResponsiveMediumFontSize(context),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
