import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drayve/data/data_sosmed.dart';
import 'package:drayve/pages/login_signup_page.dart';
import 'package:drayve/data/auth_state.dart'; // IMPORT GLOBAL STATE

class DiscussionTab
    extends
        StatefulWidget {
  final String driverName;
  final bool isMobile;

  const DiscussionTab({super.key, required this.driverName, required this.isMobile});

  @override
  State<
    DiscussionTab
  >
  createState() => _DiscussionTabState();
}

class _DiscussionTabState
    extends
        State<
          DiscussionTab
        > {
  final TextEditingController _commentController = TextEditingController();

  Future<
    void
  >
  _handleAction() async {
    if (!globalIsLoggedIn) {
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
        ); // Segarkan tampilan setelah login
      }
    }
  }

  void _sendComment(
    DriverSocialData? socialData,
  ) async {
    if (!globalIsLoggedIn) {
      await _handleAction();
    }

    if (globalIsLoggedIn &&
        _commentController.text.isNotEmpty &&
        socialData !=
            null) {
      setState(() {
        socialData.comments.insert(
          0,
          CommentData(
            username: "F1 Enthusiast",
            timeAgo: "Just now",
            content: _commentController.text,
            likes: 0,
          ),
        );
        _commentController.clear();
      });
      FocusScope.of(
        context,
      ).unfocus();
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

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
            widget.driverName.toLowerCase(),
      );
    } catch (
      e
    ) {
      socialData = null;
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.isMobile
            ? 24.0
            : 80.0,
        vertical: 40.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "FAN DISCUSSION",
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(
            height: 24,
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(
                0.05,
              ),
              borderRadius: BorderRadius.circular(
                30,
              ),
              border: Border.all(
                color: Colors.white24,
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: globalIsLoggedIn
                      ? const Color(
                          0xFFE8002D,
                        )
                      : Colors.grey,
                  child: const Icon(
                    Icons.person,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: globalIsLoggedIn
                          ? "Add a comment..."
                          : "Login to cheer for ${widget.driverName}...",
                      hintStyle: GoogleFonts.montserrat(
                        color: Colors.white38,
                      ),
                      border: InputBorder.none,
                    ),
                    onSubmitted:
                        (
                          _,
                        ) => _sendComment(
                          socialData,
                        ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: Color(
                      0xFFE8002D,
                    ),
                  ),
                  onPressed: () => _sendComment(
                    socialData,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),

          if (socialData ==
                  null ||
              socialData.comments.isEmpty)
            Text(
              "Be the first to start the discussion!",
              style: GoogleFonts.montserrat(
                color: Colors.white54,
              ),
            )
          else
            ...socialData.comments.map(
              (
                comment,
              ) => _buildComment(
                comment,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildComment(
    CommentData comment,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 24.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors
                .primaries[comment.username.length %
                    Colors.primaries.length]
                .withOpacity(
                  0.6,
                ),
            child: Text(
              comment.username[0].toUpperCase(),
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
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
                Row(
                  children: [
                    Text(
                      comment.username,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      comment.timeAgo,
                      style: GoogleFonts.montserrat(
                        color: Colors.white38,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  comment.content,
                  style: GoogleFonts.montserrat(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: _handleAction,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.thumb_up_alt_outlined,
                          color: Colors.white38,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          "${comment.likes} Likes",
                          style: GoogleFonts.montserrat(
                            color: Colors.white38,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        const Icon(
                          Icons.reply,
                          color: Colors.white38,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          "Reply",
                          style: GoogleFonts.montserrat(
                            color: Colors.white38,
                            fontSize: 12,
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
}
