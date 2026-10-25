import 'dart:async';

import 'package:flutter/material.dart';

/// Memunculkan [child] dengan animasi fade + naik + zoom kecil.
///
/// Animasi hanya diputar SEKALI per [id] (selama web terbuka), jadi saat
/// user scroll naik-turun kartu tidak beranimasi berulang-ulang.
class RevealOnce
    extends
        StatefulWidget {
  const RevealOnce({super.key, required this.id, required this.child, this.delay = Duration.zero, this.play = true});

  final String id;
  final Widget child;
  final Duration delay;

  /// Animasi baru dimulai ketika `play` bernilai true
  /// (misalnya menunggu intro lampu start selesai).
  final bool play;

  static final Set<
    String
  >
  _revealed =
      <
        String
      >{};

  @override
  State<
    RevealOnce
  >
  createState() => _RevealOnceState();
}

class _RevealOnceState
    extends
        State<
          RevealOnce
        >
    with
        SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 650,
    ),
  );
  late final Animation<
    double
  >
  _curve = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutCubic,
  );
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (RevealOnce._revealed.contains(
      widget.id,
    )) {
      _controller.value = 1;
    } else if (widget.play) {
      _schedule();
    }
  }

  @override
  void didUpdateWidget(
    covariant RevealOnce oldWidget,
  ) {
    super.didUpdateWidget(
      oldWidget,
    );
    if (widget.play &&
        !oldWidget.play &&
        _controller.value ==
            0 &&
        _timer ==
            null) {
      _schedule();
    }
  }

  void _schedule() {
    RevealOnce._revealed.add(
      widget.id,
    );
    _timer = Timer(
      widget.delay,
      () {
        if (mounted) _controller.forward();
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return AnimatedBuilder(
      animation: _curve,
      child: widget.child,
      builder:
          (
            context,
            child,
          ) {
            final v = _curve.value;
            // Struktur widget dibuat tetap sama (walau v = 1) agar state child
            // (misalnya animasi hover kartu) tidak ter-reset.
            return Opacity(
              opacity: v,
              child: Transform.translate(
                offset: Offset(
                  0,
                  48 *
                      (1 -
                          v),
                ),
                child: Transform.scale(
                  scale:
                      0.94 +
                      0.06 *
                          v,
                  child: child,
                ),
              ),
            );
          },
    );
  }
}

/// Membesar sedikit saat di-hover dan mengecil saat ditekan.
/// Membuat tombol/ikon terasa "hidup" dan responsif.
class HoverScale
    extends
        StatefulWidget {
  const HoverScale({super.key, required this.child, this.onTap, this.scale = 1.06});

  final Widget child;
  final VoidCallback? onTap;
  final double scale;

  @override
  State<
    HoverScale
  >
  createState() => _HoverScaleState();
}

class _HoverScaleState
    extends
        State<
          HoverScale
        > {
  bool _hover = false;
  bool _pressed = false;

  @override
  Widget build(
    BuildContext context,
  ) {
    final scale = _pressed
        ? 0.95
        : (_hover
              ? widget.scale
              : 1.0);
    Widget result = AnimatedScale(
      scale: scale,
      duration: const Duration(
        milliseconds: 180,
      ),
      curve: Curves.easeOutBack,
      child: widget.child,
    );

    if (widget.onTap !=
        null) {
      result = GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        onTapDown:
            (
              _,
            ) => setState(
              () => _pressed = true,
            ),
        onTapUp:
            (
              _,
            ) => setState(
              () => _pressed = false,
            ),
        onTapCancel: () => setState(
          () => _pressed = false,
        ),
        child: result,
      );
    }

    return MouseRegion(
      cursor:
          widget.onTap !=
              null
          ? SystemMouseCursors.click
          : MouseCursor.defer,
      onEnter:
          (
            _,
          ) => setState(
            () => _hover = true,
          ),
      onExit:
          (
            _,
          ) => setState(
            () => _hover = false,
          ),
      child: result,
    );
  }
}
