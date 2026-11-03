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

// ==========================================
// DATA ANGGOTA TIM (5 ORANG)
// Ganti nama, email, foto, quote & link sosmed teman-teman di sini.
// Foto teman taruh di folder assets/images/ (contoh: friend1.webp)
// ==========================================
class TeamMember {
  final String name;
  final String email;
  final String portrait;
  final String quote;
  final String instagram;
  final String tiktok;
  final String github;

  const TeamMember({required this.name, required this.email, required this.portrait, required this.quote, this.instagram = '', this.tiktok = '', this.github = ''});
}

const List<
  TeamMember
>
teamMembers = [
  TeamMember(
    name: ProfileContent.name,
    email: ProfileContent.email,
    portrait: ProfileContent.portrait,
    quote: '“Orang Biasa Masih Butuh Banyak Belajar”',
    instagram: 'https://www.instagram.com/l.qushai_/',
    tiktok: 'https://www.tiktok.com/@ray_mond_ay',
    github: 'https://github.com/leeviray',
  ),
  TeamMember(
    name: 'AKMAL PRIYATAMA\nFADILAH RAMDHAN',
    email: '25051204410@mhs.unesa.ac.id',
    portrait: 'assets/images/friend1.webp',
    quote: '“FORZA KIMIII”',
    instagram: 'https://www.instagram.com/faadills?vrfl=MWxmYmZkcGdvODY0bw==',
    tiktok: 'https://www.tiktok.com/@fadillz67',
    github: 'https://github.com/fadilsss-ai',
  ),
  TeamMember(
    name: 'NAMA TEMAN\nKEDUA', //GANTI INI REK
    email: 'teman2@mhs.unesa.ac.id', //GANTI INI REK
    portrait: 'assets/images/friend2.webp', //PASTIKAN FOTONYA SUDAH FOTOMU YA
    quote: '“Life is a choice”', //GANTI INI REK
    instagram: 'https://www.instagram.com/l.qushai_/', //GANTI INI REK
    tiktok: 'https://www.tiktok.com/@ray_mond_ay', //GANTI INI REK
    github: 'https://github.com/leeviray', //GANTI INI REK
  ),
  TeamMember(
    name: 'NAMA TEMAN\nKETIGA', //GANTI INI REK
    email: 'teman3@mhs.unesa.ac.id', //GANTI INI REK
    portrait: 'assets/images/friend3.webp', //PASTIKAN FOTONYA SUDAH FOTOMU YA
    quote: '“Keep pushing forward”', //GANTI INI REK
    instagram: 'https://www.instagram.com/l.qushai_/', //GANTI INI REK
    tiktok: 'https://www.tiktok.com/@ray_mond_ay', //GANTI INI REK
    github: 'https://github.com/leeviray', //GANTI INI REK
  ),
  TeamMember(
    name: 'NAMA TEMAN\nKEEMPAT', //GANTI INI REK
    email: 'teman4@mhs.unesa.ac.id', //GANTI INI REK
    portrait: 'assets/images/friend4.webp', //PASTIKAN FOTONYA SUDAH FOTOMU YA
    quote: '“Lights out and away we go”', //GANTI INI REK
    instagram: 'https://www.instagram.com/l.qushai_/', //GANTI INI REK
    tiktok: 'https://www.tiktok.com/@ray_mond_ay', //GANTI INI REK
    github: 'https://github.com/leeviray', //GANTI INI REK
  ),
];

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
  int _currentIndex = 0;
  int _direction = 1; // 1 = next (geser ke kiri), -1 = previous (geser ke kanan)
  bool _isPlaying = false;

  void _togglePlay() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _nextTrack() {
    setState(() {
      _direction = 1;
      _currentIndex =
          (_currentIndex +
              1) %
          teamMembers.length;
    });
  }

  void _prevTrack() {
    setState(() {
      _direction = -1;
      _currentIndex =
          (_currentIndex -
              1 +
              teamMembers.length) %
          teamMembers.length;
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final member = teamMembers[_currentIndex];
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
                    child: _AnimatedGradientBackground(
                      index: _currentIndex,
                      isPlaying: _isPlaying,
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
                          member: member,
                          index: _currentIndex,
                          direction: _direction,
                          isPlaying: _isPlaying,
                          onPrev: _prevTrack,
                          onPlay: _togglePlay,
                          onNext: _nextTrack,
                        )
                      : _MobileCard(
                          member: member,
                          index: _currentIndex,
                          direction: _direction,
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

// ==========================================
// ANIMASI GESER (SLIDE) SAAT GANTI ANGGOTA
// ==========================================
class _SlideSwitcher
    extends
        StatelessWidget {
  final int index;
  final int direction;
  final Widget child;
  final double delay; // 0.0 - 0.2, untuk efek stagger
  final double distance; // jarak geser relatif terhadap lebar widget

  const _SlideSwitcher({required this.index, required this.direction, required this.child, this.delay = 0, this.distance = 0.25});

  @override
  Widget build(
    BuildContext context,
  ) {
    final currentKey =
        ValueKey<
          int
        >(
          index,
        );
    return AnimatedSwitcher(
      duration: const Duration(
        milliseconds: 800,
      ),
      layoutBuilder:
          (
            currentChild,
            previousChildren,
          ) => Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topLeft,
            children: [
              ...previousChildren,
              if (currentChild !=
                  null)
                currentChild,
            ],
          ),
      transitionBuilder:
          (
            child,
            animation,
          ) {
            final isIncoming =
                child.key ==
                currentKey;
            // Masuk: sedikit tertunda (stagger) & melambat halus.
            // Keluar: lebih cepat supaya tidak tabrakan dengan yang masuk.
            final curved = CurvedAnimation(
              parent: animation,
              curve: isIncoming
                  ? Interval(
                      0.25 +
                          delay,
                      1,
                      curve: Curves.easeOutQuart,
                    )
                  : const Interval(
                      0.45,
                      1,
                      curve: Curves.easeInCubic,
                    ),
            );
            final offset = Offset(
              (isIncoming
                      ? direction.toDouble()
                      : -direction.toDouble()) *
                  distance,
              0,
            );
            return AnimatedBuilder(
              animation: curved,
              child: child,
              builder:
                  (
                    context,
                    child,
                  ) {
                    final t = curved.value;
                    return FractionalTranslation(
                      translation: Offset.lerp(
                        offset,
                        Offset.zero,
                        t,
                      )!,
                      child: Transform.scale(
                        scale:
                            0.92 +
                            0.08 *
                                t,
                        child: Opacity(
                          opacity: t.clamp(
                            0.0,
                            1.0,
                          ),
                          child: child,
                        ),
                      ),
                    );
                  },
            );
          },
      child: KeyedSubtree(
        key: currentKey,
        child: child,
      ),
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
                        0.08,
                      ),
                borderRadius: BorderRadius.circular(
                  48,
                ),
                border: Border.all(
                  color: Colors.white.withOpacity(
                    0.35,
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
  final TeamMember member;
  final int index;
  final int direction;
  final bool isPlaying;
  final VoidCallback onPrev, onPlay, onNext;

  const _DesktopCard({required this.member, required this.index, required this.direction, required this.isPlaying, required this.onPrev, required this.onPlay, required this.onNext});

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
            final portraitW =
                box.maxWidth *
                .49;
            final portraitH =
                h *
                1.03;
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
                  child: _SlideSwitcher(
                    index: index,
                    direction: direction,
                    child: _ProfileDetails(
                      height: h,
                      member: member,
                    ),
                  ),
                ),
                Positioned(
                  left:
                      box.maxWidth *
                      .40,
                  bottom:
                      -h *
                      .10,
                  height: portraitH,
                  width: portraitW,
                  child: _SlideSwitcher(
                    index: index,
                    direction: direction,
                    delay: 0.12,
                    distance: 0.35,
                    child: SizedBox(
                      width: portraitW,
                      height: portraitH,
                      child: _buildPortrait(
                        member.portrait,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
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
                  child: _SocialLinks(
                    member: member,
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
                  child: _AnimatedHeadphones(
                    isPlaying: isPlaying,
                    size: 70,
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
  final TeamMember member;
  final int index;
  final int direction;
  final bool isPlaying;
  final VoidCallback onPrev, onPlay, onNext;

  const _MobileCard({required this.member, required this.index, required this.direction, required this.isPlaying, required this.onPrev, required this.onPlay, required this.onNext});

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
                  width: width,
                  child: _SlideSwitcher(
                    index: index,
                    direction: direction,
                    delay: 0.12,
                    distance: 0.35,
                    child: SizedBox(
                      width: width,
                      height:
                          height *
                          0.85,
                      child: Opacity(
                        opacity: 0.65,
                        child: _buildPortrait(
                          member.portrait,
                          alignment: Alignment.bottomRight,
                        ),
                      ),
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
                      _SlideSwitcher(
                        index: index,
                        direction: direction,
                        child: SizedBox(
                          width:
                              width -
                              40,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                member.name,
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
                              Text(
                                member.email,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                member.quote,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  height: 1.4,
                                ),
                              ),
                            ],
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
                      _SocialLinks(
                        member: member,
                        size: 46,
                      ),
                    ],
                  ),
                ),
                // HEADPHONE ICON
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: _AnimatedHeadphones(
                    isPlaying: isPlaying,
                    size: 32,
                    opacity: 0.45,
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
  final TeamMember member;

  const _ProfileDetails({required this.height, required this.member});

  @override
  Widget
  build(
    BuildContext context,
  ) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        member.name,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 58,
          height: 1.18,
          fontWeight: FontWeight.w700,
          letterSpacing: .7,
        ),
      ),
      const SizedBox(
        height: 18,
      ),
      Text(
        member.email,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(
        height:
            height *
            .035,
      ),
      Text(
        member.quote,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.w600,
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
  final TeamMember member;
  final double size;

  const _SocialLinks({required this.member, required this.size});

  Future<
    void
  >
  _launchUrl(
    String urlString,
  ) async {
    if (urlString.isEmpty) return;
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
        order: 0,
        trigger: member.name,
        onTap: () => _launchUrl(
          member.instagram,
        ),
      ),
      SizedBox(
        width:
            size *
            0.35,
      ),
      _SocialIcon(
        asset: ProfileContent.tiktok,
        order: 1,
        trigger: member.name,
        size:
            size *
            0.95, // Sedikit lebih kecil menyesuaikan proporsi aslinya
        onTap: () => _launchUrl(
          member.tiktok,
        ),
      ),
      SizedBox(
        width:
            size *
            0.35,
      ),
      _SocialIcon(
        asset: ProfileContent.github,
        order: 2,
        trigger: member.name,
        size:
            size *
            0.95, // Sedikit lebih kecil menyesuaikan proporsi aslinya
        onTap: () => _launchUrl(
          member.github,
        ),
      ),
    ],
  );
}

class _SocialIcon
    extends
        StatefulWidget {
  final String asset;
  final double size;
  final VoidCallback? onTap;
  final int order; // urutan ikon untuk efek stagger
  final String trigger; // berubah => animasi pop diputar ulang

  const _SocialIcon({required this.asset, required this.size, this.onTap, this.order = 0, this.trigger = ''});

  @override
  State<
    _SocialIcon
  >
  createState() => _SocialIconState();
}

class _SocialIconState
    extends
        State<
          _SocialIcon
        >
    with
        TickerProviderStateMixin {
  // Animasi melayang (floating) terus-menerus
  late final AnimationController _float = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 2600,
    ),
  )..repeat();

  // Animasi pop-in saat ganti anggota
  late final AnimationController _pop = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 900,
    ),
  );

  bool _hover = false;

  @override
  void initState() {
    super.initState();
    _playPop();
  }

  void _playPop() {
    _pop.value = 0;
    Future.delayed(
      Duration(
        milliseconds:
            250 +
            widget.order *
                110,
      ),
      () {
        if (mounted) _pop.forward();
      },
    );
  }

  @override
  void didUpdateWidget(
    covariant _SocialIcon oldWidget,
  ) {
    super.didUpdateWidget(
      oldWidget,
    );
    if (oldWidget.trigger !=
        widget.trigger) {
      _playPop();
    }
  }

  @override
  void dispose() {
    _float.dispose();
    _pop.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final popCurve = CurvedAnimation(
      parent: _pop,
      curve: Curves.elasticOut,
    );
    return MouseRegion(
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
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _float,
          _pop,
        ]),
        builder:
            (
              context,
              child,
            ) {
              final phase =
                  _float.value *
                      2 *
                      math.pi +
                  widget.order *
                      1.1;
              final dy =
                  math.sin(
                    phase,
                  ) *
                  widget.size *
                  0.05;
              final pop = popCurve.value;
              return Transform.translate(
                offset: Offset(
                  0,
                  dy,
                ),
                child: Transform.rotate(
                  angle:
                      (1 -
                          pop) *
                      -0.6,
                  child: Transform.scale(
                    scale: pop.clamp(
                      0.0,
                      1.3,
                    ),
                    child: child,
                  ),
                ),
              );
            },
        child: HoverScale(
          onTap: widget.onTap,
          scale: 1.18,
          child: AnimatedContainer(
            duration: const Duration(
              milliseconds: 250,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: _hover
                  ? [
                      BoxShadow(
                        color: Colors.white.withValues(
                          alpha: 0.35,
                        ),
                        blurRadius: 18,
                        spreadRadius: 1,
                      ),
                    ]
                  : [],
            ),
            child: _buildAssetImage(
              widget.asset,
              width: widget.size,
              height: widget.size,
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// IKON HEADPHONE ANIMASI
// Idle: melayang & bergoyang pelan. Playing: berdenyut mengikuti "beat".
// ==========================================
class _AnimatedHeadphones
    extends
        StatefulWidget {
  final bool isPlaying;
  final double size;
  final double opacity;

  const _AnimatedHeadphones({required this.isPlaying, required this.size, this.opacity = 1});

  @override
  State<
    _AnimatedHeadphones
  >
  createState() => _AnimatedHeadphonesState();
}

class _AnimatedHeadphonesState
    extends
        State<
          _AnimatedHeadphones
        >
    with
        TickerProviderStateMixin {
  late final AnimationController _idle = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 3200,
    ),
  )..repeat();

  late final AnimationController _beat = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 460,
    ),
  );

  @override
  void initState() {
    super.initState();
    if (widget.isPlaying) _beat.repeat();
  }

  @override
  void didUpdateWidget(
    covariant _AnimatedHeadphones oldWidget,
  ) {
    super.didUpdateWidget(
      oldWidget,
    );
    if (widget.isPlaying !=
        oldWidget.isPlaying) {
      if (widget.isPlaying) {
        _beat.repeat();
      } else {
        _beat.animateTo(
          0,
          duration: const Duration(
            milliseconds: 300,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _idle.dispose();
    _beat.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return HoverScale(
      scale: 1.15,
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _idle,
          _beat,
        ]),
        builder:
            (
              context,
              child,
            ) {
              final t =
                  _idle.value *
                  2 *
                  math.pi;
              // Denyut: naik cepat lalu turun pelan
              final b = widget.isPlaying
                  ? math
                        .pow(
                          1 -
                              _beat.value,
                          3,
                        )
                        .toDouble()
                  : 0.0;
              return Transform.translate(
                offset: Offset(
                  0,
                  math.sin(
                        t,
                      ) *
                      widget.size *
                      0.06,
                ),
                child: Transform.rotate(
                  angle:
                      math.sin(
                        t *
                            (widget.isPlaying
                                ? 2
                                : 1),
                      ) *
                      (widget.isPlaying
                          ? 0.14
                          : 0.07),
                  child: Transform.scale(
                    scale:
                        1 +
                        b *
                            0.14,
                    child: AnimatedOpacity(
                      duration: const Duration(
                        milliseconds: 400,
                      ),
                      opacity: widget.isPlaying
                          ? 1
                          : widget.opacity,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: widget.isPlaying
                              ? [
                                  BoxShadow(
                                    color:
                                        const Color(
                                          0xFFE8002D,
                                        ).withValues(
                                          alpha:
                                              0.25 +
                                              b *
                                                  0.35,
                                        ),
                                    blurRadius:
                                        16 +
                                        b *
                                            14,
                                    spreadRadius:
                                        b *
                                        4,
                                  ),
                                ]
                              : [],
                        ),
                        child: child,
                      ),
                    ),
                  ),
                ),
              );
            },
        child: _buildAssetImage(
          ProfileContent.headphones,
          width: widget.size,
          height: widget.size,
        ),
      ),
    );
  }
}

// ==========================================
// BACKGROUND GRADIENT ANIMASI (BERGANTI PER ANGGOTA)
// ==========================================
class _GradientPalette {
  final List<
    Color
  >
  colors;
  final Alignment begin;
  final Alignment end;
  final Color blobA;
  final Color blobB;
  final Alignment blobAPos;
  final Alignment blobBPos;

  const _GradientPalette({required this.colors, required this.begin, required this.end, required this.blobA, required this.blobB, required this.blobAPos, required this.blobBPos});
}

const List<
  _GradientPalette
>
_palettes = [
  // 1. F1 Red Night
  _GradientPalette(
    colors: [
      Color(
        0xFF0F0C29,
      ),
      Color(
        0xFF6A0D2B,
      ),
      Color(
        0xFFE8002D,
      ),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    blobA: Color(
      0xFFFF4D6D,
    ),
    blobB: Color(
      0xFF3A0CA3,
    ),
    blobAPos: Alignment(
      0.7,
      -0.6,
    ),
    blobBPos: Alignment(
      -0.8,
      0.7,
    ),
  ),
  // 2. Ocean Neon
  _GradientPalette(
    colors: [
      Color(
        0xFF020024,
      ),
      Color(
        0xFF0A3D91,
      ),
      Color(
        0xFF00D4FF,
      ),
    ],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    blobA: Color(
      0xFF00F5D4,
    ),
    blobB: Color(
      0xFF7209B7,
    ),
    blobAPos: Alignment(
      -0.6,
      -0.7,
    ),
    blobBPos: Alignment(
      0.8,
      0.6,
    ),
  ),
  // 3. Sunset Purple
  _GradientPalette(
    colors: [
      Color(
        0xFF2B1055,
      ),
      Color(
        0xFF7597DE,
      ),
      Color(
        0xFFFF7E5F,
      ),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    blobA: Color(
      0xFFFEB47B,
    ),
    blobB: Color(
      0xFFB5179E,
    ),
    blobAPos: Alignment(
      0.2,
      0.8,
    ),
    blobBPos: Alignment(
      -0.7,
      -0.5,
    ),
  ),
  // 4. Emerald Aurora
  _GradientPalette(
    colors: [
      Color(
        0xFF051937,
      ),
      Color(
        0xFF004D7A,
      ),
      Color(
        0xFF00BF72,
      ),
    ],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    blobA: Color(
      0xFFA8EB12,
    ),
    blobB: Color(
      0xFF008793,
    ),
    blobAPos: Alignment(
      -0.7,
      0.6,
    ),
    blobBPos: Alignment(
      0.7,
      -0.7,
    ),
  ),
  // 5. Papaya Gold
  _GradientPalette(
    colors: [
      Color(
        0xFF1A1A2E,
      ),
      Color(
        0xFFC0392B,
      ),
      Color(
        0xFFFF8000,
      ),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    blobA: Color(
      0xFFFFD166,
    ),
    blobB: Color(
      0xFF8338EC,
    ),
    blobAPos: Alignment(
      0.8,
      0.7,
    ),
    blobBPos: Alignment(
      -0.6,
      -0.8,
    ),
  ),
];

class _AnimatedGradientBackground
    extends
        StatefulWidget {
  final int index;
  final bool isPlaying;

  const _AnimatedGradientBackground({required this.index, required this.isPlaying});

  @override
  State<
    _AnimatedGradientBackground
  >
  createState() => _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState
    extends
        State<
          _AnimatedGradientBackground
        >
    with
        SingleTickerProviderStateMixin {
  // Gerakan blob cahaya yang terus "bernapas"
  late final AnimationController _drift = AnimationController(
    vsync: this,
    duration: const Duration(
      seconds: 14,
    ),
  )..repeat();

  static const _switchDuration = Duration(
    milliseconds: 1200,
  );
  static const _switchCurve = Curves.easeInOutCubic;

  @override
  void dispose() {
    _drift.dispose();
    super.dispose();
  }

  Widget _blob(
    Color color,
    Alignment target,
    double phaseShift,
    double sizeFactor,
  ) {
    return TweenAnimationBuilder<
      Alignment
    >(
      tween: AlignmentTween(
        end: target,
      ),
      duration: _switchDuration,
      curve: _switchCurve,
      builder:
          (
            context,
            base,
            _,
          ) => AnimatedBuilder(
            animation: _drift,
            builder:
                (
                  context,
                  _,
                ) {
                  final t =
                      _drift.value *
                          2 *
                          math.pi +
                      phaseShift;
                  final speed = widget.isPlaying
                      ? 2.0
                      : 1.0;
                  return Align(
                    alignment:
                        base +
                        Alignment(
                          math.sin(
                                t *
                                    speed,
                              ) *
                              0.25,
                          math.cos(
                                t *
                                    speed,
                              ) *
                              0.2,
                        ),
                    child: LayoutBuilder(
                      builder:
                          (
                            context,
                            c,
                          ) {
                            final s =
                                math.max(
                                  c.maxWidth,
                                  c.maxHeight,
                                ) *
                                sizeFactor;
                            return AnimatedContainer(
                              duration: _switchDuration,
                              curve: _switchCurve,
                              width: s,
                              height: s,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    color.withValues(
                                      alpha: 0.75,
                                    ),
                                    color.withValues(
                                      alpha: 0,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                    ),
                  );
                },
          ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final p =
        _palettes[widget.index %
            _palettes.length];
    return Stack(
      fit: StackFit.expand,
      children: [
        AnimatedContainer(
          duration: _switchDuration,
          curve: _switchCurve,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: p.begin,
              end: p.end,
              colors: p.colors,
            ),
          ),
        ),
        _blob(
          p.blobA,
          p.blobAPos,
          0,
          0.75,
        ),
        _blob(
          p.blobB,
          p.blobBPos,
          math.pi,
          0.9,
        ),
        // Lapisan vignette agar teks tetap terbaca
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              radius: 1.2,
              colors: [
                Colors.transparent,
                Color(
                  0x66000000,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
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

// Foto anggota tim (fallback siluet jika foto belum ada)
Widget
_buildPortrait(
  String assetPath, {
  Alignment alignment = Alignment.bottomCenter,
}) {
  return Image.asset(
    assetPath,
    fit: BoxFit.contain,
    alignment: alignment,
    errorBuilder:
        (
          context,
          error,
          stackTrace,
        ) => LayoutBuilder(
          builder:
              (
                context,
                c,
              ) => Align(
                alignment: alignment,
                child: Icon(
                  Icons.person,
                  size: c.maxHeight.isFinite
                      ? c.maxHeight *
                            0.8
                      : 200,
                  color: Colors.white38,
                ),
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
