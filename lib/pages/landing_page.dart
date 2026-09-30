import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drayve/data/data.dart';
import 'package:drayve/widgets/driver_card.dart';
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

  void _reloadPage() {
    setState(() {
      _activeMenu = '';
    });
  }

  Future<
    void
  >
  _requireLogin() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (
          context,
        ) => const AuthPage(),
      ),
    );

    // Perbarui tampilan menggunakan Global State
    if (result ==
        true) {
      setState(
        () {},
      );
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    double screenWidth = MediaQuery.of(
      context,
    ).size.width;
    bool isMobile =
        screenWidth <
        800;
    int crossAxisCount =
        screenWidth >
            1200
        ? 3
        : (screenWidth >
                  800
              ? 2
              : 1);
    double hPadding = isMobile
        ? 20.0
        : 40.0;
    double vPadding = isMobile
        ? 16.0
        : 24.0;
    double cardAspectRatio = isMobile
        ? 1.2
        : 1.8;

    List<
      Statistik
    >
    displayedDrivers = listPembalap;
    if (_activeMenu ==
        'Favorite') {
      displayedDrivers = listPembalap
          .where(
            (
              driver,
            ) => _favoriteDrivers.contains(
              driver.nama,
            ),
          )
          .toList();
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      endDrawer: _buildMobileDrawer(),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bgdong.png',
              fit: BoxFit.cover,
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
              ),
            ),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.black.withOpacity(
                    0.5,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: hPadding,
                    vertical: vPadding,
                  ),
                  child: isMobile
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: _reloadPage,
                                child: const Text(
                                  'DRAYVE',
                                  style: TextStyle(
                                    fontFamily: 'MagnetoBold',
                                    fontSize: 26,
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                  ),
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
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: _reloadPage,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'DRAYVE',
                                          style: TextStyle(
                                            fontFamily: 'MagnetoBold',
                                            fontSize: 64,
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
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildNavMenu(
                                  'Favorite',
                                ),
                                const SizedBox(
                                  width: 36,
                                ),
                                _buildNavMenu(
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
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: hPadding,
                      vertical: 12.0,
                    ),
                    child:
                        _activeMenu ==
                            'About'
                        ? const AboutMePage()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                _activeMenu ==
                                        'Favorite'
                                    ? 'Your personal paddock heroes'
                                    : 'Find your favorite drivers for the 2026 season',
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: isMobile
                                    ? 16
                                    : 24,
                              ),

                              if (_activeMenu ==
                                      'Favorite' &&
                                  displayedDrivers.isEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 40.0,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "No favorite drivers yet.\nClick the star icon on a driver's card to add them here!",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white54,
                                        fontSize: 16,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                )
                              else
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
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
                                  itemCount: displayedDrivers.length,
                                  itemBuilder:
                                      (
                                        context,
                                        index,
                                      ) {
                                        final currentDriver = displayedDrivers[index];
                                        return DriverCard(
                                          driver: currentDriver,
                                          isFavorite: _favoriteDrivers.contains(
                                            currentDriver.nama,
                                          ),
                                          onFavoriteToggle: () {
                                            if (!globalIsLoggedIn) {
                                              // PAKAI GLOBAL STATE
                                              _requireLogin();
                                            } else {
                                              setState(() {
                                                if (_favoriteDrivers.contains(
                                                  currentDriver.nama,
                                                )) {
                                                  _favoriteDrivers.remove(
                                                    currentDriver.nama,
                                                  );
                                                } else {
                                                  _favoriteDrivers.add(
                                                    currentDriver.nama,
                                                  );
                                                }
                                              });
                                            }
                                          },
                                        );
                                      },
                                ),
                              const SizedBox(
                                height: 40,
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
                    fontFamily: 'MagnetoBold',
                    fontSize: 32,
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
            'Favorite',
            Icons.star_border,
          ),
          _buildDrawerItem(
            'About',
            Icons.info_outline,
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    String title,
    IconData icon,
  ) {
    bool isSelected =
        _activeMenu ==
        title;
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected
            ? Colors.white
            : Colors.white70,
      ),
      title: Text(
        title,
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
        if (title ==
                'Favorite' &&
            !globalIsLoggedIn) {
          // PAKAI GLOBAL STATE
          _requireLogin();
          return;
        }
        setState(() {
          _activeMenu = title;
        });
      },
    );
  }

  Widget _buildNavMenu(
    String title,
  ) {
    bool isSelected =
        _activeMenu ==
        title;
    return InkWell(
      onTap: () {
        if (title ==
                'Favorite' &&
            !globalIsLoggedIn) {
          // PAKAI GLOBAL STATE
          _requireLogin();
          return;
        }
        setState(() {
          _activeMenu = title;
        });
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          AnimatedContainer(
            duration: const Duration(
              milliseconds: 200,
            ),
            height: 3,
            width: isSelected
                ? 48
                : 0,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderAction(
    bool isMobile,
  ) {
    if (globalIsLoggedIn) {
      // PAKAI GLOBAL STATE
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
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
                'assets/images/default_profile.png',
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
        ),
      );
    } else {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _requireLogin,
          borderRadius: BorderRadius.circular(
            6,
          ),
          child: Ink(
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
                  'assets/images/TBlogin.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
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
          ),
        ),
      );
    }
  }
}
