import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drayve/data/f1_teams.dart';
import 'package:drayve/widgets/animated_background.dart';
import 'package:drayve/widgets/drayve_page_route.dart';
import 'package:drayve/widgets/interactive.dart';

const Color _kRed = Color(0xFFE10600);

/// Halaman daftar tim (ditampilkan di landing page, tanpa Scaffold).
class TeamsPage extends StatelessWidget {
  const TeamsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 800;
    final int crossAxisCount = width > 1200 ? 3 : (width > 800 ? 2 : 1);
    final double hPadding = isMobile ? 20.0 : 40.0;
    final teams = kF1Teams;

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.fromLTRB(hPadding, 16, hPadding, 8),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(width: 5, height: isMobile ? 26 : 34, color: _kRed),
                    const SizedBox(width: 12),
                    Text(
                      'F1 TEAMS 2026',
                      style: GoogleFonts.montserrat(
                        fontSize: isMobile ? 24 : 32,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Tim Formula 1 musim 2026 (${teams.length} tim)',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 18),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(hPadding, 8, hPadding, 48),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: isMobile ? 16 : 24,
              mainAxisSpacing: isMobile ? 16 : 24,
              mainAxisExtent: 160,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final team = teams[index];
                return RevealOnce(
                  key: ValueKey('team_${team.name}'),
                  id: 'team_card_${team.name}',
                  delay: Duration(milliseconds: (index % 6) * 55),
                  child: _TeamCard(
                    team: team,
                    onTap: () => Navigator.of(context).push(
                      DrayvePageRoute(
                        builder: (_) => TeamInfoPage(team: team),
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

class _TeamCard extends StatefulWidget {
  final F1Team team;
  final VoidCallback onTap;

  const _TeamCard({required this.team, required this.onTap});

  @override
  State<_TeamCard> createState() => _TeamCardState();
}

class _TeamCardState extends State<_TeamCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final team = widget.team;
    final drivers = team.drivers;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: const Color(0xFF15151E).withOpacity(0.92),
            border: Border.all(
              color: _hovered ? team.color : Colors.white.withOpacity(0.08),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: team.color.withOpacity(_hovered ? 0.35 : 0.12),
                blurRadius: _hovered ? 26 : 14,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Row(
              children: [
                Container(width: 6, color: team.color),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 28,
                          height: 3,
                          color: team.color,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          team.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${team.chassis}  •  ${team.engineSupplier}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white70,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          drivers.map((d) => d.name).join('  /  '),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white54,
                          ),
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
    );
  }
}

/// Halaman detail tim (polos, tanpa gambar).
class TeamInfoPage extends StatelessWidget {
  final F1Team team;

  const TeamInfoPage({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 800;
    final double hPadding = isMobile ? 20.0 : 40.0;
    final drivers = team.drivers;
    final t = team;

    final seasonPanel = _InfoPanel(
      title: '2026 SEASON',
      accent: team.color,
      rows: [
        _StatRow('Grand Prix', '${t.gpRaces}'),
        _StatRow('Menang', '${t.gpWins}'),
        _StatRow('Podium', '${t.gpPodiums}'),
        _StatRow('Pole', '${t.gpPoles}'),
        _StatRow('Top 10', '${t.gpTop10s}'),
        _StatRow('Fastest Lap', '${t.fastestLaps}'),
        _StatRow('DNF', '${t.dnfsSeason}'),
      ],
    );
    final summaryPanel = _InfoPanel(
      title: 'ALL-TIME',
      accent: team.color,
      rows: [
        _StatRow('Grand Prix diikuti', '${t.grandsPrixEntered}'),
        _StatRow('Finis terbaik', t.highestRaceFinish),
        _StatRow('Podium', '${t.podiums}'),
        _StatRow('Grid terbaik', t.highestGridPosition),
        _StatRow('Pole position', '${t.polePositions}'),
        _StatRow('Juara dunia', '${t.worldChampionships}'),
      ],
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const Positioned.fill(child: AnimatedBackground()),
          SafeArea(
            child: Column(
              children: [
                Container(
                  color: Colors.black.withOpacity(0.55),
                  padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: 12),
                  child: Row(
                    children: [
                      HoverScale(
                        onTap: () => Navigator.of(context).pop(),
                        child: Row(
                          children: [
                            const Icon(Icons.arrow_back, color: Colors.white, size: 22),
                            const SizedBox(width: 8),
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
                    padding: EdgeInsets.fromLTRB(hPadding, 28, hPadding, 48),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(width: 6, height: isMobile ? 64 : 84, color: team.color),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    team.name,
                                    style: GoogleFonts.montserrat(
                                      fontSize: isMobile ? 24 : 36,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      height: 1.1,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    '${team.chassis}  •  ${team.engineSupplier}',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: _panelDecoration(),
                          child: Text(
                            team.description,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              height: 1.6,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (drivers.isNotEmpty) ...[
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              for (final d in drivers)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  decoration: _panelDecoration(radius: 12),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '#${d.number}',
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w900,
                                          color: team.color,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        d.name,
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                        if (isMobile) ...[
                          seasonPanel,
                          const SizedBox(height: 16),
                          summaryPanel,
                        ] else
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: seasonPanel),
                              const SizedBox(width: 24),
                              Expanded(child: summaryPanel),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

BoxDecoration _panelDecoration({double radius = 18}) => BoxDecoration(
      color: const Color(0xFF15151E).withOpacity(0.92),
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: Colors.white.withOpacity(0.08)),
    );

class _StatRow {
  final String label;
  final String value;
  const _StatRow(this.label, this.value);
}

class _InfoPanel extends StatelessWidget {
  final String title;
  final Color accent;
  final List<_StatRow> rows;

  const _InfoPanel({required this.title, required this.accent, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: _panelDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 4, height: 18, color: accent),
              const SizedBox(width: 10),
              Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          for (int i = 0; i < rows.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: i == rows.length - 1
                    ? null
                    : Border(bottom: BorderSide(color: Colors.white.withOpacity(0.06))),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      rows[i].label,
                      style: GoogleFonts.montserrat(fontSize: 13, color: Colors.white60),
                    ),
                  ),
                  Text(
                    rows[i].value,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}