import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drayve/styles/colors.dart';
import 'package:drayve/data/schedule_data.dart';
import 'package:drayve/data/race_detail_data.dart';
import 'package:drayve/widgets/animated_background.dart';

/// Halaman detail satu balapan: tab Results, Circuits, dan About.
class RaceDetailPage extends StatefulWidget {
  const RaceDetailPage({super.key, required this.race});

  final ScheduleRace race;

  @override
  State<RaceDetailPage> createState() => _RaceDetailPageState();
}

class _RaceDetailPageState extends State<RaceDetailPage> {
  static const List<String> _tabs = ['Results', 'Circuits', 'About'];
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 700;
    final double hPadding = isMobile ? 16.0 : 48.0;
    final ScheduleRace race = widget.race;
    final RaceCircuitInfo? info = kRaceCircuitInfo[race.round];

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Stack(
        children: [
          const Positioned.fill(child: AnimatedBackground()),
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1280),
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(hPadding, 16, hPadding, 48),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBackButton(context),
                      const SizedBox(height: 20),
                      _buildHero(race, isMobile),
                      const SizedBox(height: 28),
                      _buildTabBar(isMobile),
                      const SizedBox(height: 24),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: KeyedSubtree(
                          key: ValueKey(_tabIndex),
                          child: _buildTabContent(race, info, isMobile),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.white70),
            const SizedBox(width: 8),
            Text(
              'SCHEDULE',
              style: GoogleFonts.montserrat(
                color: Colors.white70,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHero(ScheduleRace race, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.drayveRed,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'ROUND ${race.round}',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.sports_score, size: 16, color: Colors.white70),
            const SizedBox(width: 6),
            Text(
              race.dateRange,
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: isMobile ? 13 : 15,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _FlagCircle(code: race.countryCode, size: isMobile ? 30 : 42),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                race.countryName,
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: isMobile ? 30 : 52,
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          race.raceName,
          style: GoogleFonts.montserrat(
            color: Colors.white70,
            fontSize: isMobile ? 12 : 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar(bool isMobile) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white.withValues(alpha: 0.12)),
        ),
      ),
      child: Row(
        children: [
          for (int i = 0; i < _tabs.length; i++)
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => setState(() => _tabIndex = i),
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, isMobile ? 24 : 40, 0),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: _tabIndex == i
                              ? AppColors.drayveRed
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                    ),
                    child: Text(
                      _tabs[i],
                      style: GoogleFonts.montserrat(
                        color: _tabIndex == i ? Colors.white : Colors.white60,
                        fontSize: isMobile ? 15 : 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTabContent(
    ScheduleRace race,
    RaceCircuitInfo? info,
    bool isMobile,
  ) {
    switch (_tabIndex) {
      case 0:
        return _ResultsTab(race: race, laps: info?.laps);
      case 1:
        return _CircuitsTab(race: race, info: info, isMobile: isMobile);
      default:
        return _AboutTab(race: race, info: info);
    }
  }
}

// ---------------------------------------------------------------------------
// TAB RESULTS
// ---------------------------------------------------------------------------

class _ResultsTab extends StatelessWidget {
  const _ResultsTab({required this.race, required this.laps});

  final ScheduleRace race;
  final int? laps;

  static const double _minTableWidth = 760;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'RACE RESULT',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 14),
        Container(
          decoration: BoxDecoration(
            color: AppColors.cardDark,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          clipBehavior: Clip.antiAlias,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double width = constraints.maxWidth < _minTableWidth
                  ? _minTableWidth
                  : constraints.maxWidth;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: width,
                  child: Column(
                    children: [
                      _row(
                        header: true,
                        pos: 'Pos.',
                        no: 'No.',
                        driver: 'Driver',
                        team: 'Team',
                        lapsText: 'Laps',
                        time: 'Time / Retired',
                        pts: 'Pts.',
                      ),
                      for (int i = 0; i < race.podium.length; i++)
                        _podiumRow(i, race.podium[i]),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Menampilkan podium (P1 - P3). Posisi lainnya belum diisi.',
          style: GoogleFonts.montserrat(
            color: AppColors.textGrey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _podiumRow(int index, RacePodium podium) {
    final DriverInfo? driver = kDriverInfo[podium.driverCode];
    final Color teamColor =
        kDriverTeamColor[podium.driverCode] ?? AppColors.textGrey;
    final String time =
        index == 0 ? podium.result : '${podium.result}s'; // gap diberi 's'

    return _row(
      pos: '${index + 1}',
      no: driver != null ? '${driver.number}' : '-',
      driver: driver?.fullName ?? podium.driverCode,
      driverCode: podium.driverCode,
      team: driver?.team ?? '-',
      teamColor: teamColor,
      lapsText: laps != null ? '$laps' : '-',
      time: time,
      pts: '${kPodiumPoints[index]}',
    );
  }

  Widget _row({
    bool header = false,
    required String pos,
    required String no,
    required String driver,
    String? driverCode,
    required String team,
    Color? teamColor,
    required String lapsText,
    required String time,
    required String pts,
  }) {
    final TextStyle baseStyle = GoogleFonts.montserrat(
      color: header ? Colors.white54 : Colors.white,
      fontSize: header ? 12 : 14,
      fontWeight: header ? FontWeight.w700 : FontWeight.w600,
    );

    return Container(
      height: header ? 44 : 60,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: header ? AppColors.backgroundDark : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: Colors.white.withValues(alpha: 0.06)),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 56,
            child: Text(
              pos,
              style: baseStyle.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: header ? 12 : 16,
              ),
            ),
          ),
          SizedBox(width: 56, child: Text(no, style: baseStyle)),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    driver,
                    overflow: TextOverflow.ellipsis,
                    style: baseStyle,
                  ),
                ),
                if (driverCode != null) ...[
                  const SizedBox(width: 8),
                  Text(
                    driverCode,
                    style: baseStyle.copyWith(
                      color: Colors.white54,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                if (teamColor != null) ...[
                  Container(
                    width: 4,
                    height: 20,
                    decoration: BoxDecoration(
                      color: teamColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
                Flexible(
                  child: Text(
                    team,
                    overflow: TextOverflow.ellipsis,
                    style: baseStyle,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 70, child: Text(lapsText, style: baseStyle)),
          Expanded(flex: 2, child: Text(time, style: baseStyle)),
          SizedBox(
            width: 50,
            child: Text(
              pts,
              textAlign: TextAlign.right,
              style: baseStyle.copyWith(fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// TAB CIRCUITS
// ---------------------------------------------------------------------------

class _CircuitsTab extends StatelessWidget {
  const _CircuitsTab({
    required this.race,
    required this.info,
    required this.isMobile,
  });

  final ScheduleRace race;
  final RaceCircuitInfo? info;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final RaceCircuitInfo? c = info;
    if (c == null) {
      return const _EmptyState(text: 'Data circuit belum diisi.');
    }

    final stats = <_StatData>[
      _StatData('Circuit Length', c.lengthKm.toStringAsFixed(3), 'km'),
      _StatData('First Grand Prix', '${c.firstGrandPrix}', null),
      _StatData('Number of Laps', '${c.laps}', null),
      _StatData(
        'Fastest Lap Time',
        c.fastestLapTime ?? '--',
        null,
        sub: c.fastestLapHolder,
      ),
      _StatData('Race Distance', _trimDistance(c.raceDistanceKm), 'km'),
    ];

    final Widget trackMap = AspectRatio(
      aspectRatio: 16 / 10,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Image.asset(
          c.trackMapPath,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.route_outlined,
                  size: 56,
                  color: Colors.white.withValues(alpha: 0.18),
                ),
                const SizedBox(height: 10),
                Text(
                  'Track map belum tersedia',
                  style: GoogleFonts.montserrat(
                    color: AppColors.textGrey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    final Widget statsColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          c.circuitName,
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: isMobile ? 20 : 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          c.location,
          style: GoogleFonts.montserrat(color: Colors.white60, fontSize: 14),
        ),
        const SizedBox(height: 20),
        for (final s in stats) _StatTile(data: s, isMobile: isMobile),
      ],
    );

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [trackMap, const SizedBox(height: 24), statsColumn],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 5, child: trackMap),
        const SizedBox(width: 40),
        Expanded(flex: 4, child: statsColumn),
      ],
    );
  }

  String _trimDistance(double km) {
    String s = km.toStringAsFixed(3);
    if (s.contains('.')) {
      s = s.replaceAll(RegExp(r'0+$'), '');
      s = s.replaceAll(RegExp(r'\.$'), '');
    }
    return s;
  }
}

class _StatData {
  final String label;
  final String value;
  final String? unit;
  final String? sub;

  const _StatData(this.label, this.value, this.unit, {this.sub});
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.data, required this.isMobile});

  final _StatData data;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.label.toUpperCase(),
            style: GoogleFonts.montserrat(
              color: Colors.white54,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                data.value,
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: isMobile ? 26 : 32,
                  fontWeight: FontWeight.w900,
                ),
              ),
              if (data.unit != null) ...[
                const SizedBox(width: 6),
                Text(
                  data.unit!,
                  style: GoogleFonts.montserrat(
                    color: AppColors.drayveRed,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ],
          ),
          if (data.sub != null) ...[
            const SizedBox(height: 2),
            Text(
              data.sub!,
              style: GoogleFonts.montserrat(
                color: Colors.white70,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// TAB ABOUT
// ---------------------------------------------------------------------------

class _AboutTab extends StatelessWidget {
  const _AboutTab({required this.race, required this.info});

  final ScheduleRace race;
  final RaceCircuitInfo? info;

  @override
  Widget build(BuildContext context) {
    final RaceCircuitInfo? c = info;
    if (c == null) {
      return const _EmptyState(text: 'Informasi About belum diisi.');
    }

    final String firstGp = c.firstGrandPrix >= 2026
        ? 'Grand Prix pertama di ${c.circuitName} digelar pada ${c.firstGrandPrix}.'
        : 'Grand Prix pertama di ${c.circuitName} digelar pada ${c.firstGrandPrix}, '
            'sehingga sudah ${2026 - c.firstGrandPrix} tahun sejak debutnya di kalender F1.';

    final String fastest = c.fastestLapTime == null
        ? 'Rekor lap resmi belum tercatat di circuit ini.'
        : 'Lap tercepat tercatat ${c.fastestLapTime} oleh ${c.fastestLapHolder ?? '-'}.';

    final items = <MapEntry<String, String>>[
      MapEntry(
        'Where is the ${c.circuitName}?',
        '${c.circuitName} berlokasi di ${c.location} dan menjadi tuan rumah '
            '${race.raceName}.',
      ),
      MapEntry('When was its first Grand Prix?', firstGp),
      MapEntry(
        'How long is the circuit?',
        'Panjang lintasan ${c.lengthKm.toStringAsFixed(3)} km. Balapan '
            'berlangsung ${c.laps} lap dengan total jarak '
            '${c.raceDistanceKm} km.',
      ),
      MapEntry('What is the fastest lap?', fastest),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ABOUT ${c.circuitName.toUpperCase()}',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 14),
        for (final item in items) _FaqTile(question: item.key, answer: item.value),
      ],
    );
  }
}

class _FaqTile extends StatelessWidget {
  const _FaqTile({required this.question, required this.answer});

  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: AppColors.drayveRed,
          collapsedIconColor: Colors.white70,
          tilePadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          title: Text(
            question,
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          children: [
            Text(
              answer,
              style: GoogleFonts.montserrat(
                color: Colors.white70,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// WIDGET BERSAMA
// ---------------------------------------------------------------------------

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 56),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 44,
            color: Colors.white.withValues(alpha: 0.25),
          ),
          const SizedBox(height: 12),
          Text(
            text,
            style: GoogleFonts.montserrat(
              color: AppColors.textGrey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

/// Bendera bulat. Mencoba memuat `assets/images/flags/<kode>.png`;
/// jika belum ada, tampil lingkaran berisi kode negara.
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