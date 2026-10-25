import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drayve/data/data.dart';
import 'package:drayve/widgets/driver_card.dart';
import 'package:drayve/widgets/animated_background.dart';
import 'package:drayve/widgets/smooth_scroll.dart';
import 'package:drayve/widgets/interactive.dart';
import 'package:drayve/widgets/drayve_page_route.dart';
import 'package:drayve/models/statistik.dart';
import 'package:drayve/pages/aboutme_page.dart';
import 'package:drayve/pages/login_signup_page.dart';
import 'package:drayve/pages/profile_page.dart';
import 'package:drayve/data/auth_state.dart'; // IMPORT GLOBAL STATE

class LandingPage
    extends
        StatefulWidget {
  const LandingPage({super.key});

  @override
  State<
    LandingPage
  >
  createState() => _LandingPageState();
}

class _LandingPageState
    extends
        State<
          LandingPage
        > {
  String _activeMenu = '';
  String _selectedTeam = 'All';
  String _searchQuery = '';
  String? _hoveredMenu;

  final Set<
    String
  >
  _favoriteDrivers = {};
  final GlobalKey<
    ScaffoldState
  >
  _scaffoldKey =
      GlobalKey<
        ScaffoldState
      >();

  late final SmoothScrollController _scrollController;
  final TextEditingController _searchController = TextEditingController();

  static const List<
    String
  >
  _teams = [
    'All',
    'Ferrari',
    'Mercedes',
    'McLaren',
    'Red Bull',
    'Aston',
    'Williams',
    'Audi',
    'Haas',
    'Alpine',
    'Racing Bulls',
    'Cadillac',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = SmoothScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _reloadPage() {
    setState(() {
      _activeMenu = '';
      _selectedTeam = 'All';
      _searchQuery = '';
      _searchController.clear();
    });
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(
          milliseconds: 450,
        ),
        curve: Curves.easeOutCubic,
      );
    }
  }

  Future<
    void
  >
  _requireLogin() async {
    final result = await Navigator.push(
      context,
      DrayvePageRoute(
        builder: (
          context,
        ) => const AuthPage(),
      ),
    );

    // Perbarui tampilan menggunakan Global State
    if (result ==
            true &&
        mounted) {
      setState(
        () {},
      );
    }
  }

  List<
    Statistik
  >
  _getFilteredDrivers() {
    Iterable<
      Statistik
    >
    drivers = listPembalap;

    if (_activeMenu ==
        'Favorite') {
      drivers = drivers.where(
        (
          d,
        ) => _favoriteDrivers.contains(
          d.nama,
        ),
      );
    }

    if (_selectedTeam !=
        'All') {
      final teamLower = _selectedTeam.toLowerCase();
      drivers = drivers.where(
        (
          d,
        ) => d.tim.toLowerCase().contains(
          teamLower,
        ),
      );
    }

    if (_searchQuery.trim().isNotEmpty) {
      final q = _searchQuery.trim().toLowerCase();
      drivers = drivers.where(
        (
          d,
        ) =>
            d.nama.toLowerCase().contains(
              q,
            ) ||
            d.tim.toLowerCase().contains(
              q,
            ) ||
            d.nomorMobil.toString().contains(
              q,
            ),
      );
    }

    return drivers.toList();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final double screenWidth = MediaQuery.of(
      context,
    ).size.width;
    final bool isMobile =
        screenWidth <
        800;
    final int crossAxisCount =
        screenWidth >
            1200
        ? 3
        : (screenWidth >
                  800
              ? 2
              : 1);
    final double hPadding = isMobile
        ? 20.0
        : 40.0;
    final double vPadding = isMobile
        ? 16.0
        : 24.0;
    final double cardAspectRatio = isMobile
        ? 1.2
        : 1.8;

    final List<
      Statistik
    >
    displayedDrivers = _getFilteredDrivers();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      endDrawer: _buildMobileDrawer(),
      body: Stack(
        children: [
          // Background animasi interaktif: gradasi bergerak + glow kursor + parallax
          Positioned.fill(
            child: const AnimatedBackground(),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- NAVBAR ---
                _buildTopNavbar(
                  isMobile,
                  hPadding,
                  vPadding,
                ),

                // --- CONTENT AREA ---
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(
                      milliseconds: 320,
                    ),
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    child:
                        _activeMenu ==
                            'About'
                        ? SingleChildScrollView(
                            key: const ValueKey(
                              'about_view',
                            ),
                            controller: _scrollController,
                            padding: EdgeInsets.symmetric(
                              horizontal: hPadding,
                              vertical: 12.0,
                            ),
                            child: const AboutMePage(),
                          )
                        : CustomScrollView(
                            key: ValueKey(
                              'drivers_view_$_activeMenu',
                            ),
                            controller: _scrollController,
                            slivers: [
                              SliverPadding(
                                padding: EdgeInsets.fromLTRB(
                                  hPadding,
                                  16.0,
                                  hPadding,
                                  8.0,
                                ),
                                sliver: SliverToBoxAdapter(
                                  child: _buildHeroAndFilters(
                                    isMobile,
                                    displayedDrivers.length,
                                  ),
                                ),
                              ),
                              if (displayedDrivers.isEmpty)
                                SliverFillRemaining(
                                  hasScrollBody: false,
                                  child: _buildEmptyState(),
                                )
                              else
                                SliverPadding(
                                  padding: EdgeInsets.fromLTRB(
                                    hPadding,
                                    8.0,
                                    hPadding,
                                    48.0,
                                  ),
                                  sliver: SliverGrid(
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: crossAxisCount,
                                      crossAxisSpacing: isMobile
                                          ? 16
                                          : 24,
                                      mainAxisSpacing: isMobile
                                          ? 16
                                          : 24,
                                      childAspectRatio: cardAspectRatio,
                                    ),
                                    delegate: SliverChildBuilderDelegate(
                                      (
                                        context,
                                        index,
                                      ) {
                                        final currentDriver = displayedDrivers[index];
                                        return RevealOnce(
                                          key: ValueKey(
                                            currentDriver.id,
                                          ),
                                          id: 'card_${currentDriver.id}',
                                          delay: Duration(
                                            milliseconds:
                                                (index %
                                                    6) *
                                                55,
                                          ),
                                          child: DriverCard(
                                            driver: currentDriver,
                                            isFavorite: _favoriteDrivers.contains(
                                              currentDriver.nama,
                                            ),
                                            onFavoriteToggle: () => _toggleFavorite(
                                              currentDriver,
                                            ),
                                          ),
                                        );
                                      },
                                      childCount: displayedDrivers.length,
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
        ],
      ),
    );
  }

  void _toggleFavorite(
    Statistik driver,
  ) {
    if (!globalIsLoggedIn) {
      _requireLogin();
    } else {
      setState(() {
        if (_favoriteDrivers.contains(
          driver.nama,
        )) {
          _favoriteDrivers.remove(
            driver.nama,
          );
        } else {
          _favoriteDrivers.add(
            driver.nama,
          );
        }
      });
    }
  }

  Widget _buildTopNavbar(
    bool isMobile,
    double hPadding,
    double vPadding,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(
          alpha: 0.55,
        ),
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withValues(
              alpha: 0.08,
            ),
            width: 1,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: hPadding,
        vertical: vPadding,
      ),
      child: isMobile
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HoverScale(
                  onTap: _reloadPage,
                  child: const Text(
                    'DRAYVE',
                    style: TextStyle(
                      fontFamily: 'Ethnocentric',
                      fontStyle: FontStyle.italic,
                      fontSize: 24,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    _buildHeaderAction(
                      isMobile,
                    ),
                  ],
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: HoverScale(
                      scale: 1.03,
                      onTap: _reloadPage,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'DRAYVE',
                            style: TextStyle(
                              fontFamily: 'Ethnocentric',
                              fontStyle: FontStyle.italic,
                              fontSize: 32,
                              color: Colors.white,
                              letterSpacing: 1.5,
                            ),
                          ),
                          Text(
                            'F1 Drivers Hub Community',
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: Colors.white70,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildNavMenu(
                      'Drivers',
                      '',
                    ),
                    const SizedBox(
                      width: 32,
                    ),
                    _buildNavMenu(
                      'Favorite',
                      'Favorite',
                    ),
                    const SizedBox(
                      width: 32,
                    ),
                    _buildNavMenu(
                      'About',
                      'About',
                    ),
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: _buildHeaderAction(
                      isMobile,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildHeroAndFilters(
    bool isMobile,
    int totalShown,
  ) {
    final searchBox = SizedBox(
      width: isMobile
          ? double.infinity
          : 320,
      height: 38,
      child: TextField(
        controller: _searchController,
        onChanged:
            (
              value,
            ) => setState(
              () => _searchQuery = value,
            ),
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: 'Search driver, team, or #no...',
          hintStyle: GoogleFonts.montserrat(
            color: Colors.white54,
            fontSize: 12.5,
            letterSpacing: 0.4,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: Colors.white70,
            size: 19,
          ),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Colors.white70,
                    size: 17,
                  ),
                  onPressed: () {
                    _searchController.clear();
                    setState(
                      () => _searchQuery = '',
                    );
                  },
                )
              : null,
          filled: true,
          fillColor: Colors.white.withValues(
            alpha: 0.08,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              30,
            ),
            borderSide: BorderSide(
              color: Colors.white.withValues(
                alpha: 0.16,
              ),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              30,
            ),
            borderSide: const BorderSide(
              color: Color(
                0xFFE10600,
              ),
              width: 1.5,
            ),
          ),
        ),
      ),
    );

    final filterChips = SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _teams.length,
        separatorBuilder:
            (
              _,
              _,
            ) => const SizedBox(
              width: 8,
            ),
        itemBuilder:
            (
              context,
              index,
            ) {
              final team = _teams[index];
              final isSelected =
                  _selectedTeam ==
                  team;
              return HoverScale(
                scale: 1.05,
                onTap: () => setState(
                  () => _selectedTeam = team,
                ),
                child: AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 200,
                  ),
                  curve: Curves.easeOutCubic,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(
                            0xFFE10600,
                          )
                        : Colors.white.withValues(
                            alpha: 0.08,
                          ),
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                    border: Border.all(
                      color: isSelected
                          ? Colors.white.withValues(
                              alpha: 0.65,
                            )
                          : Colors.white.withValues(
                              alpha: 0.14,
                            ),
                      width: 1,
                    ),
                    boxShadow: isSelected
                        ? const [
                            BoxShadow(
                              color: Color(
                                0x66E10600,
                              ),
                              blurRadius: 12,
                              offset: Offset(
                                0,
                                3,
                              ),
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      team.toUpperCase(),
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 11.5,
                        fontWeight: isSelected
                            ? FontWeight.w800
                            : FontWeight.w600,
                        letterSpacing: 0.7,
                      ),
                    ),
                  ),
                ),
              );
            },
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Judul & Subjudul di atas
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 5,
              height: isMobile
                  ? 24
                  : 32,
              margin: const EdgeInsets.only(
                right: 12,
              ),
              decoration: BoxDecoration(
                color: const Color(
                  0xFFE10600,
                ),
                borderRadius: BorderRadius.circular(
                  4,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(
                      0x88E10600,
                    ),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
            Text(
              _activeMenu ==
                      'Favorite'
                  ? 'FAVORITE DRIVERS'
                  : 'F1 DRIVERS 2026',
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
          _activeMenu ==
                  'Favorite'
              ? 'Your personal paddock heroes ($totalShown drivers)'
              : 'Find your favorite drivers for the 2026 season ($totalShown drivers)',
          style: GoogleFonts.montserrat(
            fontSize: 12,
            color: Colors.white70,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(
          height: 18,
        ),

        // Search Bar sejajar (1 baris) dengan Filter Team di Desktop
        if (isMobile) ...[
          searchBox,
          const SizedBox(
            height: 12,
          ),
          filterChips,
        ] else
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              searchBox,
              const SizedBox(
                width: 14,
              ),
              Expanded(
                child: filterChips,
              ),
            ],
          ),

        SizedBox(
          height: isMobile
              ? 12
              : 18,
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    final isFavEmpty =
        _activeMenu ==
            'Favorite' &&
        _selectedTeam ==
            'All' &&
        _searchQuery.isEmpty;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 48.0,
        horizontal: 24.0,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isFavEmpty
                  ? Icons.star_border_rounded
                  : Icons.sports_motorsports_outlined,
              color: Colors.white38,
              size: 56,
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              isFavEmpty
                  ? "No favorite drivers yet.\nClick the star icon on a driver's card to add them here!"
                  : "No drivers match your filter.\nTry choosing another team or clearing the search.",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: Colors.white60,
                fontSize: 15,
                height: 1.5,
              ),
            ),
            if (!isFavEmpty) ...[
              const SizedBox(
                height: 16,
              ),
              HoverScale(
                onTap: () {
                  _searchController.clear();
                  setState(() {
                    _selectedTeam = 'All';
                    _searchQuery = '';
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(
                      0xFFE10600,
                    ),
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                  child: Text(
                    'RESET FILTER',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMobileDrawer() {
    return Drawer(
      backgroundColor: const Color(
        0xFF1E2124,
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.black,
              border: Border(
                bottom: BorderSide(
                  color: Colors.white24,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'DRAYVE',
                  style: TextStyle(
                    fontFamily: 'Ethnocentric',
                    fontStyle: FontStyle.italic,
                    fontSize: 28,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'F1 Drivers Hub Community',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            'Drivers',
            '',
            Icons.sports_motorsports_outlined,
          ),
          _buildDrawerItem(
            'Favorite',
            'Favorite',
            Icons.star_border,
          ),
          _buildDrawerItem(
            'About',
            'About',
            Icons.info_outline,
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    String label,
    String menuKey,
    IconData icon,
  ) {
    final bool isSelected =
        _activeMenu ==
        menuKey;
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected
            ? const Color(
                0xFFE10600,
              )
            : Colors.white70,
      ),
      title: Text(
        label,
        style: GoogleFonts.montserrat(
          color: isSelected
              ? Colors.white
              : Colors.white70,
          fontSize: 16,
          fontWeight: isSelected
              ? FontWeight.bold
              : FontWeight.w500,
        ),
      ),
      onTap: () {
        Navigator.pop(
          context,
        );
        if (menuKey ==
                'Favorite' &&
            !globalIsLoggedIn) {
          _requireLogin();
          return;
        }
        setState(() {
          _activeMenu = menuKey;
        });
      },
    );
  }

  Widget _buildNavMenu(
    String label,
    String menuKey,
  ) {
    final bool isSelected =
        _activeMenu ==
        menuKey;
    final bool isHovered =
        _hoveredMenu ==
        label;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter:
          (
            _,
          ) => setState(
            () => _hoveredMenu = label,
          ),
      onExit:
          (
            _,
          ) => setState(
            () => _hoveredMenu = null,
          ),
      child: GestureDetector(
        onTap: () {
          if (menuKey ==
                  'Favorite' &&
              !globalIsLoggedIn) {
            _requireLogin();
            return;
          }
          setState(() {
            _activeMenu = menuKey;
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(
                milliseconds: 180,
              ),
              style: GoogleFonts.montserrat(
                color:
                    isSelected ||
                        isHovered
                    ? Colors.white
                    : Colors.white70,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
              child: Text(
                label,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            AnimatedContainer(
              duration: const Duration(
                milliseconds: 220,
              ),
              curve: Curves.easeOutCubic,
              height: 3,
              width: isSelected
                  ? 44
                  : (isHovered
                        ? 24
                        : 0),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(
                        0xFFE10600,
                      )
                    : Colors.white70,
                borderRadius: BorderRadius.circular(
                  2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderAction(
    bool isMobile,
  ) {
    if (globalIsLoggedIn) {
      return HoverScale(
        onTap: () {
          Navigator.push(
            context,
            DrayvePageRoute(
              builder: (
                context,
              ) => const ProfilePage(),
            ),
          );
        },
        child: Container(
          width: isMobile
              ? 40
              : 48,
          height: isMobile
              ? 40
              : 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(
                0xFFE8002D,
              ),
              width: 2,
            ),
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/images/default_profile.webp',
              fit: BoxFit.cover,
              errorBuilder:
                  (
                    context,
                    error,
                    stackTrace,
                  ) => Container(
                    color: Colors.white12,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: isMobile
                          ? 24
                          : 30,
                    ),
                  ),
            ),
          ),
        ),
      );
    } else {
      return HoverScale(
        onTap: _requireLogin,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 1.8,
            ),
            borderRadius: BorderRadius.circular(
              6,
            ),
            image: const DecorationImage(
              image: AssetImage(
                'assets/images/TBlogin.webp',
              ),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile
                ? 16
                : 34,
            vertical: isMobile
                ? 6
                : 10,
          ),
          child: Text(
            'LOGIN',
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: isMobile
                  ? 12
                  : 14,
              letterSpacing: isMobile
                  ? 1.0
                  : 1.5,
            ),
          ),
        ),
      );
    }
  }
}
