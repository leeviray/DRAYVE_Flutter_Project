import 'package:flutter/material.dart';

import 'package:drayve/styles/colors.dart';
import 'package:drayve/styles/text_styles.dart';

class LandingPage
    extends
        StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.cardDark,
        title: const Text(
          'DRAYVE',
          style: AppTextStyles.header,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Landing Page DRAYVE Siap Dirangkai!',
          style: AppTextStyles.subHeader,
        ),
      ),
    );
  }
}
