import 'package:flutter/material.dart';

import '../../../utils/constants/app_strings.dart';

class SignUpSection extends StatelessWidget {
  const SignUpSection({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: [
          Text(
            AppStrings.doNotHaveAnAcc,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          SizedBox(height: height * 0.01),
          Text(
            AppStrings.signUp,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
