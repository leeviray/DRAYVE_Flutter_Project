import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drayve/data/data_sosmed.dart';
import 'package:drayve/pages/login_signup_page.dart';
import 'package:drayve/data/auth_state.dart'; // IMPORT GLOBAL STATE

class LatestPostTab
    extends
        StatelessWidget {
  final String driverName;
  final String driverTeam;
  final String fotoAset;
  final bool isMobile;

  const LatestPostTab({super.key, required this.driverName, required this.driverTeam, required this.fotoAset, required this.isMobile});

  @override
  Widget build(
    BuildContext context,
  ) {
    DriverSocialData? socialData;
    try {
      socialData = dataSosmedF1.firstWhere(
        (
          data,
        ) =>
            data.driverName.toLowerCase() ==
            driverName.toLowerCase(),
      );
    } catch (
      e
    ) {
      socialData = null;
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
            "LATEST UPDATES",
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

          if (socialData ==
                  null ||
              socialData.posts.isEmpty)
            Text(
              "No recent updates from $driverName.",
              style: GoogleFonts.montserrat(
                color: Colors.white54,
              ),
            )
          else
            ...socialData.posts.map(
              (
                post,
              ) => InteractivePostCard(
                post: post,
                driverName: driverName,
                driverTeam: driverTeam,
                fotoAset: fotoAset,
              ),
            ),
        ],
      ),
    );
  }
}

class InteractivePostCard
    extends
        StatefulWidget {
  final PostData post;
  final String driverName;
  final String driverTeam;
  final String fotoAset;

  const InteractivePostCard({super.key, required this.post, required this.driverName, required this.driverTeam, required this.fotoAset});

  @override
  State<
    InteractivePostCard
  >
  createState() => _InteractivePostCardState();
}

class _InteractivePostCardState
    extends
        State<
          InteractivePostCard
        > {
  bool isLiked = false;
  late int currentLikes;

  @override
  void initState() {
    super.initState();
    currentLikes = widget.post.likes;
  }

  Future<
    void
  >
  _handleLike() async {
    if (!globalIsLoggedIn) {
      // PAKAI GLOBAL STATE
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (
            context,
          ) => const AuthPage(),
        ),
      );
      if (result ==
          true) {
        setState(() {
          isLiked = true;
          currentLikes++;
        });
      }
    } else {
      setState(() {
        isLiked = !isLiked;
        isLiked
            ? currentLikes++
            : currentLikes--;
      });
    }
  }

  Future<
    void
  >
  _handleComment() async {
    if (!globalIsLoggedIn) {
      // PAKAI GLOBAL STATE
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (
            context,
          ) => const AuthPage(),
        ),
      );
      if (result ==
          true) {
        setState(
          () {},
        );
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(
          const SnackBar(
            content: Text(
              "Welcome back! You can now reply to posts.",
            ),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content: Text(
            "Comment dialog will appear here.",
          ),
        ),
      );
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 32,
      ),
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
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white12,
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  widget.fotoAset,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  errorBuilder:
                      (
                        context,
                        error,
                        stackTrace,
                      ) => const Icon(
                        Icons.person,
                        color: Colors.white54,
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
                      widget.driverName,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "${widget.post.timeAgo}  •  ${widget.driverTeam}",
                      style: GoogleFonts.montserrat(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.more_horiz,
                color: Colors.white54,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.post.content,
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 14,
              height: 1.6,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(
              12,
            ),
            child: AspectRatio(
              aspectRatio: 1.0,
              // TODO: Ganti picsum ini dengan aset lokal jika sudah siap
              child: Image.network(
                "https://picsum.photos/seed/${widget.post.content.hashCode}/500/500",
                fit: BoxFit.cover,
                errorBuilder:
                    (
                      context,
                      error,
                      stackTrace,
                    ) => Container(
                      color: Colors.white10,
                      child: const Icon(
                        Icons.broken_image,
                        color: Colors.white54,
                        size: 48,
                      ),
                    ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            color: Colors.white12,
            height: 1,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: _handleLike,
                  child: _buildActionBtn(
                    isLiked
                        ? Icons.favorite
                        : Icons.favorite_border,
                    "${currentLikes ~/ 1000}k",
                    isLiked
                        ? const Color(
                            0xFFE8002D,
                          )
                        : Colors.white54,
                  ),
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: _handleComment,
                  child: _buildActionBtn(
                    Icons.chat_bubble_outline,
                    "${widget.post.comments}",
                    Colors.white54,
                  ),
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: _handleComment,
                  child: _buildActionBtn(
                    Icons.share,
                    "Share",
                    Colors.white54,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionBtn(
    IconData icon,
    String label,
    Color color,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 20,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          label,
          style: GoogleFonts.montserrat(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
