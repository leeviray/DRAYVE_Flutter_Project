import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  final TextEditingController _messageController = TextEditingController();
  bool _isSending = false;

  Future<
    void
  >
  _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser ==
        null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(
          content: Text(
            'You must be logged in to join the discussion!',
            style: GoogleFonts.montserrat(),
          ),
          backgroundColor: const Color(
            0xFFE8002D,
          ),
        ),
      );
      return;
    }

    setState(
      () => _isSending = true,
    );

    try {
      await FirebaseFirestore.instance
          .collection(
            'driver_discussions',
          )
          .doc(
            widget.driverName,
          )
          .collection(
            'messages',
          )
          .add({
            'uid': currentUser.uid,
            'userName':
                currentUser.displayName ??
                'F1 Fan',
            'photoURL':
                currentUser.photoURL ??
                '', // Menyimpan foto profil pengguna
            'text': text,
            'timestamp': FieldValue.serverTimestamp(),
          });

      _messageController.clear();
    } catch (
      e
    ) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to send message.',
            style: GoogleFonts.montserrat(),
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      if (mounted)
        setState(
          () => _isSending = false,
        );
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final paddingH = widget.isMobile
        ? 24.0
        : 80.0;
    final currentUser = FirebaseAuth.instance.currentUser;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: paddingH,
        vertical: 40.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "FAN DISCUSSION",
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: widget.isMobile
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
            "Share your thoughts about ${widget.driverName}",
            style: GoogleFonts.montserrat(
              color: Colors.white54,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 32,
          ),

          Container(
            height: 400,
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
              children: [
                Expanded(
                  child:
                      StreamBuilder<
                        QuerySnapshot
                      >(
                        stream: FirebaseFirestore.instance
                            .collection(
                              'driver_discussions',
                            )
                            .doc(
                              widget.driverName,
                            )
                            .collection(
                              'messages',
                            )
                            .orderBy(
                              'timestamp',
                              descending: true,
                            )
                            .snapshots(),
                        builder:
                            (
                              context,
                              snapshot,
                            ) {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text(
                                    'Error loading discussions.',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                );
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Color(
                                      0xFFE10600,
                                    ),
                                  ),
                                );
                              }

                              final docs =
                                  snapshot.data?.docs ??
                                  [];

                              if (docs.isEmpty) {
                                return Center(
                                  child: Text(
                                    'No discussions yet. Be the first to comment!',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white54,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                );
                              }

                              return ListView.builder(
                                reverse: true,
                                padding: const EdgeInsets.all(
                                  24,
                                ),
                                itemCount: docs.length,
                                itemBuilder:
                                    (
                                      context,
                                      index,
                                    ) {
                                      final data =
                                          docs[index].data()
                                              as Map<
                                                String,
                                                dynamic
                                              >;
                                      final isMe =
                                          currentUser !=
                                              null &&
                                          data['uid'] ==
                                              currentUser.uid;
                                      final photoUrl =
                                          data.containsKey(
                                            'photoURL',
                                          )
                                          ? data['photoURL'] as String?
                                          : null;

                                      return _buildChatBubble(
                                        userName:
                                            data['userName'] ??
                                            'Anonymous',
                                        text:
                                            data['text'] ??
                                            '',
                                        photoUrl: photoUrl,
                                        isMe: isMe,
                                      );
                                    },
                              );
                            },
                      ),
                ),

                Container(
                  padding: const EdgeInsets.all(
                    16,
                  ),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.white12,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                          ),
                          onSubmitted: (
                            _,
                          ) => _sendMessage(),
                          decoration: InputDecoration(
                            hintText:
                                currentUser ==
                                    null
                                ? "Login to join the discussion..."
                                : "Type your message...",
                            hintStyle: GoogleFonts.montserrat(
                              color: Colors.white38,
                            ),
                            filled: true,
                            fillColor: Colors.black.withOpacity(
                              0.5,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 14,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                30,
                              ),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          enabled:
                              currentUser !=
                              null,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      GestureDetector(
                        onTap: _isSending
                            ? null
                            : _sendMessage,
                        child: Container(
                          padding: const EdgeInsets.all(
                            14,
                          ),
                          decoration: BoxDecoration(
                            color:
                                currentUser ==
                                    null
                                ? Colors.grey[800]
                                : const Color(
                                    0xFFE10600,
                                  ),
                            shape: BoxShape.circle,
                          ),
                          child: _isSending
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(
                                  Icons.send_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }

  Widget _buildChatBubble({
    required String userName,
    required String text,
    String? photoUrl,
    required bool isMe,
  }) {
    // Menentukan tampilan Avatar
    Widget avatar = CircleAvatar(
      backgroundColor: isMe
          ? const Color(
              0xFFE10600,
            ).withOpacity(
              0.5,
            )
          : Colors.white12,
      backgroundImage:
          (photoUrl !=
                  null &&
              photoUrl.isNotEmpty)
          ? NetworkImage(
              photoUrl,
            )
          : null,
      child:
          (photoUrl ==
                  null ||
              photoUrl.isEmpty)
          ? Text(
              userName.isNotEmpty
                  ? userName[0].toUpperCase()
                  : '?',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
    );

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20.0,
      ),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe) ...[
            avatar,
            const SizedBox(
              width: 12,
            ),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  isMe
                      ? "You"
                      : userName,
                  style: GoogleFonts.montserrat(
                    color: Colors.white54,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isMe
                        ? const Color(
                            0xFFE10600,
                          )
                        : Colors.white.withOpacity(
                            0.05,
                          ),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(
                        16,
                      ),
                      topRight: const Radius.circular(
                        16,
                      ),
                      bottomLeft: Radius.circular(
                        isMe
                            ? 16
                            : 0,
                      ),
                      bottomRight: Radius.circular(
                        isMe
                            ? 0
                            : 16,
                      ),
                    ),
                  ),
                  child: Text(
                    text,
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isMe) ...[
            const SizedBox(
              width: 12,
            ),
            avatar,
          ],
        ],
      ),
    );
  }
}
