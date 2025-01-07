import 'package:flutter/material.dart';

import '../utils/constants/colors.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({
    super.key,
    this.onPressed,
    required this.icon,
    this.color = AppColors.primary,
  });
  final VoidCallback? onPressed;
  final IconData icon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: color,
      ),
    );
  }
}
