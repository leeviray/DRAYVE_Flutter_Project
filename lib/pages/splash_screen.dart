import 'dart:ui';

import 'package:flutter/material.dart';

import 'landing_page.dart'; // Pastikan nama file/class LandingPage sesuai dengan proyekmu

class SplashScreen
    extends
        StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<
    SplashScreen
  >
  createState() => _SplashScreenState();
}

class _SplashScreenState
    extends
        State<
          SplashScreen
        >
    with
        SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<
    double
  >
  _strokeAnim;
  late final Animation<
    double
  >
  _fillAnim;
  late final Animation<
    double
  >
  _strokeFadeOut;
  late final Animation<
    double
  >
  _scaleAnim;
  late final Animation<
    double
  >
  _textOpacity;
  late final Animation<
    Offset
  >
  _textSlide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 3400,
      ),
    );

    // 1. Fase melukis garis luar dengan akselerasi halus
    _strokeAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.05,
        0.58,
        curve: Curves.easeInOutCubic,
      ),
    );

    // 2. Fase munculnya warna merah solid F1
    _fillAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.48,
        0.76,
        curve: Curves.easeOutCubic,
      ),
    );

    // 3. Garis putih memudar hilang saat warna merah penuh (biar tidak kaku)
    _strokeFadeOut = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.55,
        0.80,
        curve: Curves.easeOut,
      ),
    );

    // 4. Efek bernapas/zoom halus pada logo
    _scaleAnim =
        Tween<
              double
            >(
              begin: 0.92,
              end: 1.0,
            )
            .animate(
              CurvedAnimation(
                parent: _controller,
                curve: const Interval(
                  0.0,
                  0.85,
                  curve: Curves.easeOutBack,
                ),
              ),
            );

    // 5. Kemunculan teks DRAYVE dari bawah
    _textOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.62,
        0.92,
        curve: Curves.easeOut,
      ),
    );

    _textSlide =
        Tween<
              Offset
            >(
              begin: const Offset(
                0,
                0.45,
              ),
              end: Offset.zero,
            )
            .animate(
              CurvedAnimation(
                parent: _controller,
                curve: const Interval(
                  0.62,
                  0.92,
                  curve: Curves.easeOutCubic,
                ),
              ),
            );

    _controller.forward().then((
      _,
    ) async {
      await Future.delayed(
        const Duration(
          milliseconds: 450,
        ),
      );
      if (!mounted) return;
      Navigator.of(
        context,
      ).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(
            milliseconds: 700,
          ),
          pageBuilder:
              (
                _,
                animation,
                __,
              ) => FadeTransition(
                opacity: animation,
                child: const LandingPage(),
              ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: const Color(
        0xFF0B0B0E,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Grid Vertikal Halus
          CustomPaint(
            painter: _GridBackgroundPainter(),
          ),

          // Konten Utama Logo & Teks
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder:
                  (
                    context,
                    _,
                  ) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Transform.scale(
                          scale: _scaleAnim.value,
                          child: SizedBox(
                            width: 300,
                            height: 110,
                            child: CustomPaint(
                              painter: _DrayveLogoPainter(
                                strokeProgress: _strokeAnim.value,
                                fillProgress: _fillAnim.value,
                                strokeFade:
                                    1.0 -
                                    _strokeFadeOut.value,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        SlideTransition(
                          position: _textSlide,
                          child: Opacity(
                            opacity: _textOpacity.value,
                            child: Column(
                              children: [
                                const Text(
                                  'DRAYVE',
                                  style: TextStyle(
                                    fontFamily: 'Ethnocentric',
                                    fontStyle: FontStyle.italic,
                                    color: Color(
                                      0xFFE10600,
                                    ),
                                    fontSize: 30,
                                    letterSpacing: 2.0,
                                    height: 1.0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'F1 DRIVERS & RACING HUB',
                                  style: TextStyle(
                                    color: Colors.white.withValues(
                                      alpha: 0.45,
                                    ),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 3.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
            ),
          ),
        ],
      ),
    );
  }
}

class _GridBackgroundPainter
    extends
        CustomPainter {
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final paint = Paint()
      ..color = Colors.white.withValues(
        alpha: 0.03,
      )
      ..strokeWidth = 1.0;

    const spacing = 48.0;
    for (
      double x = 0;
      x <
          size.width;
      x += spacing
    ) {
      canvas.drawLine(
        Offset(
          x,
          0,
        ),
        Offset(
          x,
          size.height,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) => false;
}

class _DrayveLogoPainter
    extends
        CustomPainter {
  final double strokeProgress;
  final double fillProgress;
  final double strokeFade;

  _DrayveLogoPainter({required this.strokeProgress, required this.fillProgress, required this.strokeFade});

  // Presisi geometri dari logo DRAVE.png (3 elemen sayap F1)
  List<
    Path
  >
  _buildLogoPaths(
    Size s,
  ) {
    final w = s.width;
    final h = s.height;

    // 1. Sayap Atas/Luar
    final outerWing = Path()
      ..moveTo(
        w *
            0.04,
        h *
            0.92,
      )
      ..lineTo(
        w *
            0.37,
        h *
            0.10,
      )
      ..cubicTo(
        w *
            0.40,
        h *
            0.03,
        w *
            0.45,
        h *
            0.02,
        w *
            0.53,
        h *
            0.02,
      )
      ..lineTo(
        w *
            0.68,
        h *
            0.02,
      )
      ..cubicTo(
        w *
            0.75,
        h *
            0.02,
        w *
            0.80,
        h *
            0.09,
        w *
            0.81,
        h *
            0.19,
      )
      ..lineTo(
        w *
            0.76,
        h *
            0.34,
      )
      ..cubicTo(
        w *
            0.74,
        h *
            0.25,
        w *
            0.70,
        h *
            0.22,
        w *
            0.63,
        h *
            0.22,
      )
      ..lineTo(
        w *
            0.47,
        h *
            0.22,
      )
      ..cubicTo(
        w *
            0.43,
        h *
            0.22,
        w *
            0.40,
        h *
            0.25,
        w *
            0.37,
        h *
            0.31,
      )
      ..lineTo(
        w *
            0.17,
        h *
            0.92,
      )
      ..close();

    // 2. Sayap Dalam (Lengkungan tajam ke tengah bawah)
    final innerWing = Path()
      ..moveTo(
        w *
            0.21,
        h *
            0.92,
      )
      ..lineTo(
        w *
            0.39,
        h *
            0.39,
      )
      ..cubicTo(
        w *
            0.42,
        h *
            0.31,
        w *
            0.46,
        h *
            0.29,
        w *
            0.53,
        h *
            0.29,
      )
      ..lineTo(
        w *
            0.66,
        h *
            0.29,
      )
      ..cubicTo(
        w *
            0.74,
        h *
            0.29,
        w *
            0.76,
        h *
            0.38,
        w *
            0.71,
        h *
            0.51,
      )
      ..cubicTo(
        w *
            0.65,
        h *
            0.68,
        w *
            0.56,
        h *
            0.82,
        w *
            0.47,
        h *
            0.92,
      )
      ..cubicTo(
        w *
            0.54,
        h *
            0.78,
        w *
            0.60,
        h *
            0.65,
        w *
            0.63,
        h *
            0.54,
      )
      ..cubicTo(
        w *
            0.64,
        h *
            0.49,
        w *
            0.62,
        h *
            0.47,
        w *
            0.57,
        h *
            0.47,
      )
      ..lineTo(
        w *
            0.49,
        h *
            0.47,
      )
      ..cubicTo(
        w *
            0.46,
        h *
            0.47,
        w *
            0.44,
        h *
            0.49,
        w *
            0.42,
        h *
            0.55,
      )
      ..lineTo(
        w *
            0.34,
        h *
            0.92,
      )
      ..close();

    // 3. Garis Miring Cepat Kanan (Speed Slash)
    final rightSlash = Path()
      ..moveTo(
        w *
            0.59,
        h *
            0.92,
      )
      ..lineTo(
        w *
            0.85,
        h *
            0.02,
      )
      ..lineTo(
        w *
            0.96,
        h *
            0.02,
      )
      ..lineTo(
        w *
            0.70,
        h *
            0.92,
      )
      ..close();

    return [
      outerWing,
      innerWing,
      rightSlash,
    ];
  }

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final paths = _buildLogoPaths(
      size,
    );

    // A. Gambar isi warna Merah F1 dengan efek Glow lembut saat Fade-In
    if (fillProgress >
        0) {
      final glowFillPaint = Paint()
        ..color =
            const Color(
              0xFFE10600,
            ).withValues(
              alpha:
                  0.35 *
                  fillProgress,
            )
        ..style = PaintingStyle.fill
        ..maskFilter = const MaskFilter.blur(
          BlurStyle.normal,
          18,
        );

      final solidFillPaint = Paint()
        ..color =
            const Color(
              0xFFE10600,
            ).withValues(
              alpha: fillProgress,
            )
        ..style = PaintingStyle.fill;

      for (final p in paths) {
        canvas.drawPath(
          p,
          glowFillPaint,
        );
        canvas.drawPath(
          p,
          solidFillPaint,
        );
      }
    }

    // B. Gambar animasi garis putih menyala + titik cahaya di ujung tarikan
    if (strokeProgress >
            0 &&
        strokeFade >
            0) {
      final glowStrokePaint = Paint()
        ..color = Colors.white.withValues(
          alpha:
              0.6 *
              strokeFade,
        )
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..maskFilter = const MaskFilter.blur(
          BlurStyle.normal,
          6,
        );

      final coreStrokePaint = Paint()
        ..color = Colors.white.withValues(
          alpha:
              0.95 *
              strokeFade,
        )
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      for (final p in paths) {
        for (final PathMetric metric in p.computeMetrics()) {
          final currentLength =
              metric.length *
              strokeProgress;
          final extract = metric.extractPath(
            0,
            currentLength,
          );

          canvas.drawPath(
            extract,
            glowStrokePaint,
          );
          canvas.drawPath(
            extract,
            coreStrokePaint,
          );

          // Titik cahaya (Leading Dot) di ujung garis seperti di video referensi
          if (strokeProgress <
              0.98) {
            final tangent = metric.getTangentForOffset(
              currentLength,
            );
            if (tangent !=
                null) {
              canvas.drawCircle(
                tangent.position,
                5.0,
                Paint()
                  ..color = Colors.white.withValues(
                    alpha:
                        0.85 *
                        strokeFade,
                  )
                  ..maskFilter = const MaskFilter.blur(
                    BlurStyle.normal,
                    6,
                  ),
              );
              canvas.drawCircle(
                tangent.position,
                2.2,
                Paint()
                  ..color = Colors.white.withValues(
                    alpha: strokeFade,
                  ),
              );
            }
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(
    covariant _DrayveLogoPainter oldDelegate,
  ) {
    return oldDelegate.strokeProgress !=
            strokeProgress ||
        oldDelegate.fillProgress !=
            fillProgress ||
        oldDelegate.strokeFade !=
            strokeFade;
  }
}
