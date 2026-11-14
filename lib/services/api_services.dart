import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:drayve/models/statistik.dart';

class DriverLiveInfo {
  final int points;
  final int position;
  final int wins;
  final int? driverNumber;
  final String? teamName;
  final String? headshotUrl;

  const DriverLiveInfo({this.points = 0, this.position = 0, this.wins = 0, this.driverNumber, this.teamName, this.headshotUrl});
}

class ApiService {
  static Future<Map<String, Map<String, dynamic>>>? _openF1CacheFuture;

  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(
        seconds: 10,
      ),
      receiveTimeout: const Duration(
        seconds: 10,
      ),
    ),
  );

  // Normalisasi nama agar pencocokan antara data.dart, Jolpica, dan OpenF1 akurat
  String _normalizeKey(
    String name,
  ) {
    return name
        .toLowerCase()
        .replaceAll(
          '\u00e9',
          'e',
        )
        .replaceAll(
          '\u00fc',
          'u',
        )
        .replaceAll(
          ' ',
          '_',
        )
        .trim();
  }

  /// Ambil URL foto headshot pembalap dari OpenF1 API (di-cache agar hanya 1x request).
  Future<String?> getOpenF1HeadshotUrl(String driverName) async {
    final trimmed = driverName.trim();
    if (trimmed.isEmpty) return null;

    _openF1CacheFuture ??= _fetchOpenF1Drivers().then((data) {
      if (data.isEmpty) {
        _openF1CacheFuture = null;
      }
      return data;
    });

    final openF1Data = await _openF1CacheFuture!;
    final fullKey = _normalizeKey(trimmed);
    final lastNameKey = _normalizeKey(trimmed.split(' ').last);
    final entry = openF1Data[fullKey] ?? openF1Data[lastNameKey];
    final headshot = entry?['headshot_url']?.toString();
    if (headshot == null || headshot.isEmpty) return null;
    // Hapus parameter fallback Cloudinary agar jika foto asli tidak ada,
    // HTTP 404 memicu fallback ke aset lokal (bukan gambar siluet abu-abu).
    return headshot
        .replaceAll('/d_driver_fallback_image.png', '')
        .replaceAll('1col/image.png', '3col/image.png');
  }

  /// 1. Ambil Poin Tim dari Jolpica API (Untuk TeamsPage)
  Future<
    Map<
      String,
      int
    >
  >
  getLiveTeamPoints() async {
    try {
      final response = await _dio.get(
        'https://api.jolpi.ca/ergast/f1/current/constructorStandings.json',
      );
      final lists = response.data['MRData']['StandingsTable']['StandingsLists'] as List;
      if (lists.isEmpty) return {};

      final standings = lists[0]['ConstructorStandings'] as List;
      final Map<
        String,
        int
      >
      livePoints = {};

      for (var item in standings) {
        final String constructorId = item['Constructor']['constructorId'];
        final int points =
            double.tryParse(
              item['points'].toString(),
            )?.toInt() ??
            0;
        livePoints[constructorId] = points;
      }
      return livePoints;
    } catch (
      e
    ) {
      debugPrint(
        '====== JOLPICA TEAM API ERROR: $e ======',
      );
      return {};
    }
  }

  /// 2. Integrasi Gabungan: Jolpica API (Klasemen/Poin) + OpenF1 API (Foto & Info Pembalap)
  Future<
    void
  >
  syncDriversWithApis(
    List<
      Statistik
    >
    localDrivers,
  ) async {
    try {
      // Jalankan request ke Jolpica dan OpenF1 secara paralel
      final results = await Future.wait([
        _fetchJolpicaDriverStandings(),
        _fetchOpenF1Drivers(),
      ]);

      final Map<
        String,
        Map<
          String,
          dynamic
        >
      >
      jolpicaData = results[0];
      final Map<
        String,
        Map<
          String,
          dynamic
        >
      >
      openF1Data = results[1];

      for (final driver in localDrivers) {
        final String fullKey = _normalizeKey(
          driver.nama,
        );
        final String lastNameKey = _normalizeKey(
          driver.nama
              .split(
                ' ',
              )
              .last,
        );

        // A. Terapkan data klasemen & poin dari Jolpica API
        final jData =
            jolpicaData[fullKey] ??
            jolpicaData[lastNameKey];
        if (jData !=
            null) {
          driver.poin =
              jData['points'] ??
              driver.poin;
          driver.posisi =
              jData['position'] ??
              driver.posisi;
          driver.menang =
              jData['wins'] ??
              driver.menang;
        }

        // B. Terapkan foto (headshot_url) dari OpenF1 API
        final oData =
            openF1Data[fullKey] ??
            openF1Data[lastNameKey];
        if (oData !=
            null) {
          final String? headshot = oData['headshot_url'];
          if (headshot !=
                  null &&
              headshot.isNotEmpty) {
            // Ubah ukuran transformasi URL F1 agar resolusinya tajam di kartu
            // dan hapus fallback siluet Cloudinary agar tetap memicu fallback lokal jika belum diunggah
            driver.fotoUrl = headshot
                .replaceAll('/d_driver_fallback_image.png', '')
                .replaceAll('1col/image.png', '3col/image.png');
          }
        }
      }
    } catch (
      e
    ) {
      debugPrint(
        '====== SYNC API ERROR: $e ======',
      );
    }
  }

  /// Helper: Tarik klasemen pembalap dari Jolpica API
  Future<
    Map<
      String,
      Map<
        String,
        dynamic
      >
    >
  >
  _fetchJolpicaDriverStandings() async {
    final Map<
      String,
      Map<
        String,
        dynamic
      >
    >
    map = {};
    try {
      final response = await _dio.get(
        'https://api.jolpi.ca/ergast/f1/current/driverStandings.json',
      );
      final lists = response.data['MRData']['StandingsTable']['StandingsLists'] as List;
      if (lists.isEmpty) return map;

      final standings = lists[0]['DriverStandings'] as List;
      for (var item in standings) {
        final driverObj = item['Driver'];
        final String givenName =
            driverObj['givenName'] ??
            '';
        final String familyName =
            driverObj['familyName'] ??
            '';
        final String fullKey = _normalizeKey(
          '$givenName $familyName',
        );
        final String lastKey = _normalizeKey(
          familyName,
        );

        final data = {
          'points':
              double.tryParse(
                item['points'].toString(),
              )?.toInt() ??
              0,
          'position':
              int.tryParse(
                item['position'].toString(),
              ) ??
              0,
          'wins':
              int.tryParse(
                item['wins'].toString(),
              ) ??
              0,
        };

        map[fullKey] = data;
        map[lastKey] = data;
      }
    } catch (
      e
    ) {
      debugPrint(
        'Jolpica Driver Standings Error: $e',
      );
    }
    return map;
  }

  /// Helper: Tarik data & foto pembalap dari OpenF1 API
  Future<
    Map<
      String,
      Map<
        String,
        dynamic
      >
    >
  >
  _fetchOpenF1Drivers() async {
    final Map<
      String,
      Map<
        String,
        dynamic
      >
    >
    map = {};
    try {
      final response = await _dio.get(
        'https://api.openf1.org/v1/drivers?session_key=latest',
      );
      if (response.data is List) {
        for (var item in (response.data as List)) {
          final String firstName =
              item['first_name'] ??
              '';
          final String lastName =
              item['last_name'] ??
              '';
          final String fullName =
              item['full_name'] ??
              '$firstName $lastName';

          final String fullKey = _normalizeKey(
            fullName,
          );
          final String lastKey = _normalizeKey(
            lastName,
          );

          final data = {
            'headshot_url': item['headshot_url']?.toString(),
            'driver_number': item['driver_number'],
            'team_name': item['team_name']?.toString(),
          };

          // Utamakan entri yang memiliki headshot_url tidak null
          if (!map.containsKey(
                fullKey,
              ) ||
              map[fullKey]?['headshot_url'] ==
                  null) {
            map[fullKey] = data;
          }
          if (!map.containsKey(
                lastKey,
              ) ||
              map[lastKey]?['headshot_url'] ==
                  null) {
            map[lastKey] = data;
          }
        }
      }
    } catch (
      e
    ) {
      debugPrint(
        'OpenF1 Drivers Error: $e',
      );
    }
    return map;
  }
}
