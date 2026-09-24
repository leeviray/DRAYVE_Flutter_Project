import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'widgets/custom_gradient_button.dart';

class LoginScreen
    extends
        StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<
    LoginScreen
  >
  createState() => _LoginScreenState();
}

class _LoginScreenState
    extends
        State<
          LoginScreen
        > {
  // TRUE = Menampilkan Form Login (Panel Sapaan di Kanan)
  // FALSE = Menampilkan Form Sign Up (Panel Sapaan geser ke Kiri)
  bool isLogin = false;

  final _formKey =
      GlobalKey<
        FormState
      >();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordHidden = true;

  void _handleLogin() {
    FocusScope.of(
      context,
    ).unfocus();
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(
          milliseconds: 800,
        ), // Durasi layar pindah dari signup ke landing page
        pageBuilder: (
          context,
          animation,
          secondaryAnimation,
        ) => HomeScreen(),
        transitionsBuilder:
            (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              var fadeAnimation =
                  Tween<
                        double
                      >(
                        begin: 0.0,
                        end: 1.0,
                      )
                      .animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOut,
                        ),
                      );
              var slideAnimation =
                  Tween<
                        Offset
                      >(
                        begin: const Offset(
                          0,
                          0.05,
                        ),
                        end: Offset.zero,
                      )
                      .animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOutCubic,
                        ),
                      );

              return FadeTransition(
                opacity: fadeAnimation,
                child: SlideTransition(
                  position: slideAnimation,
                  child: child,
                ),
              );
            },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    // Ukuran kotak utama login untuk tampilan web desktop
    double boxWidth = 1300;
    double boxHeight = 700;

    return Scaffold(
      backgroundColor: const Color(
        0xFF0F0F1A,
      ), // Background utama sangat gelap
      body: Center(
        child: Container(
          width: boxWidth,
          height: boxHeight,
          clipBehavior: Clip.hardEdge, // Agar panel yang bergeser tidak keluar dari sudut melengkung
          decoration: BoxDecoration(
            color: const Color(
              0xFF1E1E2E,
            ), // Background form abu-abu gelap
            borderRadius: BorderRadius.circular(
              24,
            ),
            boxShadow: [
              BoxShadow(
                color:
                    const Color(
                      0xFF7F5AF0,
                    ).withValues(
                      alpha: 0.2,
                    ), // Glow ungu
                blurRadius: 30,
                offset: const Offset(
                  0,
                  10,
                ),
              ),
            ],
          ),
          child: Stack(
            children: [
              // ==========================================
              // LAYER 1: AREA FORM SIGN IN & SIGN UP
              // ==========================================
              Row(
                children: [
                  // --- SISI KIRI: FORM SIGN IN ---
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                16,
                              ),
                              child: Image.asset(
                                'assets/nyell.png',
                                height: 70,
                                width: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Text(
                              "Sign In to DRAYVE",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Temukan mobil impianmu",
                              style: TextStyle(
                                color: Colors.grey[400],
                              ),
                            ),
                            const SizedBox(
                              height: 32,
                            ),

                            // Input Email Login
                            TextFormField(
                              controller: _emailController,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                hintText: "Email",
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                ),
                                prefixIcon: const Icon(
                                  Icons.email_outlined,
                                  color: Colors.grey,
                                ),
                                filled: true,
                                fillColor: const Color(
                                  0xFF0F0F1A,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    12,
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),

                            // Input Password Login
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _isPasswordHidden,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  color: Colors.grey,
                                ),
                                filled: true,
                                fillColor: const Color(
                                  0xFF0F0F1A,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    12,
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordHidden
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordHidden = !_isPasswordHidden;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Lupa password?",
                                  style: TextStyle(
                                    color: Color(
                                      0xFF2CB67F,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),

                            CustomGradientButton(
                              text: "SIGN IN",
                              onPressed: _handleLogin,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // --- SISI KANAN: FORM SIGN UP ---
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                              16,
                            ),
                            child: Image.asset(
                              'assets/nyell.png',
                              height: 70,
                              width: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            "Create Account",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Mulai perjalanan otomotifmu",
                            style: TextStyle(
                              color: Colors.grey[400],
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),

                          TextFormField(
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              hintText: "Full Name",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                              prefixIcon: const Icon(
                                Icons.person_outline,
                                color: Colors.grey,
                              ),
                              filled: true,
                              fillColor: const Color(
                                0xFF0F0F1A,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  12,
                                ),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),

                          TextFormField(
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: Colors.grey,
                              ),
                              filled: true,
                              fillColor: const Color(
                                0xFF0F0F1A,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  12,
                                ),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),

                          TextFormField(
                            obscureText: true,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                              prefixIcon: const Icon(
                                Icons.lock_outline,
                                color: Colors.grey,
                              ),
                              filled: true,
                              fillColor: const Color(
                                0xFF0F0F1A,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  12,
                                ),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),

                          CustomGradientButton(
                            text: "SIGN UP",
                            onPressed: () {
                              // Logika Sign Up (Bisa dikosongi dulu)
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // ==========================================
              // LAYER 2: PANEL GRADASI YANG BERGESER
              // ==========================================
              AnimatedPositioned(
                duration: const Duration(
                  milliseconds: 800,
                ), // Durasi animasi geser panel
                curve: Curves.easeInOutCubic,
                left: isLogin
                    ? (boxWidth /
                          2)
                    : 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width:
                      boxWidth /
                      2,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(
                          0xFF7F5AF0,
                        ),
                        Color(
                          0xFF2CB67F,
                        ),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isLogin
                                ? "Hallo LEKK!"
                                : "Welcome Back!",
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            isLogin
                                ? "Belum punya akun? Ayo daftar dulu biar bisa  akses semua fitur marketplace DRAYVE."
                                : "Sudah punya akun? Langsung login aja buat cari mobil impianmu hari ini.",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),

                          // Tombol Switch Transparan dengan border putih
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 18,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  30,
                                ),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                isLogin = !isLogin;
                              });
                            },
                            child: Text(
                              isLogin
                                  ? "DAFTAR SEKARANG"
                                  : "MASUK SEKARANG",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
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
        ),
      ),
    );
  }
}
