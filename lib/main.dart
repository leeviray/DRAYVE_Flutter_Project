import 'package:flutter/material.dart';

import 'styles/colors.dart';
import 'pages/landing_page.dart';

void
main() {
  runApp(
    const DrayveApp(),
  );
}

class DrayveApp
    extends
        StatelessWidget {
  const DrayveApp({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    return MaterialApp(
      title: 'DRAYVE - F1 Drivers Hub',
      debugShowCheckedModeBanner: false, // Menghilangkan pita "debug" di pojok kanan atas
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundDark,
        useMaterial3: true,
      ),
      home: const LandingPage(), // Mengarah ke Landing Page saat web dibuka
    );
  }
}
