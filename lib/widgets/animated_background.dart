import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Background animasi DRAYVE (versi ringan & interaktif).
///
/// Lapisan (belakang -> depan):
/// 1. Gradasi "bernapas"  : gumpalan warna oranye–maroon yang bergerak pelan
///                          dan ikut bergeser mengikuti kursor (parallax).
/// 2. Kolase F1           : `bgnice.webp` samar, ikut bergeser sedikit.
/// 3. Cursor glow          : cahaya lembut mengikuti kursor.
/// 4. Vignette            : menggelapkan pinggir agar konten tetap terbaca.
class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key, this.paused = false});

  /// Hentikan animasi (background tetap tampil sebagai gambar diam).
  final bool paused;

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

/// Semua nilai yang berubah tiap frame dikumpulkan di sini.
/// Painter "mendengarkan" objek ini, jadi hanya painter yang repaint.
class _Scene extends ChangeNotifier {
  double time = 0; // waktu berjalan (detik)
  Offset parallax = Offset.zero; // posisi kursor ternormalisasi (-1..1), dihaluskan
  Offset? cursor; // posisi kursor (px lokal), dihaluskan
  double cursorStrength = 0; // 0..1, fade-in cahaya kursor

  void markDirty() => notifyListeners();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  final _Scene _scene = _Scene();

  Duration _lastElapsed = Duration.zero;
  Offset? _pointerGlobal;
  bool _reduceMotion = false;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick);
    // Menangkap semua event pointer (baik hover tanpa klik maupun drag/move)
    GestureBinding.instance.pointerRouter.addGlobalRoute(_onPointer);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _reduceMotion = MediaQuery.disableAnimationsOf(context);
    _syncTicker();
  }

  @override
  void didUpdateWidget(covariant AnimatedBackground oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.paused != widget.paused) _syncTicker();
  }

  @override
  void dispose() {
    GestureBinding.instance.pointerRouter.removeGlobalRoute(_onPointer);
    _ticker.dispose();
    _scene.dispose();
    super.dispose();
  }

  bool get _shouldAnimate => !widget.paused && !_reduceMotion;

  void _syncTicker() {
    if (_shouldAnimate && !_ticker.isActive) {
      _lastElapsed = Duration.zero;
      _ticker.start();
    } else if (!_shouldAnimate && _ticker.isActive) {
      _ticker.stop();
    }
  }

  void _onPointer(PointerEvent event) {
    if (event is PointerExitEvent) return;
    if (event.position != Offset.zero) {
      _pointerGlobal = event.position;
    }
  }

  void _onTick(Duration elapsed) {
    final rawDt = (elapsed - _lastElapsed).inMicroseconds / 1e6;
    _lastElapsed = elapsed;
    if (rawDt <= 0) return;
    // Batasi dt supaya animasi tidak "lompat" setelah tab tidak aktif.
    final dt = math.min(rawDt, 0.05);

    final s = _scene;
    s.time += dt;

    // --- Kursor: dihaluskan (easing) supaya gerakannya mulus mengikuti mouse ---
    final box = context.findRenderObject() as RenderBox?;
    final pointer = _pointerGlobal;
    if (box != null && box.hasSize && pointer != null) {
      final local = box.globalToLocal(pointer);
      final size = box.size;
      final k = 1 - math.exp(-dt * 10);
      s.cursor = s.cursor == null ? local : Offset.lerp(s.cursor, local, k);
      final norm = Offset(
        (local.dx / size.width * 2 - 1).clamp(-1.0, 1.0),
        (local.dy / size.height * 2 - 1).clamp(-1.0, 1.0),
      );
      s.parallax = Offset.lerp(s.parallax, norm, 1 - math.exp(-dt * 4.0))!;
      s.cursorStrength = (s.cursorStrength + dt * 3.0).clamp(0.0, 1.0);
    }

    s.markDirty();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      opaque: false,
      onHover: (e) => _pointerGlobal = e.position,
      child: IgnorePointer(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Lapisan 1: gradasi bergerak + parallax kursor
            RepaintBoundary(
              child: CustomPaint(painter: _BlobPainter(_scene)),
            ),

            // Lapisan 2: kolase F1 (cacheWidth agar hemat VRAM meski file 4671x2628)
            RepaintBoundary(
              child: AnimatedBuilder(
                animation: _scene,
                builder: (context, child) {
                  final p = _scene.parallax;
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.translationValues(
                      -p.dx * 18,
                      -p.dy * 12,
                      0,
                    )..multiply(Matrix4.diagonal3Values(1.06, 1.06, 1)),
                    child: child,
                  );
                },
                child: RepaintBoundary(
                  child: Image.asset(
                    'assets/images/bgnice.webp',
                    fit: BoxFit.cover,
                    cacheWidth: 1920,
                    color: const Color(0x26D9D9D9),
                    colorBlendMode: BlendMode.modulate,
                    gaplessPlayback: true,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox.shrink(),
                  ),
                ),
              ),
            ),

            // Lapisan 3: cahaya kursor
            RepaintBoundary(
              child: CustomPaint(painter: _CursorGlowPainter(_scene)),
            ),

            // Lapisan 4: vignette (statis)
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  radius: 1.15,
                  colors: [Colors.transparent, Color(0x99000000)],
                  stops: [0.45, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
// ---------------------------------------------------------------------------
// LAPISAN 1 — Gradasi bergerak
// ---------------------------------------------------------------------------

class _Blob {
  const _Blob({
    required this.color,
    required this.center,
    required this.drift,
    required this.radius,
    required this.period,
    required this.phase,
  });

  final Color color;
  final Offset center; // posisi dasar (0..1)
  final Offset drift; // jarak geser (0..1)
  final double radius; // relatif sisi terpanjang layar
  final double period; // detik per putaran (makin besar makin pelan)
  final double phase; // titik awal putaran (radian)
}
const List<_Blob> _blobs = [
  _Blob(
    color: Color(0xFF8A4B0B), // oranye amber (kiri bawah)
    center: Offset(0.05, 0.95),
    drift: Offset(0.15, 0.10),
    radius: 0.75,
    period: 26,
    phase: 0,
  ),
  _Blob(
    color: Color(0xFF7A2812), // oranye bata (tengah)
    center: Offset(0.45, 0.45),
    drift: Offset(0.20, 0.15),
    radius: 0.70,
    period: 34,
    phase: 1.7,
  ),
  _Blob(
    color: Color(0xFF5C0418), // maroon (kanan atas)
    center: Offset(0.95, 0.15),
    drift: Offset(0.10, 0.20),
    radius: 0.80,
    period: 30,
    phase: 3.1,
  ),
  _Blob(
    color: Color(0x47E10600), // aksen merah DRAYVE, transparan
    center: Offset(0.75, 0.80),
    drift: Offset(0.25, 0.15),
    radius: 0.45,
    period: 22,
    phase: 4.4,
  ),
];

class _BlobPainter extends CustomPainter {
  _BlobPainter(this.scene) : super(repaint: scene);

  final _Scene scene;

  static final Paint _basePaint = Paint()..color = const Color(0xFF2B0A0D);

  /// Shader radial dibuat SEKALI dengan jari-jari 1 di titik (0,0).
  static final List<Paint> _blobPaints = [
    for (final b in _blobs)
      Paint()
        ..shader = ui.Gradient.radial(
          Offset.zero,
          1,
          [
            b.color,
            b.color.withValues(alpha: b.color.a * 0.5),
            b.color.withValues(alpha: 0),
          ],
          const [0.0, 0.45, 1.0],
        ),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final t = scene.time;
    final longestSide = size.longestSide;
    final parallax = scene.parallax;

    canvas.drawRect(Offset.zero & size, _basePaint);

    for (var i = 0; i < _blobs.length; i++) {
      final blob = _blobs[i];
      final angle = 2 * math.pi * t / blob.period + blob.phase;
      final depth = 24.0 + i * 14; // tiap gumpalan beda kedalaman parallax
      final center = Offset(
        (blob.center.dx + blob.drift.dx * math.sin(angle)) * size.width -
            parallax.dx * depth,
        (blob.center.dy + blob.drift.dy * math.cos(angle * 0.8)) * size.height -
            parallax.dy * depth,
      );

      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.scale(blob.radius * longestSide);
      canvas.drawCircle(Offset.zero, 1, _blobPaints[i]);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _BlobPainter oldDelegate) =>
      oldDelegate.scene != scene;
}

// ---------------------------------------------------------------------------
// LAPISAN 3 — Cahaya kursor
// ---------------------------------------------------------------------------

class _CursorGlowPainter extends CustomPainter {
  _CursorGlowPainter(this.scene) : super(repaint: scene);

  final _Scene scene;

  static final Paint _cursorPaint = Paint()
    ..blendMode = BlendMode.plus
    ..shader = ui.Gradient.radial(
      Offset.zero,
      1,
      const [
        Color(0x42FF6A2B),
        Color(0x1AE10600),
        Color(0x00E10600),
      ],
      const [0.0, 0.42, 1.0],
    );

  @override
  void paint(Canvas canvas, Size size) {
    final cursor = scene.cursor;
    if (cursor == null || scene.cursorStrength <= 0.01) return;

    canvas.save();
    canvas.translate(cursor.dx, cursor.dy);
    canvas.scale(380);
    canvas.drawCircle(Offset.zero, 1, _cursorPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _CursorGlowPainter oldDelegate) =>
      oldDelegate.scene != scene;
}
