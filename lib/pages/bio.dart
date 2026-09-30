import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drayve/data/bio_karir.dart';

class BioTab
    extends
        StatelessWidget {
  final String driverName;
  final bool isMobile;

  const BioTab({super.key, required this.driverName, required this.isMobile});

  @override
  Widget build(
    BuildContext context,
  ) {
    DriverBio? bioData;
    try {
      bioData = bioKarir.firstWhere(
        (
          bio,
        ) =>
            bio.name.toLowerCase() ==
            driverName.toLowerCase(),
      );
    } catch (
      e
    ) {
      bioData = null;
    }

    if (bioData ==
        null) {
      return Padding(
        padding: const EdgeInsets.all(
          80.0,
        ),
        child: Center(
          child: Text(
            "Biography not available for this driver.",
            style: GoogleFonts.montserrat(
              color: Colors.white54,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile
            ? 24.0
            : 80.0,
        vertical: 40.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "BIOGRAPHY",
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: isMobile
                  ? 32
                  : 48,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(
            height: 48,
          ),
          isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBioInfoLeft(
                      bioData,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    _buildBioTextRight(
                      bioData,
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: _buildBioInfoLeft(
                        bioData,
                      ),
                    ),
                    const SizedBox(
                      width: 80,
                    ),
                    Expanded(
                      flex: 2,
                      child: _buildBioTextRight(
                        bioData,
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

Widget _buildBioInfoLeft(DriverBio bio) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Date of Birth", style: GoogleFonts.montserrat(color: Colors.white54, fontSize: 12)),
                  const SizedBox(height: 8),
                  Text(bio.dateOfBirth, style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Place of Birth", style: GoogleFonts.montserrat(color: Colors.white54, fontSize: 12)),
                  const SizedBox(height: 8),
                  Text(bio.placeOfBirth, style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        // FOTO DARI INTERNET (Mengikuti ukuran asli gambar)
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            "https://picsum.photos/seed/${bio.name.replaceAll(' ', '')}/400/500",
            // Batasan ukuran dihapus agar gambar merender sesuai dimensi aslinya
            errorBuilder: (context, error, stackTrace) => Container(
              height: 350,
              width: double.infinity,
              color: Colors.white10,
              child: const Icon(Icons.broken_image, color: Colors.white54, size: 48),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBioTextRight(DriverBio bio) {
    // TEXT BOX GELAP
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF15151E).withAlpha(230),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            bio.biography,
            // UKURAN TEKS DINAIKKAN MENJADI 16
            style: GoogleFonts.montserrat(color: Colors.white.withAlpha(200), fontSize: 16, height: 1.8),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 40),
          Text(
            '"',
            style: GoogleFonts.montserrat(color: const Color(0xFFE8002D), fontSize: 80, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic, height: 0.5),
          ),
          Text(
            "ON ${bio.name.split(' ').first.toUpperCase()}, YOU CAN RELY ON HIM WHEN IT COMES TO LAP TIMES AND RACING, SO SPIRITS ARE HIGH.",
            style: GoogleFonts.montserrat(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic, letterSpacing: 1.0, height: 1.2),
          ),
          const SizedBox(height: 16),
          Text("Toto Wolff", style: GoogleFonts.montserrat(color: Colors.white54, fontSize: 14)),
        ],
      ),
    );
  }
}
