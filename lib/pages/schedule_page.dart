import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drayve/styles/colors.dart';
import 'package:drayve/data/schedule_data.dart';
import 'package:drayve/pages/race_detail_page.dart';
import 'package:drayve/widgets/drayve_page_route.dart';

/// Halaman Schedule: kalender F1 2026 (Round 1 - Round 20),
/// tampilan kartu mengikuti referensi situs resmi Formula 1.
class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 700;
    final double hPadding = isMobile ? 16.0 : 48.0;
    final int columns = width >= 1100 ? 3 : (width >= 700 ? 2 : 1);

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.fromLTRB(hPadding, 24.0, hPadding, 20.0),
          sliver: SliverToBoxAdapter(child: _buildHeader(isMobile)),
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(hPadding, 0, hPadding, 40.0),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              mainAxisSpacing: isMobile ? 14 : 20,
              crossAxisSpacing: isMobile ? 14 : 20,
              mainAxisExtent: isMobile ? 250 : 270,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => _RaceCard(
                race: kScheduleRaces[index],
                isMobile: isMobile,
              ),
              childCount: kScheduleRaces.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 5,
              height: isMobile ? 28 : 36,
              decoration: BoxDecoration(
                color: AppColors.drayveRed,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(width: 14),
            Text(
              'SCHEDULE',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: isMobile ? 24 : 34,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 19),
          child: Text(
            'F1 2026 Race Calendar & Results',
            style: GoogleFonts.montserrat(
              color: Colors.white70,
              fontSize: isMobile ? 13 : 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

/// Kartu satu balapan (round, tanggal, negara, nama GP, podium).
class _RaceCard extends StatefulWidget {
  const _RaceCard({required this.race, required this.isMobile});

  final ScheduleRace race;
  final bool isMobile;

  @override
  State<_RaceCard> createState() => _RaceCardState();
}

class _RaceCardState extends State<_RaceCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final ScheduleRace race = widget.race;
    final bool isMobile = widget.isMobile;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.push(
          context,
          DrayvePageRoute(builder: (context) => RaceDetailPage(race: race)),
        ),
        child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
        padding: EdgeInsets.all(isMobile ? 16 : 20),
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _hovered
                ? AppColors.drayveRed
                : Colors.white.withValues(alpha: 0.08),
            width: 1.5,
          ),
          boxShadow: [
            if (_hovered)
              BoxShadow(
                color: AppColors.drayveRed.withValues(alpha: 0.25),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BARIS ATAS: ROUND + BADGE TANGGAL
            Row(
              children: [
                Text(
                  'ROUND ${race.round}',
                  style: GoogleFonts.montserrat(
                    color: Colors.white70,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
                const Spacer(),
                _DateBadge(text: race.dateRange),
              ],
            ),
            const SizedBox(height: 8),
            // BENDERA + NAMA NEGARA
            Row(
              children: [
                _FlagCircle(code: race.countryCode, size: isMobile ? 22 : 26),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    race.countryName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: isMobile ? 22 : 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // NAMA GRAND PRIX
            Text(
              race.raceName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.montserrat(
                color: Colors.white70,
                fontSize: isMobile ? 11 : 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
                height: 1.3,
              ),
            ),
            const Spacer(),
            // PODIUM P1 - P3
            Row(
              children: [
                for (int i = 0; i < race.podium.length; i++) ...[
                  if (i > 0) const SizedBox(width: 8),
                  Expanded(
                    child: _PodiumTile(position: i + 1, podium: race.podium[i]),
                  ),
                ],
              ],
            ),
          ],
        ),
        ),
      ),
    );
  }
}

class _DateBadge extends StatelessWidget {
  const _DateBadge({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.backgroundDark,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.sports_score, size: 13, color: Colors.white70),
          const SizedBox(width: 6),
          Text(
            text,
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}

/// Bendera bulat. Mencoba memuat `assets/images/flags/<kode>.png`;
/// jika file belum ada, tampil lingkaran dengan kode negara.
class _FlagCircle extends StatelessWidget {
  const _FlagCircle({required this.code, required this.size});

  final String code;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: Image.asset(
          'assets/images/flags/${code.toLowerCase()}.png',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.white.withValues(alpha: 0.12),
            alignment: Alignment.center,
            child: Text(
              code.toUpperCase(),
              style: GoogleFonts.montserrat(
                color: Colors.white70,
                fontSize: size * 0.38,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PodiumTile extends StatelessWidget {
  const _PodiumTile({required this.position, required this.podium});

  final int position;
  final RacePodium podium;

  String get _suffix => position == 1 ? 'ST' : (position == 2 ? 'ND' : 'RD');

  @override
  Widget build(BuildContext context) {
    final Color teamColor =
        kDriverTeamColor[podium.driverCode] ?? AppColors.textGrey;

    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.backgroundDark,
        borderRadius: BorderRadius.circular(6),
      ),
      alignment: Alignment.centerLeft,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$position',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    height: 1.0,
                  ),
                ),
                Text(
                  _suffix,
                  style: GoogleFonts.montserrat(
                    color: Colors.white54,
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            // AVATAR PEMBALAP (placeholder warna tim)
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: teamColor.withValues(alpha: 0.9),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person,
                size: 20,
                color: Colors.black54,
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  podium.driverCode,
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                  ),
                ),
                Text(
                  podium.result,
                  style: GoogleFonts.montserrat(
                    color: Colors.white70,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}