import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// ScrollController yang membuat scroll MOUSE WHEEL & TRACKPAD di web halus
/// dan konsisten.
///
/// Secara default, Flutter Web melompat langsung ±100px setiap putaran
/// wheel sehingga terasa "patah-patah", sedangkan trackpad (di Windows/Chrome
/// dikirim sebagai event wheel juga) mengirim delta yang ukurannya acak
/// sehingga terasa macet-macet.
///
/// Di sini SEMUA event wheel/trackpad diperlakukan sama: delta dijumlahkan ke
/// satu target, lalu setiap frame posisi scroll mengejar target tersebut
/// dengan smoothing eksponensial (independen dari frame rate). Hasilnya
/// trackpad terasa sama seperti mouse biasa: halus dan responsif.
class SmoothScrollController extends ScrollController {
  SmoothScrollController({
    this.smoothing = 16.0,
  });

  /// Semakin besar, semakin cepat posisi mengejar target (lebih "snappy").
  final double smoothing;

  @override
  ScrollPosition createScrollPosition(
    ScrollPhysics physics,
    ScrollContext context,
    ScrollPosition? oldPosition,
  ) {
    return _SmoothScrollPosition(
      physics: physics,
      context: context,
      initialPixels: initialScrollOffset,
      keepScrollOffset: keepScrollOffset,
      oldPosition: oldPosition,
      debugLabel: debugLabel,
      smoothing: smoothing,
    );
  }
}

class _SmoothScrollPosition extends ScrollPositionWithSingleContext {
  _SmoothScrollPosition({
    required super.physics,
    required super.context,
    super.initialPixels,
    super.keepScrollOffset,
    super.oldPosition,
    super.debugLabel,
    required this.smoothing,
  });

  final double smoothing;

  /// Tujuan scroll yang sedang dikejar (null = tidak ada).
  double? _target;
  Ticker? _ticker;
  Duration _lastElapsed = Duration.zero;
  bool _selfScrolling = false;

  @override
  void pointerScroll(double delta) {
    if (delta == 0.0) return;

    final double from = _target ?? pixels;
    final double target = (from + delta).clamp(minScrollExtent, maxScrollExtent);
    if (target == pixels && _target == null) return;
    _target = target;

    _ticker ??= context.vsync.createTicker(_onTick);
    if (!_ticker!.isActive) {
      _lastElapsed = Duration.zero;
      _ticker!.start();
    }
  }

  void _onTick(Duration elapsed) {
    final double? target = _target;
    if (target == null) {
      _stop();
      return;
    }

    final double dt = ((elapsed - _lastElapsed).inMicroseconds / 1e6)
        .clamp(0.0, 0.05);
    _lastElapsed = elapsed;

    // Jaga target tetap valid jika konten berubah ukuran.
    final double clampedTarget =
        target.clamp(minScrollExtent, maxScrollExtent);
    _target = clampedTarget;

    final double diff = clampedTarget - pixels;
    double step;
    if (diff.abs() < 0.5) {
      step = diff;
    } else {
      final double t = 1.0 - math.exp(-smoothing * (dt == 0 ? 1 / 60 : dt));
      step = diff * t;
    }

    if (step != 0.0) {
      _selfScrolling = true;
      super.pointerScroll(step);
      _selfScrolling = false;
    }

    if ((clampedTarget - pixels).abs() < 0.5) {
      _stop();
    }
  }

  void _stop() {
    _target = null;
    if (_ticker?.isActive ?? false) _ticker!.stop();
  }

  @override
  void beginActivity(ScrollActivity? newActivity) {
    // Kalau user drag / animateTo / fling, hentikan smoothing wheel.
    if (!_selfScrolling && newActivity is! IdleScrollActivity) {
      _stop();
    }
    super.beginActivity(newActivity);
  }

  @override
  void dispose() {
    _ticker?.dispose();
    _ticker = null;
    super.dispose();
  }
}

/// CustomScrollView yang otomatis memakai [SmoothScrollController]
/// dan membuang controller-nya sendiri saat tidak dipakai.
class SmoothScrollView extends StatefulWidget {
  const SmoothScrollView({super.key, required this.slivers});

  final List<Widget> slivers;

  @override
  State<SmoothScrollView> createState() => _SmoothScrollViewState();
}

class _SmoothScrollViewState extends State<SmoothScrollView> {
  final SmoothScrollController _controller = SmoothScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _controller,
      slivers: widget.slivers,
    );
  }
}
