import 'package:flutter/material.dart';

import 'colors.dart';

class AppTextStyles {
  static const TextStyle header = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textWhite,
  );

  static const TextStyle subHeader = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textWhite,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textGrey,
  );
}
