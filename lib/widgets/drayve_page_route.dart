import 'package:flutter/material.dart';

/// Transisi halaman khas DRAYVE: fade + zoom halus.
///
/// Dipakai saat membuka detail pembalap, login, dan profil supaya
/// perpindahan halaman terasa mulus (tidak "kaku" seperti slide default).
class DrayvePageRoute<T> extends PageRouteBuilder<T> {
  DrayvePageRoute({required WidgetBuilder builder})
      : super(
          transitionDuration: const Duration(milliseconds: 520),
          reverseTransitionDuration: const Duration(milliseconds: 380),
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curved = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
              reverseCurve: Curves.easeInCubic,
            );
            return FadeTransition(
              opacity: curved,
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.94, end: 1.0).animate(curved),
                child: child,
              ),
            );
          },
        );
}
