import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  // Fungsi untuk mengambil poin tim F1
  Future<
    Map<
      String,
      int
    >
  >
  getLiveTeamPoints() async {
    try {
      // Menembak endpoint klasemen konstruktor musim ini
      final response = await _dio.get(
        'https://api.jolpi.ca/ergast/f1/current/constructorStandings.json',
      );

      // Masuk ke dalam struktur JSON yang bertingkat
      final standings = response.data['MRData']['StandingsTable']['StandingsLists'][0]['ConstructorStandings'] as List;

      // Kita simpan dalam Map (Kamus) dengan format: {'ferrari': 358, 'mclaren': 306}
      Map<
        String,
        int
      >
      teamPoints = {};

      for (var teamData in standings) {
        String teamId = teamData['Constructor']['constructorId']; // contoh: 'ferrari', 'mclaren'
        int points = double.parse(
          teamData['points'],
        ).toInt();
        teamPoints[teamId] = points;
      }

      return teamPoints;
    } catch (
      e
    ) {
      print(
        "Gagal mengambil data API: $e",
      );
      return {}; // Kembalikan map kosong jika gagal (misal tidak ada internet)
    }
  }
}
