import 'package:flutter/material.dart';

/// ScrollController yang membuat scroll MOUSE WHEEL di web jadi halus.
///
/// Secara default, Flutter Web melompat langsung ±100px setiap putaran
/// wheel sehingga terasa "patah-patah". Di sini setiap putaran wheel
/// dianimasikan (easeOutCubic). Putaran beruntun dijumlahkan ke target yang
/// sama, jadi scroll cepat tetap responsif.
///
/// Trackpad & layar sentuh tidak diubah karena sudah halus secara alami.
class SmoothScrollController extends ScrollController {
  SmoothScrollController({
    this.duration = const Duration(milliseconds: 420),
    this.curve = Curves.easeOutCubic,
  });

  final Duration duration;
  final Curve curve;

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
      duration: duration,
      curve: curve,
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
    required this.duration,
    required this.curve,
  });

  final Duration duration;
  final Curve curve;

  /// Tujuan animasi wheel yang sedang berjalan (null = tidak ada).
  double? _target;

  @override
  void pointerScroll(double delta) {
    if (delta == 0.0) return;

    // Delta kecil & beruntun biasanya dari trackpad -> biarkan default.
    if (delta.abs() < 30) {
      _target = null;
      super.pointerScroll(delta);
      return;
    }

    final from = _target ?? pixels;
    final target = (from + delta).clamp(minScrollExtent, maxScrollExtent);
    if (target == pixels) return;
    _target = target;
    animateTo(target, duration: duration, curve: curve);
  }

  @override
  void beginActivity(ScrollActivity? newActivity) {
    // Kalau user drag / scroll dengan cara lain, lupakan target wheel.
    if (newActivity is! DrivenScrollActivity) _target = null;
    super.beginActivity(newActivity);
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
