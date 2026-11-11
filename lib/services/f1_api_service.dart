import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:drayve/data/data.dart' show listPembalap;
import 'package:drayve/models/statistik.dart';

class F1ApiService {
  F1ApiService({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 15),
              headers: {'Accept': 'application/json'},
            ));

  final Dio _dio;

  static const _standingsUrl =
      'https://api.jolpi.ca/ergast/f1/2026/driverstandings.json';
  static const _openF1DriversUrl = 'https://api.openf1.org/v1/drivers';

  Future<List<Statistik>> fetchDrivers({int sessionKey = 9158}) async {
    // 1) Klasemen (Jolpica / Ergast)
    final res = await _dio.get(_standingsUrl);
    final lists =
        res.data['MRData']['StandingsTable']['StandingsLists'] as List;
    if (lists.isEmpty) throw Exception('Klasemen 2026 belum tersedia');
    final standings = lists.first['DriverStandings'] as List;

    // 2) Info tim dari OpenF1 (opsional)
    final openF1ByAcronym = <String, Map<String, dynamic>>{};
    try {
      final r = await _dio
          .get(_openF1DriversUrl, queryParameters: {'session_key': sessionKey});
      for (final e in (r.data as List)) {
        final m = e as Map<String, dynamic>;
        final acr = m['name_acronym'] as String?;
        if (acr != null) openF1ByAcronym[acr] = m;
      }
    } on DioException catch (e) {
      debugPrint('OpenF1 gagal, pakai data Jolpica saja: $e');
    }

    // 3) Lookup aset lokal berdasarkan nama belakang
    final assetByLastName = {
      for (final s in listPembalap) _norm(s.nama.split(' ').last): s,
    };

    final result = <Statistik>[];
    for (final item in standings) {
      final j = item as Map<String, dynamic>;
      final d = j['Driver'] as Map<String, dynamic>;
      final code = (d['code'] as String?) ?? '';
      final old = assetByLastName[_norm(d['familyName'] as String)];
      if (old == null) {
        debugPrint('Tidak ada aset lokal untuk ${d['familyName']}, dilewati');
        continue;
      }

      final constructors = (j['Constructors'] as List?) ?? const [];
      final jolpicaTeam = constructors.isNotEmpty
          ? (constructors.last as Map<String, dynamic>)['name'] as String
          : old.tim;
      final team = _normalizeTeam(
          (openF1ByAcronym[code]?['team_name'] as String?) ?? jolpicaTeam);

      result.add(Statistik(
        id: old.id,
        nama: old.nama,
        negara: old.negara,
        fotoAset: old.fotoAset,
        tim: team,
        nomorMobil:
            int.tryParse('${d['permanentNumber']}') ?? old.nomorMobil,
        fotoMobil: old.fotoMobil,
        poinAwal: (double.tryParse('${j['points']}') ?? 0).round(),
        podiumAwal: old.podium,
        juaraDuniaAwal: old.juaraDunia,
      ));
    }
    return result;
  }

  static String _norm(String s) {
    const from = 'áàäâãéèëêíìïîóòöôõúùüûçñ';
    const to = 'aaaaaeeeeiiiiooooouuuucn';
    var out = s.toLowerCase();
    for (var i = 0; i < from.length; i++) {
      out = out.replaceAll(from[i], to[i]);
    }
    return out;
  }

  static String _normalizeTeam(String t) {
    final s = t.toLowerCase();
    if (s.contains('red bull')) return 'Red Bull Racing';
    if (s.contains('racing bulls') || s.startsWith('rb')) return 'Racing Bulls';
    if (s.contains('aston')) return 'Aston Martin';
    if (s.contains('mercedes')) return 'Mercedes';
    if (s.contains('ferrari')) return 'Ferrari';
    if (s.contains('mclaren')) return 'McLaren';
    if (s.contains('williams')) return 'Williams';
    if (s.contains('audi')) return 'Audi';
    if (s.contains('haas')) return 'Haas';
    if (s.contains('alpine')) return 'Alpine';
    if (s.contains('cadillac')) return 'Cadillac';
    return t;
  }
}