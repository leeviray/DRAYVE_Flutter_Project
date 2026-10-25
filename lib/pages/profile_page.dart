import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:drayve/pages/landing_page.dart';
import 'package:drayve/widgets/animated_background.dart';

class ProfilePage
    extends
        StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<
    ProfilePage
  >
  createState() => _ProfilePageState();
}

class _ProfilePageState
    extends
        State<
          ProfilePage
        > {
  String currentName = "F1 Enthusiast";
  String currentEmail = "user@drayve.com";
  String? _photoBase64;
  bool _isUploading = false;

  final _formKey =
      GlobalKey<
        FormState
      >();
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    currentName =
        user?.displayName?.isNotEmpty ==
            true
        ? user!.displayName!
        : 'F1 Enthusiast';
    currentEmail =
        user?.email ??
        '';

    _nameController = TextEditingController(
      text: currentName,
    );
    _emailController = TextEditingController(
      text: currentEmail,
    );
    _loadProfile();
  }

  Future<
    void
  >
  _loadProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user ==
        null)
      return;
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection(
            'users',
          )
          .doc(
            user.uid,
          )
          .get();
      if (!mounted ||
          !snapshot.exists)
        return;

      final data = snapshot.data();
      setState(() {
        if (data?['name'] !=
            null) {
          currentName = data!['name'];
          _nameController.text = currentName;
        }
        if (data?['photoBase64'] !=
            null) {
          _photoBase64 = data!['photoBase64'];
        }
      });
    } catch (
      _
    ) {}
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // ==========================================
  // UPLOAD FOTO KE FIRESTORE (BASE64 - 100% GRATIS)
  // ==========================================
  Future<
    void
  >
  _pickAndUploadImage() async {
    final picker = ImagePicker();
    // Kompres kualitas agar ukurannya kecil dan muat di Firestore
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
      maxWidth: 300,
      maxHeight: 300,
    );

    if (image ==
        null)
      return;

    setState(
      () => _isUploading = true,
    );

    try {
      final user = FirebaseAuth.instance.currentUser!;
      final bytes = await image.readAsBytes();

      // Ubah gambar jadi string Base64
      final base64String = base64Encode(
        bytes,
      );

      // Simpan langsung ke Firestore dokumen pengguna
      await FirebaseFirestore.instance
          .collection(
            'users',
          )
          .doc(
            user.uid,
          )
          .set(
            {
              'photoBase64': base64String,
            },
            SetOptions(
              merge: true,
            ),
          );

      setState(() {
        _photoBase64 = base64String;
      });

      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content: Text(
            "Profile picture updated successfully!",
          ),
          backgroundColor: Colors.green,
        ),
      );
    } catch (
      e
    ) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content: Text(
            "Image size too large or failed to save.",
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted)
        setState(
          () => _isUploading = false,
        );
    }
  }

  Future<
    void
  >
  _sendPasswordReset() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) return;
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(
          content: Text(
            "Password reset link sent to $email",
            style: GoogleFonts.montserrat(),
          ),
          backgroundColor: Colors.blueAccent,
        ),
      );
    } catch (
      error
    ) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content: Text(
            "Error sending password reset link.",
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<
    void
  >
  _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    final user = FirebaseAuth.instance.currentUser;
    if (user ==
        null)
      return;
    try {
      final newName = _nameController.text.trim();
      final newEmail = _emailController.text.trim();
      await user.updateDisplayName(
        newName,
      );
      if (newEmail !=
          (user.email ??
              '')) {
        await user.verifyBeforeUpdateEmail(
          newEmail,
        );
      }
      await FirebaseFirestore.instance
          .collection(
            'users',
          )
          .doc(
            user.uid,
          )
          .set(
            {
              'uid': user.uid,
              'name': newName,
              'email': user.email,
              if (newEmail !=
                  (user.email ??
                      ''))
                'pendingEmail': newEmail,
              'updatedAt': FieldValue.serverTimestamp(),
            },
            SetOptions(
              merge: true,
            ),
          );
      if (!mounted) return;
      setState(() {
        currentName = newName;
        currentEmail =
            user.email ??
            '';
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(
          content: Text(
            "Profile updated successfully!",
            style: GoogleFonts.montserrat(),
          ),
          backgroundColor: const Color(
            0xFFE8002D,
          ),
        ),
      );
    } catch (
      error
    ) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content: Text(
            'Failed to update profile.',
          ),
        ),
      );
    }
  }

  Future<
    void
  >
  _logout() async {
    await FirebaseAuth.instance.signOut();
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      SnackBar(
        content: Text(
          "You have successfully logged out.",
          style: GoogleFonts.montserrat(),
        ),
        backgroundColor: Colors.orange,
      ),
    );
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (
          context,
        ) => const LandingPage(),
      ),
      (
        route,
      ) => false,
    );
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
    double formWidth = isMobile
        ? screenWidth *
              0.9
        : 600;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const Positioned.fill(
            child: AnimatedBackground(),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(
                24.0,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: () => Navigator.pop(
                  context,
                ),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                vertical: 24.0,
              ),
              child: Container(
                width: formWidth,
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
                    24,
                  ),
                  border: Border.all(
                    color: Colors.white12,
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(
                                  0xFFE8002D,
                                ),
                                width: 3,
                              ),
                            ),
                            child: ClipOval(
                              child:
                                  _photoBase64 !=
                                          null &&
                                      _photoBase64!.isNotEmpty
                                  ? Image.memory(
                                      base64Decode(
                                        _photoBase64!,
                                      ),
                                      fit: BoxFit.cover,
                                      width: 120,
                                      height: 120,
                                    )
                                  : Image.asset(
                                      'assets/images/default_profile.webp',
                                      fit: BoxFit.cover,
                                      width: 120,
                                      height: 120,
                                    ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: Color(
                                0xFFE8002D,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: _isUploading
                                ? const Padding(
                                    padding: EdgeInsets.all(
                                      12.0,
                                    ),
                                    child: SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  )
                                : IconButton(
                                    icon: const Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    onPressed: _pickAndUploadImage,
                                  ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 32,
                      ),

                      _buildTextField(
                        controller: _nameController,
                        icon: Icons.person_outline,
                        label: "Username",
                        validator:
                            (
                              value,
                            ) =>
                                value ==
                                        null ||
                                    value.isEmpty
                                ? 'Username cannot be empty'
                                : null,
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      _buildTextField(
                        controller: _emailController,
                        icon: Icons.email_outlined,
                        label: "Email Address",
                        validator:
                            (
                              value,
                            ) {
                              if (value ==
                                      null ||
                                  value.isEmpty)
                                return 'Email cannot be empty';
                              if (!value.contains(
                                '@',
                              ))
                                return 'Invalid email format';
                              return null;
                            },
                      ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: _sendPasswordReset,
                          child: Text(
                            "Reset Password?",
                            style: GoogleFonts.montserrat(
                              color: Colors.white54,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _saveProfile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(
                              0xFFE8002D,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 18,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                12,
                              ),
                            ),
                          ),
                          child: Text(
                            "SAVE CHANGES",
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),

                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: _logout,
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Colors.white38,
                              width: 2,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 18,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                12,
                              ),
                            ),
                          ),
                          child: Text(
                            "LOGOUT",
                            style: GoogleFonts.montserrat(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String label,
    String? Function(
      String?,
    )?
    validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            color: Colors.white54,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          controller: controller,
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 15,
          ),
          validator: validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(
              0.05,
            ),
            prefixIcon: Icon(
              icon,
              color: Colors.white54,
              size: 22,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                8,
              ),
              borderSide: const BorderSide(
                color: Colors.white12,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                8,
              ),
              borderSide: const BorderSide(
                color: Colors.white12,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                8,
              ),
              borderSide: const BorderSide(
                color: Color(
                  0xFFE8002D,
                ),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                8,
              ),
              borderSide: const BorderSide(
                color: Colors.redAccent,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
