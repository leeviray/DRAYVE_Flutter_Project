import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ==========================================
// DATA & LAYOUT PROFIL (DARI REFERENSI BARU)
// ==========================================
class ProfileContent {
  static const name = 'LEEVI QUSHAI\nRAY IFTIKHAR';
  static const email = '25051204390@mhs.unesa.ac.id';
  static const quote = '“Orang Biasa Masih Butuh Banyak Belajar”';

  static const background = 'assets/images/background.png';
  static const portrait = 'assets/images/profile_cutout.png';
  static const musicWave = 'assets/icons/arcticons_music-party.png';
  static const previous = 'assets/icons/arcticons_music-speed-changer-1.png';
  static const play = 'assets/icons/arcticons_booming-music.png';
  static const next = 'assets/icons/arcticons_music-speed-changer.png';
  static const instagram = 'assets/icons/cib_instagram.png';
  static const tiktok = 'assets/icons/streamline-flex_tiktok-solid.png';
  static const github = 'assets/icons/fa-brands_github-square.png';
  static const headphones = 'assets/icons/arcticons_google-music.png';
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
        // ==========================================
        // 1. BAGIAN: TENTANG APLIKASI
        // ==========================================
        const SizedBox(
          height: 40,
        ),
        const Text(
          "DRAYVE",
          style: TextStyle(
            fontFamily: 'MagnetoBold',
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

        // ==========================================
        // 2. BAGIAN: TENTANG PEMBUAT (CREATED BY)
        // ==========================================
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

        // KARTU GLASSMORPHISM PROFIL
        LayoutBuilder(
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
                      : 700,
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
                              color: Colors.black.withValues(
                                alpha: .12,
                              ),
                            ),
                          ),
                        ),
                      ),
                      isWide
                          ? const _DesktopCard()
                          : const _MobileCard(),
                    ],
                  ),
                );
              },
        ),

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
// WIDGET-WIDGET PENDUKUNG (KLONING DARI SUMBER)
// ==========================================
class _GlassCard
    extends
        StatelessWidget {
  const _GlassCard({required this.child});
  final Widget child;

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
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(
                  alpha: .39,
                ),
                borderRadius: BorderRadius.circular(
                  48,
                ),
                border: Border.all(
                  color: Colors.white.withValues(
                    alpha: .72,
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
  const _DesktopCard();

  @override
  Widget
  build(
    BuildContext context,
  ) => _GlassCard(
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
                  child: _buildAssetImage(
                    ProfileContent.musicWave,
                    width: 76,
                    height: 54,
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
                  child: const _MusicControls(),
                ),
                Positioned(
                  left:
                      box.maxWidth *
                      ProfileLayout.socialsLeft,
                  bottom:
                      h *
                      ProfileLayout.socialsBottom,
                  child: const _SocialLinks(),
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
  const _MobileCard();

  @override
  Widget
  build(
    BuildContext context,
  ) => _GlassCard(
    child: LayoutBuilder(
      builder:
          (
            context,
            box,
          ) {
            final height = box.maxHeight;
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  right:
                      -box.maxWidth *
                      .18,
                  top:
                      height *
                      .16,
                  bottom:
                      height *
                      .18,
                  width:
                      box.maxWidth *
                      .83,
                  child: Opacity(
                    opacity: .95,
                    child: _buildAssetImage(
                      ProfileContent.portrait,
                      alignment: Alignment.bottomRight,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    24,
                    28,
                    24,
                    24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(
                        flex: 4,
                      ),
                      Text(
                        ProfileContent.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize:
                              (box.maxWidth *
                                      .11)
                                  .clamp(
                                    32,
                                    64,
                                  ),
                          height: 1.15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        ProfileContent.email,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Text(
                        ProfileContent.quote,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: _buildAssetImage(
                          ProfileContent.musicWave,
                          width: 62,
                          height: 44,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const SizedBox(
                        width: 205,
                        child: _MusicControls(),
                      ),
                      const Spacer(
                        flex: 3,
                      ),
                      const _SocialLinks(),
                      const SizedBox(
                        height: 4,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 14,
                  bottom: 14,
                  child: _buildAssetImage(
                    ProfileContent.headphones,
                    width: 44,
                    height: 44,
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
  const _ProfileDetails({required this.height});
  final double height;

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
      const Text(
        ProfileContent.quote,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}

class _MusicControls
    extends
        StatelessWidget {
  const _MusicControls();

  @override
  Widget
  build(
    BuildContext context,
  ) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      _buildAssetImage(
        ProfileContent.previous,
        width: 72,
        height: 64,
      ),
      _buildAssetImage(
        ProfileContent.play,
        width: 66,
        height: 66,
      ),
      _buildAssetImage(
        ProfileContent.next,
        width: 72,
        height: 64,
      ),
    ],
  );
}

class _SocialLinks
    extends
        StatelessWidget {
  const _SocialLinks();

  @override
  Widget
  build(
    BuildContext context,
  ) => Row(
    children: [
      _SocialIcon(
        asset: ProfileContent.instagram,
        size: 82,
      ),
      const SizedBox(
        width: 30,
      ),
      _SocialIcon(
        asset: ProfileContent.tiktok,
        size: 78,
      ),
      const SizedBox(
        width: 30,
      ),
      _SocialIcon(
        asset: ProfileContent.github,
        size: 78,
      ),
    ],
  );
}

class _SocialIcon
    extends
        StatelessWidget {
  const _SocialIcon({required this.asset, required this.size});
  final String asset;
  final double size;

  @override
  Widget
  build(
    BuildContext context,
  ) => _buildAssetImage(
    asset,
    width: size,
    height: size,
  );
}

// Fungsi pembantu agar aplikasi tidak crash jika aset belum di-copy ke folder
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
