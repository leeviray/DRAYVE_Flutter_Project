import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drayve/data/auth_state.dart'; // Import status login global
import 'package:drayve/pages/landing_page.dart'; // Import landing page untuk navigasi

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

  final _formKey =
      GlobalKey<
        FormState
      >();
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: currentName,
    );
    _emailController = TextEditingController(
      text: currentEmail,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        currentName = _nameController.text;
        currentEmail = _emailController.text;
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
          duration: const Duration(
            seconds: 2,
          ),
        ),
      );
    }
  }

  // ==========================================
  // FUNGSI LOGOUT BARU
  // ==========================================
  void _logout() {
    // 1. Ubah status global menjadi false
    globalIsLoggedIn = false;

    // 2. Tampilkan pesan berhasil keluar
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      SnackBar(
        content: Text(
          "You have successfully logged out.",
          style: GoogleFonts.montserrat(),
        ),
        backgroundColor: Colors.orange, // Warna oranye agar beda dari error/success
        duration: const Duration(
          seconds: 2,
        ),
      ),
    );

    // 3. Kembali ke Landing Page dan bersihkan seluruh tumpukan halaman sebelumnya
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (
          context,
        ) => const LandingPage(),
      ),
      (
        Route<
          dynamic
        >
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Navigator.pop(
            context,
          ),
        ),
        title: Text(
          "MY PROFILE",
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.15,
              child: Image.asset(
                'assets/images/pattern.png',
                fit: BoxFit.cover,
                errorBuilder: (
                  context,
                  error,
                  stackTrace,
                ) => const SizedBox(),
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
                                      child: const Icon(
                                        Icons.person,
                                        color: Colors.white54,
                                        size: 60,
                                      ),
                                    ),
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
                            child: IconButton(
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20,
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Feature to upload image coming soon!",
                                    ),
                                  ),
                                );
                              },
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
                            ) {
                              if (value ==
                                      null ||
                                  value.isEmpty)
                                return 'Username cannot be empty';
                              return null;
                            },
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
                      const SizedBox(
                        height: 40,
                      ),

                      // TOMBOL SAVE
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

                      // ==========================================
                      // TOMBOL LOGOUT BARU
                      // ==========================================
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: _logout, // Memanggil fungsi logout di atas
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
