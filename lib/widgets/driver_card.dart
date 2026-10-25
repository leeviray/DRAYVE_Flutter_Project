import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drayve/models/statistik.dart';
import 'package:drayve/pages/driver_detail_page.dart';
import 'package:drayve/widgets/drayve_page_route.dart';

class DriverCard
    extends
        StatefulWidget {
  final Statistik driver;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const DriverCard({super.key, required this.driver, required this.isFavorite, required this.onFavoriteToggle});

  @override
  State<
    DriverCard
  >
  createState() => _DriverCardState();
}

class _DriverCardState
    extends
        State<
          DriverCard
        > {
  bool _hovered = false;
  bool _pressed = false;

  /// Posisi kursor relatif terhadap tengah kartu (-1..1) untuk efek 3D tilt & parallax.
  Offset _pointer = Offset.zero;

  // Warna utama & kedua berdasarkan nama tim
  (
    Color,
    Color,
  )
  _getTeamColors(
    String teamName,
  ) {
    final lower = teamName.toLowerCase();
    if (lower.contains(
      'ferrari',
    )) {
      return (
        const Color(
          0xFFE8002D,
        ),
        const Color(
          0xFF7A0018,
        ),
      );
    } else if (lower.contains(
      'mercedes',
    )) {
      return (
        const Color(
          0xFF00A19B,
        ),
        const Color(
          0xFF004D4A,
        ),
      );
    } else if (lower.contains(
      'mclaren',
    )) {
      return (
        const Color(
          0xFFFF8000,
        ),
        const Color(
          0xFF804000,
        ),
      );
    } else if (lower.contains(
      'red bull',
    )) {
      return (
        const Color(
          0xFF152A72,
        ),
        const Color(
          0xFF0A1539,
        ),
      );
    } else if (lower.contains(
      'aston',
    )) {
      return (
        const Color(
          0xFF229971,
        ),
        const Color(
          0xFF0E4C38,
        ),
      );
    } else if (lower.contains(
      'williams',
    )) {
      return (
        const Color(
          0xFF005AFF,
        ),
        const Color(
          0xFF002D80,
        ),
      );
    } else if (lower.contains(
      'audi',
    )) {
      return (
        const Color(
          0xFFE20514,
        ),
        const Color(
          0xFF71020A,
        ),
      );
    } else if (lower.contains(
      'haas',
    )) {
      return (
        const Color(
          0xFFB6BABD,
        ),
        const Color(
          0xFF5B5D5E,
        ),
      );
    } else if (lower.contains(
      'alpine',
    )) {
      return (
        const Color(
          0xFFFF90C3,
        ),
        const Color(
          0xFF804861,
        ),
      );
    } else if (lower.contains(
      'racing bulls',
    )) {
      return (
        const Color(
          0xFF6692FF,
        ),
        const Color(
          0xFF334980,
        ),
      );
    } else if (lower.contains(
      'cadillac',
    )) {
      return (
        const Color(
          0xFFD4A373,
        ),
        const Color(
          0xFF6A5139,
        ),
      );
    } else {
      return (
        const Color(
          0xFF2A2D34,
        ),
        const Color(
          0xFF000000,
        ),
      );
    }
  }

  void _onHover(
    PointerHoverEvent event,
    Size size,
  ) {
    if (size.isEmpty) return;
    final dx =
        ((event.localPosition.dx /
                        size.width) *
                    2 -
                1)
            .clamp(
              -1.0,
              1.0,
            );
    final dy =
        ((event.localPosition.dy /
                        size.height) *
                    2 -
                1)
            .clamp(
              -1.0,
              1.0,
            );
    setState(() {
      _hovered = true;
      _pointer = Offset(
        dx,
        dy,
      );
    });
  }

  void _onExit(
    PointerExitEvent event,
  ) {
    setState(() {
      _hovered = false;
      _pressed = false;
      _pointer = Offset.zero;
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final driver = widget.driver;
    final (
      color1,
      color2,
    ) = _getTeamColors(
      driver.tim,
    );
    final parts = driver.nama.split(
      ' ',
    );
    final firstName = parts.first;
    final lastName =
        parts.length >
            1
        ? parts.last
        : '';

    final scale = _pressed
        ? 0.97
        : (_hovered
              ? 1.025
              : 1.0);
    final tiltX = _hovered
        ? -_pointer.dy *
              0.055
        : 0.0;
    final tiltY = _hovered
        ? _pointer.dx *
              0.055
        : 0.0;

    return RepaintBoundary(
      child: LayoutBuilder(
        builder:
            (
              context,
              constraints,
            ) {
              final size = constraints.biggest;
              return MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter:
                    (
                      _,
                    ) => setState(
                      () => _hovered = true,
                    ),
                onHover:
                    (
                      e,
                    ) => _onHover(
                      e,
                      size,
                    ),
                onExit: _onExit,
                child: GestureDetector(
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
                  onTap: () {
                    Navigator.push(
                      context,
                      DrayvePageRoute(
                        builder:
                            (
                              context,
                            ) => DriverDetailPage(
                              driver: driver,
                            ),
                      ),
                    );
                  },
                  child:
                      TweenAnimationBuilder<
                        Offset
                      >(
                        tween:
                            Tween<
                              Offset
                            >(
                              begin: Offset.zero,
                              end: _pointer,
                            ),
                        duration: const Duration(
                          milliseconds: 220,
                        ),
                        curve: Curves.easeOutCubic,
                        builder:
                            (
                              context,
                              smoothPointer,
                              _,
                            ) {
                              return AnimatedScale(
                                scale: scale,
                                duration: const Duration(
                                  milliseconds: 220,
                                ),
                                curve: Curves.easeOutCubic,
                                child: Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.identity()
                                    ..setEntry(
                                      3,
                                      2,
                                      0.001,
                                    )
                                    ..rotateX(
                                      tiltX,
                                    )
                                    ..rotateY(
                                      tiltY,
                                    ),
                                  child: AnimatedContainer(
                                    duration: const Duration(
                                      milliseconds: 240,
                                    ),
                                    curve: Curves.easeOutCubic,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        20,
                                      ),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          color1,
                                          color2,
                                        ],
                                      ),
                                      border: Border.all(
                                        color: _hovered
                                            ? Colors.white.withValues(
                                                alpha: 0.55,
                                              )
                                            : Colors.white.withValues(
                                                alpha: 0.10,
                                              ),
                                        width: _hovered
                                            ? 1.6
                                            : 1.0,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: color1.withValues(
                                            alpha: _hovered
                                                ? 0.50
                                                : 0.18,
                                          ),
                                          blurRadius: _hovered
                                              ? 28
                                              : 12,
                                          spreadRadius: _hovered
                                              ? 2
                                              : 0,
                                          offset: Offset(
                                            0,
                                            _hovered
                                                ? 14
                                                : 6,
                                          ),
                                        ),
                                      ],
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: Stack(
                                      children: [
                                        // --- LAYER 0: Background Pattern (Tanpa Opacity widget agar hemat GPU) ---
                                        Positioned(
                                          top: 0,
                                          right: -900,
                                          left: -50,
                                          bottom: -50,
                                          child: RotatedBox(
                                            quarterTurns: 1,
                                            child: Image.asset(
                                              'assets/images/pattern.webp',
                                              fit: BoxFit.cover,
                                              color: const Color(
                                                0x26FFFFFF,
                                              ),
                                              colorBlendMode: BlendMode.modulate,
                                              errorBuilder: (
                                                context,
                                                error,
                                                stackTrace,
                                              ) => const SizedBox(),
                                            ),
                                          ),
                                        ),

                                        // --- LAYER 1: Gambar Mobil ---
                                        Positioned(
                                          left: -250,
                                          bottom: -210,
                                          child: RotatedBox(
                                            quarterTurns: 1,
                                            child: Image.asset(
                                              driver.fotoMobil,
                                              height: 580,
                                              fit: BoxFit.contain,
                                              errorBuilder: (
                                                context,
                                                error,
                                                stackTrace,
                                              ) => const SizedBox(),
                                            ),
                                          ),
                                        ),

                                        // --- LAYER 2: Gambar Wajah Pembalap ---
                                        Positioned(
                                          right: 60,
                                          bottom: -310,
                                          child: Image.asset(
                                            driver.fotoAset,
                                            height: 600,
                                            fit: BoxFit.contain,
                                            alignment: Alignment.bottomRight,
                                            errorBuilder:
                                                (
                                                  context,
                                                  error,
                                                  stackTrace,
                                                ) {
                                                  return const Align(
                                                    alignment: Alignment.bottomRight,
                                                    child: Icon(
                                                      Icons.person,
                                                      size: 120,
                                                      color: Colors.white24,
                                                    ),
                                                  );
                                                },
                                          ),
                                        ),

                                        // --- LAYER 2.5: Kilau cahaya halus mengikuti kursor ---
                                        if (_hovered)
                                          Positioned.fill(
                                            child: IgnorePointer(
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  gradient: RadialGradient(
                                                    center: Alignment(
                                                      smoothPointer.dx,
                                                      smoothPointer.dy,
                                                    ),
                                                    radius: 0.95,
                                                    colors: [
                                                      Colors.white.withValues(
                                                        alpha: 0.16,
                                                      ),
                                                      Colors.transparent,
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                        // --- LAYER 3: Teks Utama ---
                                        Positioned(
                                          top: 24,
                                          left: 24,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                firstName,
                                                style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.1,
                                                ),
                                              ),
                                              Text(
                                                lastName,
                                                style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  height: 1.1,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 2,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.black.withValues(
                                                    alpha: 0.28,
                                                  ),
                                                  borderRadius: BorderRadius.circular(
                                                    6,
                                                  ),
                                                ),
                                                child: Text(
                                                  driver.tim,
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              AnimatedSlide(
                                                offset: _hovered
                                                    ? const Offset(
                                                        0.04,
                                                        0,
                                                      )
                                                    : Offset.zero,
                                                duration: const Duration(
                                                  milliseconds: 220,
                                                ),
                                                curve: Curves.easeOutCubic,
                                                child: Text(
                                                  driver.nomorMobil.toString(),
                                                  style: GoogleFonts.montserrat(
                                                    color: Colors.white,
                                                    fontSize: 48,
                                                    fontWeight: FontWeight.w900,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // --- LAYER 4: Lingkaran Bendera Otomatis ---
                                        Positioned(
                                          top: 24,
                                          right: 24,
                                          child: Container(
                                            width: 36,
                                            height: 36,
                                            decoration: BoxDecoration(
                                              color: const Color(
                                                0xFFD9D9D9,
                                              ),
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.white.withValues(
                                                  alpha: 0.6,
                                                ),
                                                width: 1.5,
                                              ),
                                            ),
                                            clipBehavior: Clip.antiAlias,
                                            child: Image.asset(
                                              'assets/images/flags/${driver.negara.toLowerCase()}.webp',
                                              fit: BoxFit.cover,
                                              cacheWidth: 96,
                                              errorBuilder:
                                                  (
                                                    context,
                                                    error,
                                                    stackTrace,
                                                  ) => const Icon(
                                                    Icons.flag,
                                                    size: 20,
                                                    color: Colors.black54,
                                                  ),
                                            ),
                                          ),
                                        ),

                                        // --- LAYER 5: TOMBOL BINTANG FAVORITE INTERAKTIF ---
                                        Positioned(
                                          bottom: 16,
                                          right: 16,
                                          child: GestureDetector(
                                            onTap: widget.onFavoriteToggle,
                                            child: AnimatedContainer(
                                              duration: const Duration(
                                                milliseconds: 200,
                                              ),
                                              padding: const EdgeInsets.all(
                                                8,
                                              ),
                                              decoration: BoxDecoration(
                                                color: widget.isFavorite
                                                    ? Colors.amber.withValues(
                                                        alpha: 0.22,
                                                      )
                                                    : Colors.black.withValues(
                                                        alpha: 0.5,
                                                      ),
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: widget.isFavorite
                                                      ? Colors.amber
                                                      : Colors.white24,
                                                  width: 1.2,
                                                ),
                                              ),
                                              child: AnimatedScale(
                                                scale: widget.isFavorite
                                                    ? 1.15
                                                    : 1.0,
                                                duration: const Duration(
                                                  milliseconds: 200,
                                                ),
                                                curve: Curves.elasticOut,
                                                child: Icon(
                                                  widget.isFavorite
                                                      ? Icons.star_rounded
                                                      : Icons.star_border_rounded,
                                                  color: widget.isFavorite
                                                      ? Colors.amber
                                                      : Colors.white,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                      ),
                ),
              );
            },
      ),
    );
  }
}
