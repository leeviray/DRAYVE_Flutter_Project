import 'dart:math'
    as math;
import 'dart:ui'
    as ui;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drayve/data/f1_teams.dart';
import 'package:drayve/widgets/drayve_page_route.dart';
import 'package:drayve/widgets/interactive.dart';
import 'package:drayve/services/api_services.dart'; // IMPORT API SERVICE

const Color
_kRed = Color(
  0xFFE10600,
);

/// Warna gelap & terang untuk gradien banner (meniru tampilan web F1).
Color
_darken(
  Color c, [
  double factor = 0.42,
]) {
  final hsl = HSLColor.fromColor(
    c,
  );
  return hsl
      .withLightness(
        (hsl.lightness *
                factor)
            .clamp(
              0.0,
              1.0,
            ),
      )
      .withSaturation(
        (hsl.saturation *
                0.95)
            .clamp(
              0.0,
              1.0,
            ),
      )
      .toColor();
}

Color
_lighten(
  Color c, [
  double amount = 0.12,
]) {
  final hsl = HSLColor.fromColor(
    c,
  );
  return hsl
      .withLightness(
        (hsl.lightness +
                (1 -
                        hsl.lightness) *
                    amount)
            .clamp(
              0.0,
              1.0,
            ),
      )
      .toColor();
}

/// Halaman daftar tim (ditampilkan di landing page, tanpa Scaffold).
class TeamsPage
    extends
        StatefulWidget {
  const TeamsPage({super.key});

  @override
  State<
    TeamsPage
  >
  createState() => _TeamsPageState();
}

class _TeamsPageState
    extends
        State<
          TeamsPage
        > {
  Map<
    String,
    int
  >
  livePoints = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchApiData();
  }

  Future<
    void
  >
  _fetchApiData() async {
    final points = await ApiService().getLiveTeamPoints();
    if (mounted) {
      setState(() {
        livePoints = points;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final double width = MediaQuery.of(
      context,
    ).size.width;
    final bool isMobile =
        width <
        800;
    final int crossAxisCount = isMobile
        ? 1
        : 2;
    final double hPadding = isMobile
        ? 20.0
        : 40.0;
    final teams = kF1Teams;

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            hPadding,
            16,
            hPadding,
            8,
          ),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 5,
                      height: isMobile
                          ? 26
                          : 34,
                      color: _kRed,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      'F1 TEAMS 2026',
                      style: GoogleFonts.montserrat(
                        fontSize: isMobile
                            ? 24
                            : 32,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  'Tim Formula 1 musim 2026 (${teams.length} tim)',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            hPadding,
            8,
            hPadding,
            48,
          ),
          sliver: isLoading
              ? const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 100,
                    ),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color(
                          0xFFE10600,
                        ),
                      ),
                    ),
                  ),
                )
              : SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: isMobile
                        ? 16
                        : 24,
                    mainAxisSpacing: isMobile
                        ? 16
                        : 24,
                    childAspectRatio: isMobile
                        ? 2.0
                        : 2.7,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (
                      context,
                      index,
                    ) {
                      final team = teams[index];

                      // CARA MATCHING NAMA API JOLPICA
                      String apiTeamId = team.shortName.toLowerCase().replaceAll(
                        ' ',
                        '_',
                      );
                      if (apiTeamId ==
                          'red_bull_racing')
                        apiTeamId = 'red_bull';
                      if (apiTeamId ==
                          'racing_bulls')
                        apiTeamId = 'rb';
                      if (apiTeamId ==
                          'haas')
                        apiTeamId = 'haas'; // Penyesuaian khusus

                      // Prioritaskan nilai dari API, jika null (seperti cadillac) pakai data lokal
                      int currentPoints =
                          livePoints[apiTeamId] ??
                          team.seasonPoints;

                      return RevealOnce(
                        key: ValueKey(
                          'team_${team.name}',
                        ),
                        id: 'team_card_${team.name}',
                        delay: Duration(
                          milliseconds:
                              (index %
                                  6) *
                              55,
                        ),
                        child: _TeamCard(
                          team: team, // <--- Cukup kirim tim-nya saja ke Card
                          onTap: () =>
                              Navigator.of(
                                context,
                              ).push(
                                DrayvePageRoute(
                                  builder:
                                      (
                                        _,
                                      ) => TeamInfoPage(
                                        team: team,
                                        livePoints: currentPoints, // <--- Poin API dikirim saat buka halaman detail!
                                      ),
                                ),
                              ),
                        ),
                      );
                    },
                    childCount: teams.length,
                  ),
                ),
        ),
      ],
    );
  }
}

class _TeamCard
    extends
        StatefulWidget {
  final F1Team team;
  final VoidCallback onTap;

  const _TeamCard({required this.team, required this.onTap});

  @override
  State<
    _TeamCard
  >
  createState() => _TeamCardState();
}

class _TeamCardState
    extends
        State<
          _TeamCard
        > {
  bool _hovered = false;

  @override
  Widget build(
    BuildContext context,
  ) {
    final team = widget.team;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter:
          (
            _,
          ) => setState(
            () => _hovered = true,
          ),
      onExit:
          (
            _,
          ) => setState(
            () => _hovered = false,
          ),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(
            milliseconds: 220,
          ),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(
            0,
            _hovered
                ? -4
                : 0,
            0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              18,
            ),
            boxShadow: [
              BoxShadow(
                color: team.color.withOpacity(
                  _hovered
                      ? 0.45
                      : 0.15,
                ),
                blurRadius: _hovered
                    ? 28
                    : 14,
                offset: const Offset(
                  0,
                  8,
                ),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              18,
            ),
            child: _TeamBanner(
              team: team,
              hovered: _hovered,
            ),
          ),
        ),
      ),
    );
  }
}

/// Banner tim: gradien warna tim, nama, pembalap, logo, dan mobil.
/// Dipakai di kartu daftar tim maupun header halaman detail.
class _TeamBanner
    extends
        StatelessWidget {
  final F1Team team;
  final bool hovered;
  final bool large;

  const _TeamBanner({required this.team, this.hovered = false, this.large = false});

  @override
  Widget build(
    BuildContext context,
  ) {
    return LayoutBuilder(
      builder:
          (
            context,
            c,
          ) {
            final double w = c.maxWidth;
            final bool compact =
                w <
                420;
            final double pad = compact
                ? 16
                : (large
                      ? 28
                      : 24);
            final double titleSize = compact
                ? 22
                : (large
                      ? 38
                      : 30);
            final double logo = compact
                ? 40
                : (large
                      ? 64
                      : 54);

            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    _darken(
                      team.color,
                    ),
                    _lighten(
                      team.color,
                      0.1,
                    ),
                  ],
                  stops: const [
                    0.0,
                    0.9,
                  ],
                ),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // pola titik (halftone) di belakang mobil
                  Positioned.fill(
                    child: RepaintBoundary(
                      child: CustomPaint(
                        painter: _HalftonePainter(),
                      ),
                    ),
                  ),
                  // mobil
                  Positioned(
                    left:
                        pad *
                        0.6,
                    bottom:
                        pad *
                        0.55,
                    width:
                        w *
                        (compact
                            ? 0.74
                            : 0.66),
                    child: AnimatedSlide(
                      duration: const Duration(
                        milliseconds: 320,
                      ),
                      curve: Curves.easeOutCubic,
                      offset: Offset(
                        hovered
                            ? 0.03
                            : 0,
                        0,
                      ),
                      child: _CarImage(
                        team: team,
                      ),
                    ),
                  ),
                  // logo (lingkaran kode tim)
                  Positioned(
                    top: pad,
                    right: pad,
                    child: Container(
                      width: logo,
                      height: logo,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            _darken(
                              team.color,
                              0.3,
                            ).withOpacity(
                              0.85,
                            ),
                      ),
                      child: Text(
                        team.code,
                        style: GoogleFonts.montserrat(
                          fontSize:
                              logo *
                              0.27,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  // nama tim + pembalap
                  Positioned(
                    top: pad,
                    left: pad,
                    right:
                        pad +
                        logo +
                        12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          team.shortName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.montserrat(
                            fontSize: titleSize,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            height: 1.1,
                          ),
                        ),
                        SizedBox(
                          height: compact
                              ? 8
                              : 10,
                        ),
                        Wrap(
                          spacing: compact
                              ? 12
                              : 18,
                          runSpacing: 6,
                          children: [
                            for (final d in team.drivers)
                              _DriverChip(
                                driver: d,
                                team: team,
                                compact: compact,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
    );
  }
}

class _CarImage
    extends
        StatelessWidget {
  final F1Team team;
  const _CarImage({required this.team});

  @override
  Widget build(
    BuildContext context,
  ) {
    final asset = team.carAsset;
    if (asset ==
        null)
      return const _CarPlaceholder();
    return Image.asset(
      asset,
      fit: BoxFit.contain,
      alignment: Alignment.bottomLeft,
      errorBuilder: (
        _,
        __,
        ___,
      ) => const _CarPlaceholder(),
    );
  }
}

/// Tampil bila gambar mobil belum tersedia.
class _CarPlaceholder
    extends
        StatelessWidget {
  const _CarPlaceholder();

  @override
  Widget build(
    BuildContext context,
  ) {
    return AspectRatio(
      aspectRatio:
          1018 /
          224,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          'Gambar mobil segera hadir',
          style: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white54,
          ),
        ),
      ),
    );
  }
}

class _DriverChip
    extends
        StatelessWidget {
  final F1TeamDriver driver;
  final F1Team team;
  final bool compact;

  const _DriverChip({required this.driver, required this.team, required this.compact});

  @override
  Widget build(
    BuildContext context,
  ) {
    final parts = driver.name.split(
      ' ',
    );
    final first = parts.first;
    final last = parts
        .skip(
          1,
        )
        .join(
          ' ',
        )
        .toUpperCase();
    final double size = compact
        ? 22
        : 28;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _darken(
              team.color,
              0.6,
            ),
          ),
          child: Image.asset(
            driver.imagePath,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            errorBuilder:
                (
                  _,
                  __,
                  ___,
                ) => Center(
                  child: Text(
                    first.isNotEmpty
                        ? first[0]
                        : '?',
                    style: GoogleFonts.montserrat(
                      fontSize:
                          size *
                          0.45,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Flexible(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '$first ',
                  style: GoogleFonts.montserrat(
                    fontSize: compact
                        ? 11
                        : 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: last,
                  style: GoogleFonts.montserrat(
                    fontSize: compact
                        ? 11
                        : 13,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

/// Pola titik halus di bagian bawah banner, memudar ke kanan.
class _HalftonePainter
    extends
        CustomPainter {
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    const double step = 8;
    final double top =
        size.height *
        0.48;
    final paint = Paint()
      ..color = Colors.white.withOpacity(
        0.13,
      );
    for (
      double y = top;
      y <
          size.height;
      y += step
    ) {
      final double vy =
          (y -
              top) /
          (size.height -
              top);
      for (
        double x = 0;
        x <
            size.width *
                0.8;
        x += step
      ) {
        final double t =
            x /
            (size.width *
                0.8);
        final double r =
            1.7 *
            math.pow(
              1 -
                  t,
              1.3,
            ) *
            (0.35 +
                0.65 *
                    vy);
        if (r <
            0.35)
          continue;
        canvas.drawCircle(
          Offset(
            x,
            y,
          ),
          r,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) => false;
}

/// Halaman detail tim (meniru tampilan halaman tim di web resmi F1).
class TeamInfoPage
    extends
        StatelessWidget {
  final F1Team team;
  final int livePoints; // TAMBAHAN PENERIMA POIN DARI API

  const TeamInfoPage({super.key, required this.team, required this.livePoints});

  @override
  Widget build(
    BuildContext context,
  ) {
    final double width = MediaQuery.of(
      context,
    ).size.width;
    final bool isMobile =
        width <
        800;
    final double hPadding = isMobile
        ? 20.0
        : 40.0;
    final Color bg = _darken(
      team.color,
      0.22,
    );
    final Color accent = _lighten(
      team.color,
      0.25,
    );
    final t = team;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.black.withOpacity(
                0.55,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: hPadding,
                vertical: 12,
              ),
              child: Row(
                children: [
                  HoverScale(
                    onTap: () => Navigator.of(
                      context,
                    ).pop(),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 22,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Kembali',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'DRAYVE',
                    style: TextStyle(
                      fontFamily: 'Ethnocentric',
                      fontStyle: FontStyle.italic,
                      fontSize: 22,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _TeamHero(
                      team: team,
                      bg: bg,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        hPadding,
                        36,
                        hPadding,
                        56,
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 1100,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _SectionTitle(
                                'TEAM PROFILE',
                                accent,
                              ),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(
                                  22,
                                ),
                                decoration: _panelDecoration(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      team.description,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        height: 1.7,
                                        color: Colors.white.withOpacity(
                                          0.85,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    _InfoRow(
                                      'Full Team Name',
                                      team.name,
                                    ),
                                    _InfoRow(
                                      'Chassis',
                                      team.chassis,
                                    ),
                                    _InfoRow(
                                      'Power Unit',
                                      team.engineSupplier,
                                      last: true,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              _SectionTitle(
                                'DRIVERS',
                                accent,
                              ),
                              _DriverCards(
                                team: team,
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              _SectionTitle(
                                '2026 SEASON',
                                accent,
                              ),
                              _StatGrid(
                                accent: accent,
                                items: [
                                  _Stat(
                                    'Poin Tim',
                                    '$livePoints',
                                  ), // INI POIN ASLI DARI API!
                                  _Stat(
                                    'Grand Prix',
                                    '${t.gpRaces}',
                                  ),
                                  _Stat(
                                    'Menang',
                                    '${t.gpWins}',
                                  ),
                                  _Stat(
                                    'Podium',
                                    '${t.gpPodiums}',
                                  ),
                                  _Stat(
                                    'Pole',
                                    '${t.gpPoles}',
                                  ),
                                  _Stat(
                                    'Top 10',
                                    '${t.gpTop10s}',
                                  ),
                                  _Stat(
                                    'Fastest Lap',
                                    '${t.fastestLaps}',
                                  ),
                                  _Stat(
                                    'DNF',
                                    '${t.dnfsSeason}',
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              _SectionTitle(
                                'ALL-TIME',
                                accent,
                              ),
                              _StatGrid(
                                accent: accent,
                                items: [
                                  _Stat(
                                    'Grand Prix diikuti',
                                    '${t.grandsPrixEntered}',
                                  ),
                                  _Stat(
                                    'Juara dunia',
                                    '${t.worldChampionships}',
                                  ),
                                  _Stat(
                                    'Podium',
                                    '${t.podiums}',
                                  ),
                                  _Stat(
                                    'Pole position',
                                    '${t.polePositions}',
                                  ),
                                  _Stat(
                                    'Finis terbaik',
                                    t.highestRaceFinish,
                                  ),
                                  _Stat(
                                    'Grid terbaik',
                                    t.highestGridPosition,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Header penuh lebar: gradien warna tim, mobil di tengah, judul di antara
/// dua garis putih miring, dan nama pembalap di tengah bawah.
class _TeamHero
    extends
        StatelessWidget {
  final F1Team team;
  final Color bg;

  const _TeamHero({required this.team, required this.bg});

  @override
  Widget build(
    BuildContext context,
  ) {
    return LayoutBuilder(
      builder:
          (
            context,
            c,
          ) {
            final double w = c.maxWidth;
            final bool isMobile =
                w <
                700;
            final double h = isMobile
                ? w *
                      0.92
                : (w /
                          4.2)
                      .clamp(
                        300.0,
                        560.0,
                      )
                      .toDouble();

            final double carW = isMobile
                ? w *
                      0.92
                : math.min(
                    w *
                        0.48,
                    h *
                        0.5 *
                        4.5,
                  );
            final double carTop =
                h *
                (isMobile
                    ? 0.14
                    : 0.12);

            final double bandTop =
                h *
                (isMobile
                    ? 0.66
                    : 0.76);
            final double bandH =
                h *
                (isMobile
                    ? 0.12
                    : 0.115);
            final double titleSize =
                bandH *
                1.0;
            final double driversTop =
                bandTop +
                bandH +
                h *
                    0.045;

            return SizedBox(
              width: w,
              height: h,
              child: Stack(
                children: [
                  // gradien dasar
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            _lighten(
                              team.color,
                              0.08,
                            ),
                            team.color,
                            _darken(
                              team.color,
                              0.45,
                            ),
                            bg,
                          ],
                          stops: const [
                            0.0,
                            0.58,
                            0.8,
                            1.0,
                          ],
                        ),
                      ),
                    ),
                  ),
                  // pola titik + garis kecepatan
                  Positioned.fill(
                    child: RepaintBoundary(
                      child: CustomPaint(
                        painter: _HeroPatternPainter(
                          _darken(
                            team.color,
                            0.55,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // mobil
                  Positioned(
                    top: carTop,
                    left:
                        (w -
                            carW) /
                        2,
                    width: carW,
                    child: _HeroCar(
                      team: team,
                    ),
                  ),
                  // judul + garis putih
                  Positioned(
                    top: bandTop,
                    left: 0,
                    right: 0,
                    height: bandH,
                    child: Row(
                      children: [
                        const Expanded(
                          child: _StripePainterBox(
                            left: true,
                          ),
                        ),
                        SizedBox(
                          width:
                              w *
                              0.015,
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth:
                                w *
                                (isMobile
                                    ? 0.7
                                    : 0.6),
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              team.shortName.toUpperCase(),
                              maxLines: 1,
                              style: GoogleFonts.montserrat(
                                fontSize: titleSize,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                height: 1.0,
                                letterSpacing: -1,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width:
                              w *
                              0.015,
                        ),
                        const Expanded(
                          child: _StripePainterBox(
                            left: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // nama pembalap
                  Positioned(
                    top: driversTop,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (
                          int i = 0;
                          i <
                              team.drivers.length;
                          i++
                        ) ...[
                          if (i >
                              0)
                            Container(
                              width: 1,
                              height: 20,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              color: Colors.white.withOpacity(
                                0.35,
                              ),
                            ),
                          Text(
                            team.drivers[i].name,
                            style: GoogleFonts.montserrat(
                              fontSize: isMobile
                                  ? 13
                                  : 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
    );
  }
}

class _HeroCar
    extends
        StatelessWidget {
  final F1Team team;
  const _HeroCar({required this.team});

  @override
  Widget build(
    BuildContext context,
  ) {
    final asset = team.carAsset;
    if (asset ==
        null)
      return const _CarPlaceholder();
    return Image.asset(
      asset,
      fit: BoxFit.contain,
      errorBuilder: (
        _,
        __,
        ___,
      ) => const _CarPlaceholder(),
    );
  }
}

/// Dua garis putih dengan ujung miring (kiri atau kanan judul).
class _StripePainterBox
    extends
        StatelessWidget {
  final bool left;
  const _StripePainterBox({required this.left});

  @override
  Widget build(
    BuildContext context,
  ) {
    return CustomPaint(
      painter: _StripePainter(
        left: left,
      ),
      child: const SizedBox.expand(),
    );
  }
}

class _StripePainter
    extends
        CustomPainter {
  final bool left;
  const _StripePainter({required this.left});

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final double h = size.height;
    final double w = size.width;
    final double slant = math.min(
      h *
          0.9,
      w,
    );
    final paint = Paint()..color = Colors.white;

    // x tepi miring pada ketinggian y
    double
    edge(
      double y,
    ) => left
        ? w -
              slant *
                  (y /
                      h)
        : slant *
              (1 -
                  y /
                      h);

    void bar(
      double y0,
      double y1,
    ) {
      final path = Path();
      if (left) {
        path
          ..moveTo(
            0,
            y0,
          )
          ..lineTo(
            edge(
              y0,
            ),
            y0,
          )
          ..lineTo(
            edge(
              y1,
            ),
            y1,
          )
          ..lineTo(
            0,
            y1,
          );
      } else {
        path
          ..moveTo(
            edge(
              y0,
            ),
            y0,
          )
          ..lineTo(
            w,
            y0,
          )
          ..lineTo(
            w,
            y1,
          )
          ..lineTo(
            edge(
              y1,
            ),
            y1,
          );
      }
      path.close();
      canvas.drawPath(
        path,
        paint,
      );
    }

    bar(
      0,
      h *
          0.47,
    );
    bar(
      h *
          0.53,
      h,
    );
  }

  @override
  bool
  shouldRepaint(
    covariant _StripePainter oldDelegate,
  ) =>
      oldDelegate.left !=
      left;
}

/// Pola titik halftone di belakang mobil + garis kecepatan gelap di kanan.
class _HeroPatternPainter
    extends
        CustomPainter {
  final Color color;
  const _HeroPatternPainter(this.color);

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final double w = size.width;
    final double h = size.height;

    // garis kecepatan di kanan mobil
    final streak = Rect.fromLTWH(
      w *
          0.42,
      h *
          0.36,
      w *
          0.55,
      h *
          0.22,
    );
    canvas.drawRect(
      streak,
      Paint()
        ..shader =
            LinearGradient(
              colors: [
                color.withOpacity(
                  0.0,
                ),
                color.withOpacity(
                  0.28,
                ),
                color.withOpacity(
                  0.0,
                ),
              ],
              stops: const [
                0.0,
                0.35,
                1.0,
              ],
            ).createShader(
              streak,
            ),
    );

    // titik halftone, dikelompokkan per ukuran supaya cepat digambar
    const double step = 9;
    final double top =
        h *
        0.12;
    final double bottom =
        h *
        0.74;
    final double mid =
        (top +
            bottom) /
        2;
    final double half =
        (bottom -
            top) /
        2;
    final buckets = List.generate(
      5,
      (
        _,
      ) =>
          <
            Offset
          >[],
    );

    for (
      double y = top;
      y <
          bottom;
      y += step
    ) {
      final double fy =
          1 -
          ((y -
                      mid)
                  .abs() /
              half);
      for (
        double x =
            step /
            2;
        x <
            w;
        x += step
      ) {
        final double fx = math.sin(
          math.pi *
              (x /
                  w),
        );
        final double r =
            2.1 *
            math.pow(
              fx,
              0.9,
            ) *
            math.pow(
              fy,
              0.8,
            );
        if (r <
            0.4)
          continue;
        final int b =
            ((r /
                        2.1) *
                    4.99)
                .floor()
                .clamp(
                  0,
                  4,
                )
                .toInt();
        buckets[b].add(
          Offset(
            x,
            y,
          ),
        );
      }
    }
    for (
      int b = 0;
      b <
          buckets.length;
      b++
    ) {
      final double r =
          2.1 *
          ((b +
                  0.5) /
              5);
      canvas.drawPoints(
        ui.PointMode.points,
        buckets[b],
        Paint()
          ..color = color.withOpacity(
            0.22,
          )
          ..strokeWidth =
              r *
              2
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool
  shouldRepaint(
    covariant _HeroPatternPainter oldDelegate,
  ) =>
      oldDelegate.color !=
      color;
}

BoxDecoration
_panelDecoration({
  double radius = 16,
}) => BoxDecoration(
  color: Colors.white.withOpacity(
    0.06,
  ),
  borderRadius: BorderRadius.circular(
    radius,
  ),
  border: Border.all(
    color: Colors.white.withOpacity(
      0.10,
    ),
  ),
);

class _SectionTitle
    extends
        StatelessWidget {
  final String text;
  final Color accent;
  const _SectionTitle(this.text, this.accent);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 14,
      ),
      child: Row(
        children: [
          Container(
            width: 5,
            height: 22,
            color: accent,
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            text,
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow
    extends
        StatelessWidget {
  final String label;
  final String value;
  final bool last;
  const _InfoRow(this.label, this.value, {this.last = false});

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.white.withOpacity(
              0.10,
            ),
          ),
          bottom: last
              ? BorderSide(
                  color: Colors.white.withOpacity(
                    0.10,
                  ),
                )
              : BorderSide.none,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: GoogleFonts.montserrat(
                fontSize: 13,
                color: Colors.white60,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DriverCards
    extends
        StatelessWidget {
  final F1Team team;
  const _DriverCards({required this.team});

  @override
  Widget build(
    BuildContext context,
  ) {
    return LayoutBuilder(
      builder:
          (
            context,
            c,
          ) {
            final int cols =
                c.maxWidth >=
                    560
                ? 2
                : 1;
            final double cardW =
                (c.maxWidth -
                    16 *
                        (cols -
                            1)) /
                cols;
            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                for (final d in team.drivers)
                  SizedBox(
                    width: cardW,
                    child: Container(
                      padding: const EdgeInsets.all(
                        16,
                      ),
                      decoration: _panelDecoration(),
                      child: Row(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _darken(
                                team.color,
                                0.6,
                              ),
                            ),
                            child: Image.asset(
                              d.imagePath,
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                              errorBuilder:
                                  (
                                    _,
                                    __,
                                    ___,
                                  ) => Center(
                                    child: Text(
                                      d.name.isNotEmpty
                                          ? d.name[0]
                                          : '?',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '#${d.number}',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w900,
                                    color: _lighten(
                                      team.color,
                                      0.3,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  d.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          },
    );
  }
}

class _Stat {
  final String label;
  final String value;
  const _Stat(this.label, this.value);
}

class _StatGrid
    extends
        StatelessWidget {
  final List<
    _Stat
  >
  items;
  final Color accent;
  const _StatGrid({required this.items, required this.accent});

  @override
  Widget build(
    BuildContext context,
  ) {
    return LayoutBuilder(
      builder:
          (
            context,
            c,
          ) {
            final int cols =
                c.maxWidth >=
                    900
                ? 4
                : (c.maxWidth >=
                          520
                      ? 3
                      : 2);
            final double tileW =
                (c.maxWidth -
                    12 *
                        (cols -
                            1)) /
                cols;
            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                for (final it in items)
                  SizedBox(
                    width: tileW,
                    child: Container(
                      padding: const EdgeInsets.all(
                        18,
                      ),
                      decoration: _panelDecoration(
                        radius: 14,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 24,
                            height: 3,
                            color: accent,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              it.value,
                              style: GoogleFonts.montserrat(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            it.label.toUpperCase(),
                            style: GoogleFonts.montserrat(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Colors.white60,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          },
    );
  }
}
