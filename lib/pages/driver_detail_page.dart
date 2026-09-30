import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drayve/models/statistik.dart';
import 'package:drayve/data/statistikv2.dart';
import 'package:drayve/data/bio_karir.dart';
import 'package:drayve/pages/bio.dart';

import 'latest_post.dart';
import 'discussion.dart';

class DriverDetailPage
    extends
        StatefulWidget {
  final Statistik driver;

  const DriverDetailPage({super.key, required this.driver});

  @override
  State<
    DriverDetailPage
  >
  createState() => _DriverDetailPageState();
}

class _DriverDetailPageState
    extends
        State<
          DriverDetailPage
        > {
  // State untuk menyimpan tab yang sedang aktif
  String _activeTab = 'Statistics';

  // Fungsi gradasi warna tim
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
    bool isMobile =
        MediaQuery.of(
          context,
        ).size.width <
        800;

    List<
      String
    >
    nameParts = widget.driver.nama.split(
      ' ',
    );
    String firstName = nameParts.first;
    String lastName =
        nameParts.length >
            1
        ? nameParts
              .sublist(
                1,
              )
              .join(
                ' ',
              )
        : '';

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // ==========================================
          // 0. LAYER BACKGROUND (ALA LANDING PAGE)
          // ==========================================
          Positioned.fill(
            child: Image.asset(
              'assets/images/bgdong.png',
              fit: BoxFit.cover,
              errorBuilder: (
                context,
                error,
                stackTrace,
              ) => const SizedBox(),
            ),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: 0.15,
              child: Image.asset(
                'assets/images/bgnice.png',
                fit: BoxFit.cover,
                color: Colors.black26,
                colorBlendMode: BlendMode.darken,
                errorBuilder: (
                  context,
                  error,
                  stackTrace,
                ) => const SizedBox(),
              ),
            ),
          ),

          // ==========================================
          // 1. LAYER KONTEN UTAMA
          // ==========================================
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- TOP NAVBAR (SUB-NAVIGATION) ---
              Container(
                color: const Color(
                  0xFF15151E,
                ), // Warna navbar tetap hitam F1 agar kontras
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    child: Row(
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(
                              context,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'BACK',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        if (!isMobile) const Spacer(),

                        Expanded(
                          flex: isMobile
                              ? 1
                              : 0,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                if (isMobile)
                                  const SizedBox(
                                    width: 24,
                                  ),
                                _buildNavTab(
                                  'Statistics',
                                ),
                                _buildNavTab(
                                  'Biography',
                                ),
                                _buildNavTab(
                                  'Latest Post',
                                ),
                                _buildNavTab(
                                  'Discussion',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // --- SCROLLABLE CONTENT (HERO & STATS) ---
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // HERO SECTION
                      Container(
                        height: isMobile
                            ? 650
                            : 500,
                        decoration: BoxDecoration(
                          gradient: _getTeamGradient(
                            widget.driver.tim,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Opacity(
                                opacity: 0.1,
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
                            Positioned(
                              right: isMobile
                                  ? -50
                                  : 50,
                              bottom: -20,
                              child: Text(
                                widget.driver.nomorMobil.toString(),
                                style: GoogleFonts.montserrat(
                                  fontSize: isMobile
                                      ? 300
                                      : 450,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black.withOpacity(
                                    0.1,
                                  ),
                                  height: 1.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 40,
                                left: isMobile
                                    ? 24
                                    : 80,
                                right: isMobile
                                    ? 24
                                    : 80,
                              ),
                              child: isMobile
                                  ? _buildMobileHero(
                                      firstName,
                                      lastName,
                                    )
                                  : _buildDesktopHero(
                                      firstName,
                                      lastName,
                                    ),
                            ),
                          ],
                        ),
                      ),

                      // KONTEN TAB STATISTIK
                      _buildTabContent(
                        isMobile,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- WIDGET UNTUK MEMBANGUN TAB ITEM ---
  Widget _buildNavTab(
    String title,
  ) {
    bool isActive =
        _activeTab ==
        title;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _activeTab = title;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: GoogleFonts.montserrat(
                  color: isActive
                      ? Colors.white
                      : Colors.white54,
                  fontWeight: isActive
                      ? FontWeight.bold
                      : FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Container(
                height: 2,
                width: isActive
                    ? 24
                    : 0,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGET UNTUK MENAMPILKAN KONTEN SESUAI TAB ---
  Widget _buildTabContent(
    bool isMobile,
  ) {
    if (_activeTab ==
        'Biography') {
      return BioTab(
        driverName: widget.driver.nama,
        isMobile: isMobile,
      );
    } else if (_activeTab ==
        'Latest Post') {
      // LatestPostTab sekarang mengurus loginnya sendiri
      return LatestPostTab(
        driverName: widget.driver.nama,
        driverTeam: widget.driver.tim,
        fotoAset: widget.driver.fotoAset,
        isMobile: isMobile,
      );
    } else if (_activeTab ==
        'Discussion') {
      // DiscussionTab sekarang mengurus loginnya sendiri
      return DiscussionTab(
        driverName: widget.driver.nama,
        isMobile: isMobile,
      );
    }

    // --- CARI DATA STATISTIK DARI FILE statistikv2.dart ---
    DriverStatistics? detailStats;
    try {
      detailStats = statistikF1.firstWhere(
        (
          stats,
        ) =>
            stats.name.toLowerCase() ==
            widget.driver.nama.toLowerCase(),
      );
    } catch (
      e
    ) {
      detailStats = null;
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
          if (detailStats ==
              null)
            Center(
              child: Text(
                "Detailed statistics not available for this driver.",
                style: GoogleFonts.montserrat(
                  color: Colors.white54,
                ),
              ),
            )
          else ...[
            Text(
              "STATISTICS",
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
              height: 8,
            ),
            Text(
              "2026 SEASON",
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: isMobile
                    ? 20
                    : 28,
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
                    children: [
                      _buildSeasonStatsColumn(
                        detailStats,
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      _buildCareerStatsColumn(
                        detailStats,
                      ),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: _buildSeasonStatsColumn(
                          detailStats,
                        ),
                      ),
                      const SizedBox(
                        width: 80,
                      ),
                      Expanded(
                        flex: 1,
                        child: _buildCareerStatsColumn(
                          detailStats,
                        ),
                      ),
                    ],
                  ),
          ],
          const SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }

  // --- KOLOM KIRI: SEASON STATS ---
  Widget _buildSeasonStatsColumn(
    DriverStatistics stats,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatRow(
                "Season Position",
                _formatPosition(
                  stats.season2026.seasonPosition,
                ),
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            Expanded(
              child: _buildStatRow(
                "Season Points",
                stats.season2026.seasonPoints.toString(),
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 24.0,
          ),
          child: Divider(
            color: Colors.white24,
            height: 1,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: _buildStatRow(
                "Grand Prix Races",
                stats.season2026.grandPrixRaces.toString(),
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            Expanded(
              child: _buildStatRow(
                "Grand Prix Points",
                stats.season2026.grandPrixPoints.toString(),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          children: [
            Expanded(
              child: _buildStatRow(
                "Grand Prix Wins",
                stats.season2026.grandPrixWins.toString(),
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            Expanded(
              child: _buildStatRow(
                "Grand Prix Podiums",
                stats.season2026.grandPrixPodiums.toString(),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          children: [
            Expanded(
              child: _buildStatRow(
                "Grand Prix Poles",
                stats.season2026.grandPrixPoles.toString(),
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            Expanded(
              child: _buildStatRow(
                "Grand Prix Top 10s",
                stats.season2026.grandPrixTop10s.toString(),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          children: [
            Expanded(
              child: _buildStatRow(
                "DHL Fastest Laps",
                stats.season2026.fastestLaps.toString(),
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            Expanded(
              child: _buildStatRow(
                "DNFs",
                stats.season2026.dnfs.toString(),
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 24.0,
          ),
          child: Divider(
            color: Colors.white24,
            height: 1,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: _buildStatRow(
                "Sprint Races",
                stats.season2026.sprintRaces.toString(),
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            Expanded(
              child: _buildStatRow(
                "Sprint Points",
                stats.season2026.sprintPoints.toString(),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          children: [
            Expanded(
              child: _buildStatRow(
                "Sprint Wins",
                stats.season2026.sprintWins.toString(),
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            Expanded(
              child: _buildStatRow(
                "Sprint Podiums",
                stats.season2026.sprintPodiums.toString(),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          children: [
            Expanded(
              child: _buildStatRow(
                "Sprint Poles",
                stats.season2026.sprintPoles.toString(),
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            Expanded(
              child: _buildStatRow(
                "Sprint Top 10s",
                stats.season2026.sprintTop10s.toString(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // --- KOLOM KANAN: CAREER STATS ---
  Widget _buildCareerStatsColumn(
    DriverStatistics stats,
  ) {
    return Container(
      padding: const EdgeInsets.all(
        32,
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
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "CAREER STATS",
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          _buildCareerRow(
            "Grands Prix Entered",
            stats.career.grandsPrixEntered.toString(),
          ),
          _buildCareerRow(
            "Career Points",
            _formatCareerPoints(
              stats.career.careerPoints,
            ),
          ),
          _buildCareerRow(
            "Highest Race Finish",
            "${stats.career.highestRaceFinish} (x${stats.career.highestRaceFinishCount})",
          ),
          _buildCareerRow(
            "Podiums",
            stats.career.podiums.toString(),
          ),
          _buildCareerRow(
            "Highest Grid Position",
            "${stats.career.highestGridPosition} (x${stats.career.highestGridPositionCount})",
          ),
          _buildCareerRow(
            "Pole Positions",
            stats.career.polePositions.toString(),
          ),
          _buildCareerRow(
            "World Championships",
            stats.career.worldChampionships.toString(),
          ),
          _buildCareerRow(
            "DNFs",
            stats.career.dnfs.toString(),
          ),
        ],
      ),
    );
  }

  // --- Helper Widget: Baris Season Stats ---
  Widget _buildStatRow(
    String label,
    String value,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            color: Colors.white54,
            fontSize: 12,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // --- Helper Widget: Baris Career Stats ---
  Widget _buildCareerRow(
    String label,
    String value,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.montserrat(
                color: Colors.white54,
                fontSize: 14,
              ),
            ),
            Text(
              value,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 16.0,
          ),
          child: Divider(
            color: Colors.white12,
            height: 1,
          ),
        ),
      ],
    );
  }

  // --- Helper Function: Format Angka Posisi ---
  String _formatPosition(
    int pos,
  ) {
    if (pos ==
        0)
      return "-";
    if (pos ==
        1)
      return "1st";
    if (pos ==
        2)
      return "2nd";
    if (pos ==
        3)
      return "3rd";
    return "${pos}th";
  }

  // --- Helper Function: Format Poin ---
  String _formatCareerPoints(
    double points,
  ) {
    if (points ==
        points.roundToDouble()) {
      return points.toInt().toString();
    }
    return points.toString();
  }

  // --- LAYOUT DESKTOP ---
  Widget _buildDesktopHero(
    String firstName,
    String lastName,
  ) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: 900,
            bottom: -400,
            child: Transform.rotate(
              angle: 1.6,
              child: Image.asset(
                widget.driver.fotoMobil,
                height: 1300,
                fit: BoxFit.contain,
                errorBuilder: (
                  context,
                  error,
                  stackTrace,
                ) => const SizedBox(),
              ),
            ),
          ),
          Positioned(
            right: 710,
            bottom: -500,
            child: Transform.rotate(
              angle: 0.0,
              child: Image.asset(
                widget.driver.fotoAset,
                height: 1000,
                fit: BoxFit.contain,
                errorBuilder: (
                  context,
                  error,
                  stackTrace,
                ) => const SizedBox(),
              ),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  firstName,
                  style: GoogleFonts.caveat(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.w400,
                    height: 1.0,
                    shadows: const [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 10.0,
                        offset: Offset(
                          2.0,
                          2.0,
                        ),
                      ),
                      Shadow(
                        color: Colors.black,
                        blurRadius: 25.0,
                        offset: Offset(
                          0.0,
                          0.0,
                        ),
                      ),
                      Shadow(
                        color: Colors.black,
                        blurRadius: 40.0,
                        offset: Offset(
                          0.0,
                          0.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  lastName.toUpperCase(),
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 72,
                    fontWeight: FontWeight.w900,
                    height: 1.0,
                    shadows: const [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 10.0,
                        offset: Offset(
                          3.0,
                          3.0,
                        ),
                      ),
                      Shadow(
                        color: Colors.black,
                        blurRadius: 30.0,
                        offset: Offset(
                          0.0,
                          0.0,
                        ),
                      ),
                      Shadow(
                        color: Colors.black,
                        blurRadius: 50.0,
                        offset: Offset(
                          0.0,
                          0.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(
                              0.9,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                            offset: const Offset(
                              2.0,
                              2.0,
                            ),
                          ),
                        ],
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(
                        'assets/images/flags/${widget.driver.negara}.png',
                        fit: BoxFit.cover,
                        errorBuilder:
                            (
                              context,
                              error,
                              stackTrace,
                            ) => const Icon(
                              Icons.flag,
                              size: 16,
                              color: Colors.white,
                            ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      "${widget.driver.negara[0].toUpperCase()}${widget.driver.negara.substring(1)}  |  ${widget.driver.tim}  |  ${widget.driver.nomorMobil}",
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        shadows: const [
                          Shadow(
                            color: Colors.black,
                            blurRadius: 8.0,
                            offset: Offset(
                              2.0,
                              2.0,
                            ),
                          ),
                          Shadow(
                            color: Colors.black,
                            blurRadius: 20.0,
                            offset: Offset(
                              0.0,
                              0.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- LAYOUT MOBILE ---
  Widget _buildMobileHero(
    String firstName,
    String lastName,
  ) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          bottom: 0,
          right: -20,
          left: -20,
          child: SizedBox(
            height: 350,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  right: 90,
                  bottom: 20,
                  child: Transform.rotate(
                    angle: -0.1,
                    child: Image.asset(
                      widget.driver.fotoMobil,
                      height: 140,
                      fit: BoxFit.contain,
                      errorBuilder: (
                        context,
                        error,
                        stackTrace,
                      ) => const SizedBox(),
                    ),
                  ),
                ),
                Positioned(
                  right: -10,
                  bottom: -10,
                  child: Transform.rotate(
                    angle: 0.0,
                    child: Image.asset(
                      widget.driver.fotoAset,
                      height: 380,
                      fit: BoxFit.contain,
                      errorBuilder: (
                        context,
                        error,
                        stackTrace,
                      ) => const SizedBox(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              firstName,
              style: GoogleFonts.caveat(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.w400,
                height: 1.0,
                shadows: const [
                  Shadow(
                    color: Colors.black,
                    blurRadius: 8.0,
                    offset: Offset(
                      1.0,
                      1.0,
                    ),
                  ),
                  Shadow(
                    color: Colors.black,
                    blurRadius: 20.0,
                    offset: Offset(
                      0.0,
                      0.0,
                    ),
                  ),
                  Shadow(
                    color: Colors.black,
                    blurRadius: 30.0,
                    offset: Offset(
                      0.0,
                      0.0,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              lastName.toUpperCase(),
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.w900,
                height: 1.0,
                shadows: const [
                  Shadow(
                    color: Colors.black,
                    blurRadius: 10.0,
                    offset: Offset(
                      2.0,
                      2.0,
                    ),
                  ),
                  Shadow(
                    color: Colors.black,
                    blurRadius: 25.0,
                    offset: Offset(
                      0.0,
                      0.0,
                    ),
                  ),
                  Shadow(
                    color: Colors.black,
                    blurRadius: 40.0,
                    offset: Offset(
                      0.0,
                      0.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                          0.9,
                        ),
                        blurRadius: 8.0,
                        spreadRadius: 1.0,
                        offset: const Offset(
                          1.0,
                          1.0,
                        ),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    'assets/images/flags/${widget.driver.negara}.png',
                    fit: BoxFit.cover,
                    errorBuilder: (
                      context,
                      error,
                      stackTrace,
                    ) => const SizedBox(),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "${widget.driver.negara[0].toUpperCase()}${widget.driver.negara.substring(1)} | ${widget.driver.tim}",
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    shadows: const [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 5.0,
                        offset: Offset(
                          1.0,
                          1.0,
                        ),
                      ),
                      Shadow(
                        color: Colors.black,
                        blurRadius: 15.0,
                        offset: Offset(
                          0.0,
                          0.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
