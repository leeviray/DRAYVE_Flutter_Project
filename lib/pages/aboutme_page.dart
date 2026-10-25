import 'dart:ui';
import 'dart:math'
    as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drayve/widgets/interactive.dart';
import 'package:url_launcher/url_launcher.dart';

// ==========================================
// DATA & LAYOUT PROFIL
// ==========================================
class ProfileContent {
  static const name = 'LEEVI QUSHAI\nRAY IFTIKHAR';
  static const email = '25051204390@mhs.unesa.ac.id';

  static const background = 'assets/images/background.webp';
  static const portrait = 'assets/images/profile_cutout.webp';
  static const previous = 'assets/icons/arcticons_music-speed-changer-1.webp';
  static const play = 'assets/icons/arcticons_booming-music.webp';
  static const next = 'assets/icons/arcticons_music-speed-changer.webp';
  static const instagram = 'assets/icons/cib_instagram.webp';
  static const tiktok = 'assets/icons/streamline-flex_tiktok-solid.webp';
  static const github = 'assets/icons/fa-brands_github-square.webp';
  static const headphones = 'assets/icons/arcticons_google-music.webp';
}

class ProfileLayout {
  static const waveLeft = .8;
  static const waveTop = .80;
  static const controlsLeft = .3;
  static const controlsTop = .80;
  static const socialsLeft = .05;
  static const socialsBottom = .10;
  static const headphonesRight = .025;
  static const headphonesBottom = .04;
}

// ==========================================
// HALAMAN UTAMA ABOUT ME
// ==========================================
class AboutMePage
    extends
        StatelessWidget {
  const AboutMePage({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 40,
        ),
        const Text(
          "DRAYVE",
          style: TextStyle(
            fontFamily: 'Ethnocentric',
            fontStyle: FontStyle.italic,
            fontSize: 40,
            color: Colors.white,
            letterSpacing: 2.0,
          ),
        ),
        Text(
          "F1 Drivers Hub Community",
          style: GoogleFonts.montserrat(
            color: Colors.white70,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(
              12,
            ),
          ),
          child: Text(
            "Version 1.0.0",
            style: GoogleFonts.montserrat(
              color: Colors.white54,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(
          height: 32,
        ),

        Container(
          padding: const EdgeInsets.all(
            24,
          ),
          decoration: BoxDecoration(
            color:
                const Color(
                  0xFF15151E,
                ).withOpacity(
                  0.9,
                ),
            borderRadius: BorderRadius.circular(
              16,
            ),
            border: Border.all(
              color: Colors.white12,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ABOUT THE APP",
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "DRAYVE adalah platform komunitas digital interaktif bergaya premium yang didedikasikan untuk penggemar Formula 1 (F1 Drivers Hub Community), secara khusus mengusung tema musim 2026. Aplikasi ini menyajikan statistik mendalam, biografi perjalanan karier, hingga interaksi sosial media dan forum diskusi penggemar.",
                style: GoogleFonts.montserrat(
                  color: Colors.white.withOpacity(
                    0.85,
                  ),
                  fontSize: 14,
                  height: 1.8,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                "DRAYVE menawarkan pengalaman pengguna (user experience) yang melalui fitur-fitur berikut:",
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              _buildFeatureItem(
                Icons.language,
                "1. Responsive Landing Page",
                "Saat aplikasi dibuka, user baik dari layar HP maupun layar lebar Laptop akan langsung disambut oleh deretan kartu pembalap F1 musim 2026. Tampilannya otomatis menyesuaikan ukuran layar agar selalu terlihat proporsional dan rapi.",
              ),
              _buildFeatureItem(
                Icons.dashboard_customize,
                "2. Detail Page Pembalap",
                "Ketika pengguna mengklik salah satu pembalap, mereka akan masuk ke halaman profil khusus. Di sini terdapat empat bagian utama:\n\n• Statistics & Biography: Menyajikan rekam jejak, poin, posisi klasemen, hingga kisah perjalanan karier sang pembalap.\n• Latest Post & Fan Discussion: DRAYVE bukan sekadar aplikasi penyedia data, melainkan platform sosial. Pengguna bisa melihat update postingan terbaru pembalap dan masuk ke ruang obrolan langsung untuk berdiskusi dengan sesama penggemar.",
              ),
              _buildFeatureItem(
                Icons.security,
                "3. Interaksi Cerdas & Animasi Login",
                "Aplikasi ini menggunakan konsep \"Try before you buy\". Siapa pun bisa masuk dan membaca informasi di dalamnya. Namun, ketika pengguna ingin mulai berinteraksi seperti memberi Like pada postingan, mengirim Comment, atau menambahkan pembalap ke daftar Favorite mereka sistem akan dengan cerdas menyela dan mengarahkan mereka untuk masuk/daftar (Login/SignUp).",
              ),
              _buildFeatureItem(
                Icons.manage_accounts,
                "4. Manajemen Profil Pribadi",
                "Setelah berhasil masuk, status pengguna akan berubah. Tombol Login di sudut layar otomatis menjadi ikon Foto Profil. Pengguna memiliki ruang privasi sendiri untuk melihat akun mereka, mengedit nama (username), memperbarui email, dan mengatur profil mereka kapan saja.",
              ),
            ],
          ),
        ),

        const SizedBox(
          height: 48,
        ),
        const Divider(
          color: Colors.white12,
          thickness: 1,
        ),
        const SizedBox(
          height: 40,
        ),

        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "CREATED BY",
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              letterSpacing: 1.5,
            ),
          ),
        ),
        const SizedBox(
          height: 24,
        ),

        const InteractiveProfileCard(),

        const SizedBox(
          height: 60,
        ),
      ],
    );
  }

  Widget _buildFeatureItem(
    IconData icon,
    String title,
    String description,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 24.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: const Color(
              0xFFE8002D,
            ),
            size: 24,
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  description,
                  style: GoogleFonts.montserrat(
                    color: Colors.white70,
                    fontSize: 13,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// KARTU PROFIL INTERAKTIF DENGAN STATE
// ==========================================
class InteractiveProfileCard
    extends
        StatefulWidget {
  const InteractiveProfileCard({super.key});

  @override
  State<
    InteractiveProfileCard
  >
  createState() => _InteractiveProfileCardState();
}

class _InteractiveProfileCardState
    extends
        State<
          InteractiveProfileCard
        > {
  int _currentTrack = 0;
  bool _isPlaying = false;

  final List<
    String
  >
  _quotes = [
    '“Orang Biasa Masih Butuh Banyak Belajar”',
    '“Just work with it”',
    '“Life is a choice”',
  ];

  void _togglePlay() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _nextTrack() {
    setState(() {
      _currentTrack =
          (_currentTrack +
              1) %
          _quotes.length;
    });
  }

  void _prevTrack() {
    setState(() {
      _currentTrack =
          (_currentTrack -
              1 +
              _quotes.length) %
          _quotes.length;
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return LayoutBuilder(
      builder:
          (
            context,
            constraints,
          ) {
            final isWide =
                constraints.maxWidth >=
                760;
            return SizedBox(
              height: isWide
                  ? 500
                  : 560, // Diperpendek sedikit untuk mobile
              width: double.infinity,
              child: Stack(
                clipBehavior: Clip.hardEdge,
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      48,
                    ),
                    child: Image.asset(
                      ProfileContent.background,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (
                            context,
                            error,
                            stackTrace,
                          ) => Container(
                            color: const Color(
                              0xFF2A2D34,
                            ),
                          ),
                    ),
                  ),
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        48,
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 2,
                          sigmaY: 2,
                        ),
                        child: ColoredBox(
                          color: Colors.black.withOpacity(
                            _isPlaying
                                ? 0.3
                                : 0.12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  isWide
                      ? _DesktopCard(
                          quote: _quotes[_currentTrack],
                          isPlaying: _isPlaying,
                          onPrev: _prevTrack,
                          onPlay: _togglePlay,
                          onNext: _nextTrack,
                        )
                      : _MobileCard(
                          quote: _quotes[_currentTrack],
                          isPlaying: _isPlaying,
                          onPrev: _prevTrack,
                          onPlay: _togglePlay,
                          onNext: _nextTrack,
                        ),
                ],
              ),
            );
          },
    );
  }
}

class _GlassCard
    extends
        StatelessWidget {
  final Widget child;
  final bool isPlaying;

  const _GlassCard({required this.child, required this.isPlaying});

  @override
  Widget
  build(
    BuildContext context,
  ) => Stack(
    clipBehavior: Clip.none,
    children: [
      Positioned.fill(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            48,
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 18,
              sigmaY: 18,
            ),
            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: 400,
              ),
              decoration: BoxDecoration(
                color: isPlaying
                    ? const Color(
                        0xFFE8002D,
                      ).withOpacity(
                        0.15,
                      )
                    : Colors.white.withOpacity(
                        0.39,
                      ),
                borderRadius: BorderRadius.circular(
                  48,
                ),
                border: Border.all(
                  color: Colors.white.withOpacity(
                    0.72,
                  ),
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      ),
      child,
    ],
  );
}

class _DesktopCard
    extends
        StatelessWidget {
  final String quote;
  final bool isPlaying;
  final VoidCallback onPrev, onPlay, onNext;

  const _DesktopCard({required this.quote, required this.isPlaying, required this.onPrev, required this.onPlay, required this.onNext});

  @override
  Widget
  build(
    BuildContext context,
  ) => _GlassCard(
    isPlaying: isPlaying,
    child: LayoutBuilder(
      builder:
          (
            context,
            box,
          ) {
            final h = box.maxHeight;
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left:
                      box.maxWidth *
                      .05,
                  top:
                      h *
                      .17,
                  width:
                      box.maxWidth *
                      .46,
                  child: _ProfileDetails(
                    height: h,
                    quote: quote,
                  ),
                ),
                Positioned(
                  left:
                      box.maxWidth *
                      .40,
                  bottom:
                      -h *
                      .10,
                  height:
                      h *
                      1.03,
                  width:
                      box.maxWidth *
                      .49,
                  child: _buildAssetImage(
                    ProfileContent.portrait,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
                Positioned(
                  left:
                      box.maxWidth *
                      ProfileLayout.waveLeft,
                  top:
                      h *
                      ProfileLayout.waveTop,
                  child: _AudioVisualizer(
                    isPlaying: isPlaying,
                    barHeight: 54,
                  ),
                ),
                Positioned(
                  left:
                      box.maxWidth *
                      ProfileLayout.controlsLeft,
                  top:
                      h *
                      ProfileLayout.controlsTop,
                  width:
                      box.maxWidth *
                      .22,
                  child: _MusicControls(
                    isPlaying: isPlaying,
                    onPrev: onPrev,
                    onPlay: onPlay,
                    onNext: onNext,
                    size: 66,
                  ),
                ),
                Positioned(
                  left:
                      box.maxWidth *
                      ProfileLayout.socialsLeft,
                  bottom:
                      h *
                      ProfileLayout.socialsBottom,
                  child: const _SocialLinks(
                    size: 78,
                  ),
                ),
                Positioned(
                  right:
                      box.maxWidth *
                      ProfileLayout.headphonesRight,
                  bottom:
                      h *
                      ProfileLayout.headphonesBottom,
                  child: _buildAssetImage(
                    ProfileContent.headphones,
                    width: 70,
                    height: 70,
                  ),
                ),
              ],
            );
          },
    ),
  );
}

class _MobileCard
    extends
        StatelessWidget {
  final String quote;
  final bool isPlaying;
  final VoidCallback onPrev, onPlay, onNext;

  const _MobileCard({required this.quote, required this.isPlaying, required this.onPrev, required this.onPlay, required this.onNext});

  @override
  Widget
  build(
    BuildContext context,
  ) => _GlassCard(
    isPlaying: isPlaying,
    child: LayoutBuilder(
      builder:
          (
            context,
            box,
          ) {
            final height = box.maxHeight;
            final width = box.maxWidth;
            return Stack(
              clipBehavior: Clip.none,
              children: [
                // FOTO PROFIL (Digeser lebih ke kanan dan lebih transparan agar tidak menutupi teks)
                Positioned(
                  right:
                      -width *
                      0.35,
                  bottom: -20,
                  height:
                      height *
                      0.85,
                  child: Opacity(
                    opacity: 0.65,
                    child: _buildAssetImage(
                      ProfileContent.portrait,
                      alignment: Alignment.bottomRight,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    24,
                    20,
                    20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(
                        flex: 1,
                      ),
                      Text(
                        ProfileContent.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize:
                              (width *
                                      0.1)
                                  .clamp(
                                    24.0,
                                    36.0,
                                  ),
                          height: 1.15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text(
                        ProfileContent.email,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(
                          milliseconds: 300,
                        ),
                        child: Text(
                          quote,
                          key: ValueKey(
                            quote,
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            height: 1.4,
                          ),
                        ),
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                      // AUDIO VISUALIZER
                      Align(
                        alignment: Alignment.centerLeft,
                        child: _AudioVisualizer(
                          isPlaying: isPlaying,
                          barHeight: 32,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      // MUSIC CONTROLS (Ukurannya dikecilkan khusus Mobile)
                      SizedBox(
                        width: 150,
                        child: _MusicControls(
                          isPlaying: isPlaying,
                          onPrev: onPrev,
                          onPlay: onPlay,
                          onNext: onNext,
                          size: 44,
                        ),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      // SOCIAL LINKS (Ukurannya dikecilkan khusus Mobile)
                      const _SocialLinks(
                        size: 46,
                      ),
                    ],
                  ),
                ),
                // HEADPHONE ICON
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: Opacity(
                    opacity: 0.3,
                    child: _buildAssetImage(
                      ProfileContent.headphones,
                      width: 32,
                      height: 32,
                    ),
                  ),
                ),
              ],
            );
          },
    ),
  );
}

class _ProfileDetails
    extends
        StatelessWidget {
  final double height;
  final String quote;

  const _ProfileDetails({required this.height, required this.quote});

  @override
  Widget
  build(
    BuildContext context,
  ) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        ProfileContent.name,
        style: TextStyle(
          color: Colors.white,
          fontSize: 64,
          height: 1.18,
          fontWeight: FontWeight.w700,
          letterSpacing: .7,
        ),
      ),
      const SizedBox(
        height: 4,
      ),
      const Text(
        ProfileContent.email,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(
        height:
            height *
            .035,
      ),
      AnimatedSwitcher(
        duration: const Duration(
          milliseconds: 300,
        ),
        transitionBuilder:
            (
              child,
              animation,
            ) => FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position:
                    Tween<
                          Offset
                        >(
                          begin: const Offset(
                            0,
                            0.2,
                          ),
                          end: Offset.zero,
                        )
                        .animate(
                          animation,
                        ),
                child: child,
              ),
            ),
        child: Text(
          quote,
          key: ValueKey(
            quote,
          ),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
  );
}

// ==========================================
// MUSIC CONTROLS (DENGAN PARAMETER SIZE)
// ==========================================
class _MusicControls
    extends
        StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPrev, onPlay, onNext;
  final double size;

  const _MusicControls({required this.isPlaying, required this.onPrev, required this.onPlay, required this.onNext, required this.size});

  @override
  Widget
  build(
    BuildContext context,
  ) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      HoverScale(
        onTap: onPrev,
        child: _buildAssetImage(
          ProfileContent.previous,
          width:
              size *
              1.1,
          height: size,
        ),
      ),
      HoverScale(
        onTap: onPlay,
        child: AnimatedContainer(
          duration: const Duration(
            milliseconds: 300,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: isPlaying
                ? [
                    const BoxShadow(
                      color: Color(
                        0x66E8002D,
                      ),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ]
                : [],
          ),
          child: Image.asset(
            ProfileContent.play,
            width: size,
            height: size,
            color: isPlaying
                ? const Color(
                    0xFFE8002D,
                  )
                : null,
          ),
        ),
      ),
      HoverScale(
        onTap: onNext,
        child: _buildAssetImage(
          ProfileContent.next,
          width:
              size *
              1.1,
          height: size,
        ),
      ),
    ],
  );
}

// ==========================================
// TAUTAN SOSIAL MEDIA (DENGAN PARAMETER SIZE)
// ==========================================
class _SocialLinks
    extends
        StatelessWidget {
  final double size;

  const _SocialLinks({required this.size});

  Future<
    void
  >
  _launchUrl(
    String urlString,
  ) async {
    final Uri url = Uri.parse(
      urlString,
    );
    if (!await launchUrl(
      url,
    )) {
      debugPrint(
        'Could not launch $url',
      );
    }
  }

  @override
  Widget
  build(
    BuildContext context,
  ) => Row(
    children: [
      _SocialIcon(
        asset: ProfileContent.instagram,
        size: size,
        onTap: () => _launchUrl(
          'https://www.instagram.com/l.qushai_/',
        ),
      ),
      SizedBox(
        width:
            size *
            0.35,
      ),
      _SocialIcon(
        asset: ProfileContent.tiktok,
        size:
            size *
            0.95, // Sedikit lebih kecil menyesuaikan proporsi aslinya
        onTap: () => _launchUrl(
          'https://www.tiktok.com/@ray_mond_ay',
        ),
      ),
      SizedBox(
        width:
            size *
            0.35,
      ),
      _SocialIcon(
        asset: ProfileContent.github,
        size:
            size *
            0.95, // Sedikit lebih kecil menyesuaikan proporsi aslinya
        onTap: () => _launchUrl(
          'https://github.com/leeviray',
        ),
      ),
    ],
  );
}

class _SocialIcon
    extends
        StatelessWidget {
  final String asset;
  final double size;
  final VoidCallback? onTap;

  const _SocialIcon({required this.asset, required this.size, this.onTap});

  @override
  Widget
  build(
    BuildContext context,
  ) => HoverScale(
    onTap: onTap,
    child: _buildAssetImage(
      asset,
      width: size,
      height: size,
    ),
  );
}

Widget
_buildAssetImage(
  String assetPath, {
  double? width,
  double? height,
  Alignment alignment = Alignment.center,
}) {
  return Image.asset(
    assetPath,
    width: width,
    height: height,
    fit: BoxFit.contain,
    alignment: alignment,
    errorBuilder:
        (
          context,
          error,
          stackTrace,
        ) => Container(
          width:
              width ??
              40,
          height:
              height ??
              40,
          color: Colors.white10,
          child: const Icon(
            Icons.image_not_supported,
            color: Colors.white38,
          ),
        ),
  );
}

// ==========================================
// WIDGET AUDIO VISUALIZER
// ==========================================
class _AudioVisualizer
    extends
        StatefulWidget {
  final bool isPlaying;
  final double barHeight;

  const _AudioVisualizer({required this.isPlaying, required this.barHeight});

  @override
  State<
    _AudioVisualizer
  >
  createState() => _AudioVisualizerState();
}

class _AudioVisualizerState
    extends
        State<
          _AudioVisualizer
        >
    with
        TickerProviderStateMixin {
  late List<
    AnimationController
  >
  _controllers;
  late List<
    Animation<
      double
    >
  >
  _animations;

  @override
  void initState() {
    super.initState();
    final random = math.Random();
    _controllers = List.generate(
      5,
      (
        index,
      ) {
        return AnimationController(
          vsync: this,
          duration: Duration(
            milliseconds:
                250 +
                random.nextInt(
                  250,
                ),
          ),
        );
      },
    );

    _animations = _controllers
        .map(
          (
            c,
          ) =>
              Tween<
                    double
                  >(
                    begin: 0.2,
                    end: 1.0,
                  )
                  .animate(
                    CurvedAnimation(
                      parent: c,
                      curve: Curves.easeInOut,
                    ),
                  ),
        )
        .toList();

    if (widget.isPlaying) {
      _startAnimating();
    }
  }

  void _startAnimating() {
    for (var c in _controllers) {
      c.repeat(
        reverse: true,
      );
    }
  }

  void _stopAnimating() {
    for (var c in _controllers) {
      c.animateTo(
        0.2,
        duration: const Duration(
          milliseconds: 400,
        ),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void didUpdateWidget(
    _AudioVisualizer oldWidget,
  ) {
    super.didUpdateWidget(
      oldWidget,
    );
    if (widget.isPlaying !=
        oldWidget.isPlaying) {
      if (widget.isPlaying) {
        _startAnimating();
      } else {
        _stopAnimating();
      }
    }
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
      height: widget.barHeight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(
          5,
          (
            index,
          ) {
            return AnimatedBuilder(
              animation: _animations[index],
              builder:
                  (
                    context,
                    child,
                  ) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 2.5,
                      ),
                      width: 6,
                      height:
                          widget.barHeight *
                          _animations[index].value,
                      decoration: BoxDecoration(
                        color: widget.isPlaying
                            ? const Color(
                                0xFFE8002D,
                              )
                            : Colors.white.withOpacity(
                                0.5,
                              ),
                        borderRadius: BorderRadius.circular(
                          3,
                        ),
                        boxShadow: widget.isPlaying
                            ? [
                                const BoxShadow(
                                  color: Color(
                                    0x66E8002D,
                                  ),
                                  blurRadius: 4,
                                  spreadRadius: 1,
                                ),
                              ]
                            : [],
                      ),
                    );
                  },
            );
          },
        ),
      ),
    );
  }
}
