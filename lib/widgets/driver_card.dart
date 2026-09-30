import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drayve/models/statistik.dart';
import 'package:drayve/pages/driver_detail_page.dart';

class DriverCard
    extends
        StatelessWidget {
  final Statistik driver;
  final bool isFavorite; // BARU: Status apakah bintang menyala
  final VoidCallback onFavoriteToggle; // BARU: Fungsi saat bintang diklik

  const DriverCard({super.key, required this.driver, required this.isFavorite, required this.onFavoriteToggle});

  // Fungsi untuk gradasi warna tim
  LinearGradient _getTeamGradient(
    String teamName,
  ) {
    Color color1;
    Color color2;

    if (teamName.toLowerCase().contains(
      'ferrari',
    )) {
      color1 = const Color(
        0xFFE8002D,
      );
      color2 = const Color(
        0xFF7A0018,
      );
    } else if (teamName.toLowerCase().contains(
      'mercedes',
    )) {
      color1 = const Color(
        0xFF00A19B,
      );
      color2 = const Color(
        0xFF004D4A,
      );
    } else if (teamName.toLowerCase().contains(
      'mclaren',
    )) {
      color1 = const Color(
        0xFFFF8000,
      );
      color2 = const Color(
        0xFF804000,
      );
    } else if (teamName.toLowerCase().contains(
      'red bull',
    )) {
      color1 = const Color(
        0xFF152A72,
      );
      color2 = const Color(
        0xFF0A1539,
      );
    } else if (teamName.toLowerCase().contains(
      'aston',
    )) {
      color1 = const Color(
        0xFF229971,
      );
      color2 = const Color(
        0xFF0E4C38,
      );
    } else if (teamName.toLowerCase().contains(
      'williams',
    )) {
      color1 = const Color(
        0xFF005AFF,
      );
      color2 = const Color(
        0xFF002D80,
      );
    } else if (teamName.toLowerCase().contains(
      'audi',
    )) {
      color1 = const Color(
        0xFFE20514,
      );
      color2 = const Color(
        0xFF71020A,
      );
    } else if (teamName.toLowerCase().contains(
      'haas',
    )) {
      color1 = const Color(
        0xFFB6BABD,
      );
      color2 = const Color(
        0xFF5B5D5E,
      );
    } else if (teamName.toLowerCase().contains(
      'alpine',
    )) {
      color1 = const Color(
        0xFFFF90C3,
      );
      color2 = const Color(
        0xFF804861,
      );
    } else if (teamName.toLowerCase().contains(
      'racing bulls',
    )) {
      color1 = const Color(
        0xFF6692FF,
      );
      color2 = const Color(
        0xFF334980,
      );
    } else if (teamName.toLowerCase().contains(
      'cadillac',
    )) {
      color1 = const Color(
        0xFFD4A373,
      );
      color2 = const Color(
        0xFF6A5139,
      );
    } else {
      color1 = const Color(
        0xFF2A2D34,
      );
      color2 = const Color(
        0xFF000000,
      );
    }

    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        color1,
        color2,
      ],
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (
                  context,
                ) => DriverDetailPage(
                  driver: driver,
                ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(
        20,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            20,
          ),
          gradient: _getTeamGradient(
            driver.tim,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // --- LAYER 0: Background Pattern ---
            Positioned(
              top: 0,
              right: -900,
              left: -50,
              bottom: -50,
              child: Opacity(
                opacity: 0.15,
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Image.asset(
                    'assets/images/pattern.png',
                    fit: BoxFit.cover,
                    errorBuilder: (
                      context,
                      error,
                      stackTrace,
                    ) => const SizedBox(),
                  ),
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
            // --- LAYER 3: Teks Utama ---
            Positioned(
              top: 24,
              left: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    driver.nama
                        .split(
                          ' ',
                        )
                        .first,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      height: 1.1,
                    ),
                  ),
                  Text(
                    driver.nama
                                .split(
                                  ' ',
                                )
                                .length >
                            1
                        ? driver.nama
                              .split(
                                ' ',
                              )
                              .last
                        : '',
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
                  Text(
                    driver.tim,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    driver.nomorMobil.toString(),
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
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
                decoration: const BoxDecoration(
                  color: Color(
                    0xFFD9D9D9,
                  ),
                  shape: BoxShape.circle,
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  'assets/images/flags/${driver.negara.toLowerCase()}.png',
                  fit: BoxFit.cover,
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
            // --- LAYER 5: TOMBOL BINTANG FAVORITE ---
            Positioned(
              bottom: 16,
              right: 16, // <--- Ubah 'left: 16' menjadi 'right: 16' di baris ini
              child: GestureDetector(
                onTap: onFavoriteToggle,
                child: Container(
                  padding: const EdgeInsets.all(
                    8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(
                      0.5,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isFavorite
                        ? Icons.star
                        : Icons.star_border,
                    color: isFavorite
                        ? Colors.amber
                        : Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
