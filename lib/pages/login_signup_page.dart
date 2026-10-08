import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthPage
    extends
        StatefulWidget {
  const AuthPage({super.key});

  @override
  State<
    AuthPage
  >
  createState() => _AuthPageState();
}

class _AuthPageState
    extends
        State<
          AuthPage
        >
    with
        SingleTickerProviderStateMixin {
  bool isSignIn = true;
  bool _isSubmitting = false;

  final _signInEmailController = TextEditingController();
  final _signInPasswordController = TextEditingController();
  final _signUpNameController = TextEditingController();
  final _signUpEmailController = TextEditingController();
  final _signUpPasswordController = TextEditingController();

  // Kunci form untuk validasi
  final _signInFormKey =
      GlobalKey<
        FormState
      >();
  final _signUpFormKey =
      GlobalKey<
        FormState
      >();

  void toggleView() {
    setState(() {
      isSignIn = !isSignIn;
    });
  }

  @override
  void dispose() {
    _signInEmailController.dispose();
    _signInPasswordController.dispose();
    _signUpNameController.dispose();
    _signUpEmailController.dispose();
    _signUpPasswordController.dispose();
    super.dispose();
  }

  Future<
    void
  >
  _handleForgotPassword() async {
    final email = _signInEmailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content: Text(
            'Masukkan email terlebih dahulu.',
          ),
        ),
      );
      return;
    }
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content: Text(
            'Tautan reset password dikirim ke email.',
          ),
        ),
      );
    } on FirebaseAuthException catch (
      error
    ) {
      _showAuthError(
        error,
      );
    }
  }

  void _showAuthError(
    FirebaseAuthException error,
  ) {
    final message = switch (error.code) {
      'invalid-email' => 'Format email tidak valid.',
      'user-not-found' ||
      'invalid-credential' => 'Email atau password salah.',
      'wrong-password' => 'Email atau password salah.',
      'email-already-in-use' => 'Email ini sudah terdaftar.',
      'weak-password' => 'Password terlalu lemah. Gunakan minimal 6 karakter.',
      'operation-not-allowed' => 'Metode Email/Password belum diaktifkan di Firebase.',
      'network-request-failed' => 'Koneksi internet bermasalah. Coba lagi.',
      _ =>
        error.message ??
            'Terjadi kesalahan. Silakan coba lagi.',
    };
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.montserrat(),
        ),
        backgroundColor: const Color(
          0xFFE8002D,
        ),
        duration: const Duration(
          seconds: 4,
        ),
      ),
    );
  }

  Future<
    void
  >
  _submitSignIn() async {
    if (!_signInFormKey.currentState!.validate() ||
        _isSubmitting)
      return;
    setState(
      () => _isSubmitting = true,
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _signInEmailController.text.trim(),
        password: _signInPasswordController.text,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content: Text(
            "Login successful!",
          ),
          backgroundColor: Color(
            0xFFE8002D,
          ),
        ),
      );
      Navigator.pop(
        context,
        true,
      );
    } on FirebaseAuthException catch (
      error
    ) {
      _showAuthError(
        error,
      );
    } finally {
      if (mounted)
        setState(
          () => _isSubmitting = false,
        );
    }
  }
  

  Future<
    void
  >
  _submitSignUp() async {
    if (!_signUpFormKey.currentState!.validate() ||
        _isSubmitting)
      return;
    setState(
      () => _isSubmitting = true,
    );
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _signUpEmailController.text.trim(),
        password: _signUpPasswordController.text,
      );
      final user = credential.user;
      final name = _signUpNameController.text.trim();
      await user?.updateDisplayName(
        name,
      );
      if (user !=
          null) {
        await FirebaseFirestore.instance
            .collection(
              'users',
            )
            .doc(
              user.uid,
            )
            .set({
              'uid': user.uid,
              'name': name,
              'email': user.email,
              'createdAt': FieldValue.serverTimestamp(),
            });
      }
      // Keep the existing sign-up flow: create the account, then return to login.
      await FirebaseAuth.instance.signOut();
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content: Text(
            "Account created successfully! Please Login.",
          ),
          backgroundColor: Color(
            0xFFE8002D,
          ),
        ),
      );
      toggleView(); // Kembali ke panel login
    } on FirebaseAuthException catch (
      error
    ) {
      _showAuthError(
        error,
      );
    } catch (
      error
    ) {
      if (mounted) {
        try {
          await FirebaseAuth.instance.signOut();
        } catch (
          _
        ) {
          // Preserve the original profile-write error for the user.
        }
        _showAuthError(
          FirebaseAuthException(
            code: 'unknown',
            message: 'Akun mungkin sudah dibuat, tetapi profil gagal disimpan. Periksa Firestore Rules dan coba login.',
          ),
        );
      }
    } finally {
      if (mounted)
        setState(
          () => _isSubmitting = false,
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

    double formWidth = isMobile
        ? screenWidth *
              0.9
        : 900;
    double formHeight = isMobile
        ? 700
        : 650;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // ==========================================
          // 1. BACKGROUND SETEMA DENGAN LANDING PAGE
          // ==========================================
          Positioned.fill(
            child: Image.asset(
              'assets/images/bgdong.png',
              fit: BoxFit.cover,
              errorBuilder: (
                context,
                error,
                stackTrace,
              ) => const SizedBox(),
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
                errorBuilder: (
                  context,
                  error,
                  stackTrace,
                ) => const SizedBox(),
              ),
            ),
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
            child: Container(
              width: formWidth,
              height: formHeight,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(
                  0.75,
                ),
                borderRadius: BorderRadius.circular(
                  24,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(
                      0.5,
                    ),
                    blurRadius: 30,
                    offset: const Offset(
                      0,
                      15,
                    ),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  24,
                ),
                child: isMobile
                    ? _buildMobileView()
                    : _buildDesktopSlidingView(
                        formWidth,
                        formHeight,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopSlidingView(
    double width,
    double height,
  ) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          width:
              width /
              2,
          child: _buildSignInForm(),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          width:
              width /
              2,
          child: _buildSignUpForm(),
        ),
        AnimatedPositioned(
          duration: const Duration(
            milliseconds: 600,
          ),
          curve: Curves.easeInOutCubic,
          top: 0,
          bottom: 0,
          left: isSignIn
              ? width /
                    2
              : 0,
          width:
              width /
              2,
          child: Container(
            decoration: const BoxDecoration(
              color: Color(
                0xFFE8002D,
              ),
            ),
            child: Center(
              child: isSignIn
                  ? _buildOverlayRight()
                  : _buildOverlayLeft(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(
        32,
      ),
      child: isSignIn
          ? Column(
              children: [
                _buildSignInForm(),
                const SizedBox(
                  height: 32,
                ),
                const Divider(
                  color: Colors.white24,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Don't have an account?",
                  style: GoogleFonts.montserrat(
                    color: Colors.white54,
                  ),
                ),
                TextButton(
                  onPressed: toggleView,
                  child: Text(
                    "SIGN UP NOW",
                    style: GoogleFonts.montserrat(
                      color: const Color(
                        0xFFE8002D,
                      ),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          : Column(
              children: [
                _buildSignUpForm(),
                const SizedBox(
                  height: 32,
                ),
                const Divider(
                  color: Colors.white24,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Already have an account?",
                  style: GoogleFonts.montserrat(
                    color: Colors.white54,
                  ),
                ),
                TextButton(
                  onPressed: toggleView,
                  child: Text(
                    "LOGIN HERE",
                    style: GoogleFonts.montserrat(
                      color: const Color(
                        0xFFE8002D,
                      ),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildSignInForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40.0,
      ),
      child: Form(
        key: _signInFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Login to DRAYVE",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            _buildSocialIcons(),
            const SizedBox(
              height: 16,
            ),
            Text(
              "or use your email account",
              style: GoogleFonts.montserrat(
                color: Colors.white38,
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            _buildTextField(
              Icons.email_outlined,
              "Email",
              controller: _signInEmailController,
              validator:
                  (
                    value,
                  ) {
                    if (value ==
                            null ||
                        value.isEmpty)
                      return 'Please enter your email';
                    if (!value.contains(
                      '@',
                    ))
                      return 'Email must contain @';
                    return null;
                  },
            ),
            const SizedBox(
              height: 16,
            ),
            _buildTextField(
              Icons.lock_outline,
              "Password",
              controller: _signInPasswordController,
              isObscure: true,
              validator:
                  (
                    value,
                  ) {
                    if (value ==
                            null ||
                        value.isEmpty)
                      return 'Please enter your password';
                    if (value.length <
                        6)
                      return 'Password must be at least 6 characters';
                    return null;
                  },
            ),
            const SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: _handleForgotPassword,
                  child: Text(
                    "Forgot your password?",
                    style: GoogleFonts.montserrat(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            ElevatedButton(
              onPressed: _submitSignIn,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(
                  0xFFE8002D,
                ),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 48,
                  vertical: 18,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                ),
              ),
              child: Text(
                "LOGIN",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40.0,
      ),
      child: Form(
        key: _signUpFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Create Account",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            _buildSocialIcons(),
            const SizedBox(
              height: 16,
            ),
            Text(
              "or use email for registration",
              style: GoogleFonts.montserrat(
                color: Colors.white38,
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            _buildTextField(
              Icons.person_outline,
              "Name",
              controller: _signUpNameController,
              validator:
                  (
                    value,
                  ) {
                    if (value ==
                            null ||
                        value.isEmpty)
                      return 'Please enter your name';
                    return null;
                  },
            ),
            const SizedBox(
              height: 16,
            ),
            _buildTextField(
              Icons.email_outlined,
              "Email",
              controller: _signUpEmailController,
              validator:
                  (
                    value,
                  ) {
                    if (value ==
                            null ||
                        value.isEmpty)
                      return 'Please enter your email';
                    if (!value.contains(
                      '@',
                    ))
                      return 'Email must contain @';
                    return null;
                  },
            ),
            const SizedBox(
              height: 16,
            ),
            _buildTextField(
              Icons.lock_outline,
              "Password",
              controller: _signUpPasswordController,
              isObscure: true,
              validator:
                  (
                    value,
                  ) {
                    if (value ==
                            null ||
                        value.isEmpty)
                      return 'Please enter your password';
                    if (value.length <
                        6)
                      return 'Password must be at least 6 characters';
                    return null;
                  },
            ),
            const SizedBox(
              height: 32,
            ),
            ElevatedButton(
              onPressed: _submitSignUp,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(
                  0xFFE8002D,
                ),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 48,
                  vertical: 18,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                ),
              ),
              child: Text(
                "SIGN UP",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverlayRight() {
    return Padding(
      padding: const EdgeInsets.all(
        40.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Hello Friend!",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Enter your personal details and start your journey with us",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          OutlinedButton(
            onPressed: toggleView,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: Colors.white,
                width: 2,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 48,
                vertical: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  30,
                ),
              ),
            ),
            child: Text(
              "SIGN UP",
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverlayLeft() {
    return Padding(
      padding: const EdgeInsets.all(
        40.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Welcome Back!",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "To keep connected with us please login with your personal info",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          OutlinedButton(
            onPressed: toggleView,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: Colors.white,
                width: 2,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 48,
                vertical: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  30,
                ),
              ),
            ),
            child: Text(
              "LOGIN",
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildAssetIcon(
          'assets/icons/gikon.png',
        ),
        const SizedBox(
          width: 16,
        ),
        _buildAssetIcon(
          'assets/icons/mikon.png',
        ),
        const SizedBox(
          width: 16,
        ),
        _buildAssetIcon(
          'assets/icons/xikon.png',
        ),
      ],
    );
  }

  Widget _buildAssetIcon(
    String assetPath,
  ) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white24,
        ),
      ),
      child: Center(
        child: Image.asset(
          assetPath,
          width: 18,
          height: 18,
          color: Colors.white,
          errorBuilder:
              (
                context,
                error,
                stackTrace,
              ) => const Icon(
                Icons.broken_image,
                color: Colors.white54,
                size: 18,
              ),
        ),
      ),
    );
  }

  // PENYESUAIAN PADA _buildTextField UNTUK TEXTBOX YANG LEBIH BESAR
  Widget _buildTextField(
    IconData icon,
    String hint, {
    TextEditingController? controller,
    bool isObscure = false,
    String? Function(
      String?,
    )?
    validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      style: GoogleFonts.montserrat(
        color: Colors.white,
        fontSize: 15,
      ), // Ukuran font isian dinaikkan sedikit
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
        ), // Ikon sedikit dibesarkan agar proporsional
        hintText: hint,
        hintStyle: GoogleFonts.montserrat(
          color: Colors.white38,
          fontSize: 15,
        ),
        // Padding vertikal dinaikkan dari 16 ke 20 agar textbox makin lega/besar
        contentPadding: const EdgeInsets.symmetric(
          vertical: 20,
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
            color: Color.fromARGB(
              255,
              232,
              139,
              0,
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
        errorStyle: GoogleFonts.montserrat(
          color: Colors.redAccent,
          fontSize: 12,
        ),
      ),
    );
  }
}
