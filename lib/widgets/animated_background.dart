import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:drayve/styles/colors.dart';

/// Background animasi untuk halaman utama DRAYVE.
///
/// Terdiri dari 4 lapisan (dari paling belakang ke depan):
/// 1. Gradasi "bernapas"  -> beberapa gumpalan warna oranye–maroon yang
///    bergerak pelan (pengganti `bgdong.png` yang statis).
/// 2. Kolase F1 (`bgnice.png`) dengan opacity rendah sebagai tekstur.
/// 3. Speed streaks       -> garis cahaya yang melesat seperti efek kecepatan.
/// 4. Vignette            -> menggelapkan pinggir layar supaya kartu tetap
///    mudah dibaca.
///
/// Catatan performa:
/// - Waktu animasi disimpan di [ValueNotifier] dan dipakai langsung oleh
///   [CustomPainter] lewat parameter `repaint`. Jadi TIDAK ada `setState`
///   setiap frame, dan widget lain (grid kartu pembalap) tidak ikut rebuild.
/// - Setiap lapisan animasi dibungkus [RepaintBoundary] agar proses repaint
///   hanya terjadi di lapisan itu saja.
class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  /// Ticker memanggil callback setiap frame (±60x per detik).
  late final Ticker _ticker;

  /// Waktu berjalan dalam detik. Painter akan repaint setiap nilai ini berubah.
  final ValueNotifier<double> _time = ValueNotifier<double>(0);

  /// Menyimpan waktu terakhir saat ticker dihentikan, supaya ketika jalan
  /// lagi animasinya melanjutkan (tidak lompat kembali ke awal).
  double _timeOffset = 0;

  late final List<_Streak> _streaks;

  @override
  void initState() {
    super.initState();
    _streaks = _generateStreaks(count: 50);
    _ticker = createTicker((elapsed) {
      _time.value = _timeOffset + elapsed.inMicroseconds / 1e6;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Aksesibilitas: kalau user mengaktifkan "reduce motion" di perangkatnya,
    // animasi dihentikan dan background tampil sebagai gambar diam.
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    if (reduceMotion && _ticker.isActive) {
      _timeOffset = _time.value;
      _ticker.stop();
    } else if (!reduceMotion && !_ticker.isActive) {
      _ticker.start();
    }
  }

  @override
  void dispose() {
    // Wajib: hentikan ticker & notifier agar tidak terjadi memory leak.
    _ticker.dispose();
    _time.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Lapisan 1: gradasi bergerak
          RepaintBoundary(
            child: CustomPaint(
              painter: _GradientBlobPainter(time: _time),
            ),
          ),

          // Lapisan 2: kolase F1 sebagai tekstur samar (statis).
          // RepaintBoundary membuat lapisan ini cukup digambar sekali saja.
          RepaintBoundary(
            child: Opacity(
              opacity: 0.15,
              child: Image.asset(
                'assets/images/bgnice.png',
                fit: BoxFit.cover,
                color: Colors.black26,
                colorBlendMode: BlendMode.darken,
                errorBuilder: (context, error, stackTrace) =>
                    const SizedBox.shrink(),
              ),
            ),
          ),

          // Lapisan 3: speed streaks
          RepaintBoundary(
            child: CustomPaint(
              painter: _SpeedStreakPainter(time: _time, streaks: _streaks),
            ),
          ),

          // Lapisan 4: vignette agar konten tetap terbaca (statis)
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.15,
                colors: [Colors.transparent, Color(0x99000000)],
                stops: [0.45, 1.0],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Membuat daftar streak secara acak, tapi dengan seed tetap supaya
  /// tampilannya selalu sama setiap kali halaman dibuka.
  static List<_Streak> _generateStreaks({required int count}) {
    final rnd = math.Random(26);
    const palette = [
      Colors.white,
      Color(0xFFFFC46B), // kuning keemasan
      Color(0xFFFF8A00), // oranye
      AppColors.drayveRed, // merah khas DRAYVE
    ];
    return List.generate(count, (_) {
      return _Streak(
        y: rnd.nextDouble(),
        // pow(..., 1.6) membuat lebih banyak streak yang "jauh" (tipis & pelan)
        // dibanding yang "dekat" -> memberi kesan kedalaman (parallax).
        depth: math.pow(rnd.nextDouble(), 1.6).toDouble(),
        phase: rnd.nextDouble(),
        color: palette[rnd.nextInt(palette.length)],
      );
    });
  }
}

// ---------------------------------------------------------------------------
// LAPISAN 1 — Gradasi bergerak
// ---------------------------------------------------------------------------

/// Satu gumpalan warna (radial gradient) yang bergerak memutar pelan.
class _Blob {
  const _Blob({
    required this.color,
    required this.center,
    required this.drift,
    required this.radius,
    required this.period,
    required this.phase,
  });

  final Color color;

  /// Posisi dasar, relatif terhadap ukuran layar (0..1).
  final Offset center;

  /// Seberapa jauh gumpalan bergeser dari posisi dasarnya (0..1).
  final Offset drift;

  /// Jari-jari, relatif terhadap sisi layar terpanjang.
  final double radius;

  /// Lama satu putaran gerakan (detik). Makin besar makin pelan.
  final double period;

  /// Titik awal putaran (radian) agar gumpalan tidak bergerak serempak.
  final double phase;
}

class _GradientBlobPainter extends CustomPainter {
  _GradientBlobPainter({required this.time}) : super(repaint: time);

  final ValueNotifier<double> time;

  /// Warna dasar & gumpalan diambil dari palet `bgdong.png` sebelumnya,
  /// sehingga identitas warna DRAYVE tetap terjaga.
  static const Color _base = Color(0xFF2B0A0D);
  static const List<_Blob> _blobs = [
    _Blob(
      color: Color(0xFF8A4B0B), // oranye amber (kiri bawah)
      center: Offset(0.05, 0.95),
      drift: Offset(0.15, 0.10),
      radius: 0.75,
      period: 26,
      phase: 0,
    ),
    _Blob(
      color: Color(0xFF7A2812), // oranye bata (tengah)
      center: Offset(0.45, 0.45),
      drift: Offset(0.20, 0.15),
      radius: 0.70,
      period: 34,
      phase: 1.7,
    ),
    _Blob(
      color: Color(0xFF5C0418), // maroon (kanan atas)
      center: Offset(0.95, 0.15),
      drift: Offset(0.10, 0.20),
      radius: 0.80,
      period: 30,
      phase: 3.1,
    ),
    _Blob(
      color: Color(0x47E10600), // aksen merah DRAYVE, transparan
      center: Offset(0.75, 0.80),
      drift: Offset(0.25, 0.15),
      radius: 0.45,
      period: 22,
      phase: 4.4,
    ),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final t = time.value;
    final longestSide = size.longestSide;

    canvas.drawRect(Offset.zero & size, Paint()..color = _base);

    for (final blob in _blobs) {
      // Gerakan melingkar/elips memakai sin & cos (lintasan Lissajous).
      final angle = 2 * math.pi * t / blob.period + blob.phase;
      final center = Offset(
        (blob.center.dx + blob.drift.dx * math.sin(angle)) * size.width,
        (blob.center.dy + blob.drift.dy * math.cos(angle * 0.8)) * size.height,
      );
      final radius = blob.radius * longestSide;

      final paint = Paint()
        ..shader = RadialGradient(
          colors: [
            blob.color,
            blob.color.withValues(alpha: blob.color.a * 0.5),
            blob.color.withValues(alpha: 0),
          ],
          stops: const [0.0, 0.45, 1.0],
        ).createShader(Rect.fromCircle(center: center, radius: radius));

      canvas.drawCircle(center, radius, paint);
    }
  }

  // Repaint sudah dipicu oleh `time`, jadi tidak perlu repaint karena
  // perubahan konfigurasi.
  @override
  bool shouldRepaint(covariant _GradientBlobPainter oldDelegate) =>
      oldDelegate.time != time;
}

// ---------------------------------------------------------------------------
// LAPISAN 3 — Speed streaks
// ---------------------------------------------------------------------------

/// Data satu garis cahaya.
class _Streak {
  const _Streak({
    required this.y,
    required this.depth,
    required this.phase,
    required this.color,
  });

  /// Posisi vertikal (0 = atas, 1 = bawah).
  final double y;

  /// 0 = jauh (pelan, tipis, redup), 1 = dekat (cepat, tebal, terang).
  final double depth;

  /// Posisi awal horizontal (0..1) agar streak tidak muncul bersamaan.
  final double phase;

  final Color color;
}

class _SpeedStreakPainter extends CustomPainter {
  _SpeedStreakPainter({required this.time, required this.streaks})
      : super(repaint: time);

  final ValueNotifier<double> time;
  final List<_Streak> streaks;

  /// Interpolasi linier sederhana: a + (b - a) * t
  static double _lerp(double a, double b, double t) => a + (b - a) * t;

  @override
  void paint(Canvas canvas, Size size) {
    final t = time.value;

    // Di layar kecil streak dikurangi agar tidak terlalu ramai & lebih ringan.
    final count = size.width < 800 ? 28 : streaks.length;

    for (var i = 0; i < count && i < streaks.length; i++) {
      final s = streaks[i];

      // Semua ukuran bergantung pada `depth` -> efek parallax.
      final speed = _lerp(0.10, 0.65, s.depth) * size.width; // px per detik
      final length = _lerp(0.04, 0.22, s.depth) * size.width;
      final thickness = _lerp(0.6, 2.4, s.depth);
      final opacity = _lerp(0.10, 0.45, s.depth);

      // Kepala streak bergerak dari kiri ke kanan, lalu muncul lagi dari kiri
      // (pakai modulo). `travel` ditambah `length` supaya ekornya juga
      // sempat keluar layar sebelum muncul ulang.
      final travel = size.width + length;
      final headX = (s.phase * travel + speed * t) % travel;
      final tailX = headX - length;
      final y = s.y * size.height;

      final head = Offset(headX, y);
      final tail = Offset(tailX, y);
      final bounds = Rect.fromPoints(tail, head);

      // Glow: garis lebar & sangat transparan (lebih ringan daripada blur).
      final glowPaint = Paint()
        ..strokeWidth = thickness * 4
        ..strokeCap = StrokeCap.round
        ..shader = LinearGradient(
          colors: [
            s.color.withValues(alpha: 0),
            s.color.withValues(alpha: opacity * 0.25),
          ],
        ).createShader(bounds);
      canvas.drawLine(tail, head, glowPaint);

      // Inti garis: memudar dari ekor (transparan) ke kepala (terang).
      final corePaint = Paint()
        ..strokeWidth = thickness
        ..strokeCap = StrokeCap.round
        ..shader = LinearGradient(
          colors: [
            s.color.withValues(alpha: 0),
            s.color.withValues(alpha: opacity),
          ],
        ).createShader(bounds);
      canvas.drawLine(tail, head, corePaint);

      // Streak yang "dekat" diberi titik terang di kepalanya.
      if (s.depth > 0.7) {
        canvas.drawCircle(
          head,
          thickness * 1.1,
          Paint()..color = Colors.white.withValues(alpha: opacity),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _SpeedStreakPainter oldDelegate) =>
      oldDelegate.time != time || oldDelegate.streaks != streaks;
}
