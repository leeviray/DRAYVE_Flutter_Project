import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'styles/colors.dart';
import 'pages/splash_screen.dart';
import 'firebase_options.dart';

Future<
  void
>
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (
    e
  ) {
    print(
      "====== FIREBASE ERROR: $e ======",
    );
  }

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
      home: const SplashScreen(),
      builder:
          (
            context,
            child,
          ) => _DesktopUiScaler(
            child:
                child ??
                const SizedBox.shrink(),
          ),
    );
  }
}

/// Menyamakan tampilan desktop di berbagai ukuran layar / display scaling.
/// Desain acuan memakai lebar logis 1920px (monitor eksternal 100%).
/// Pada layar desktop yang lebih sempit (mis. laptop dengan Windows scaling
/// 125% -> lebar logis 1536px), seluruh UI diperkecil secara proporsional
/// (maks. sampai 80%) sehingga hasilnya sama seperti zoom browser 80%.
/// Layar tablet/mobile (< 1200px) tidak terpengaruh.
class _DesktopUiScaler
    extends
        StatelessWidget {
  const _DesktopUiScaler({required this.child});

  final Widget child;

  static const double _designWidth = 1920.0;
  static const double _desktopBreakpoint = 1200.0;
  static const double _minScale = 0.8;

  @override
  Widget build(
    BuildContext context,
  ) {
    final MediaQueryData mq = MediaQuery.of(
      context,
    );
    final double width = mq.size.width;

    double scale = 1.0;
    if (width >=
            _desktopBreakpoint &&
        width <
            _designWidth) {
      scale =
          (width /
                  _designWidth)
              .clamp(
                _minScale,
                1.0,
              );
    }

    if (scale >=
        1.0)
      return child;

    final Size scaledSize =
        mq.size /
        scale;

    return MediaQuery(
      data: mq.copyWith(
        size: scaledSize,
        padding:
            mq.padding /
            scale,
        viewPadding:
            mq.viewPadding /
            scale,
        viewInsets:
            mq.viewInsets /
            scale,
      ),
      child: ClipRect(
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: scaledSize.width,
            height: scaledSize.height,
            child: child,
          ),
        ),
      ),
    );
  }
}
