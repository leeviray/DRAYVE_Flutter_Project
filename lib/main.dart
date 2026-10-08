import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'styles/colors.dart';
import 'pages/landing_page.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundDark,
        useMaterial3: true,
      ),
      home: const LandingPage(),
    );
  }
}
