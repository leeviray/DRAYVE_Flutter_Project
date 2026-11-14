/// Info circuit untuk halaman detail balapan (tab Circuits & About).
class RaceCircuitInfo {
  final String circuitName;
  final String location;
  final double lengthKm;
  final int firstGrandPrix;
  final int laps;
  final String? fastestLapTime; // contoh: '1:43.009' (null = belum ada)
  final String? fastestLapHolder; // contoh: 'Charles Leclerc (2019)'
  final double raceDistanceKm;
  final String trackMapPath; // gambar track map (opsional, belum ada asset)

  const RaceCircuitInfo({
    required this.circuitName,
    required this.location,
    required this.lengthKm,
    required this.firstGrandPrix,
    required this.laps,
    this.fastestLapTime,
    this.fastestLapHolder,
    required this.raceDistanceKm,
    required this.trackMapPath,
  });
}

/// Data pembalap untuk tabel Results.
class DriverInfo {
  final int number;
  final String fullName;
  final String team;

  const DriverInfo(this.number, this.fullName, this.team);
}

const Map<String, DriverInfo> kDriverInfo = {
  'RUS': DriverInfo(63, 'George Russell', 'Mercedes'),
  'ANT': DriverInfo(12, 'Kimi Antonelli', 'Mercedes'),
  'LEC': DriverInfo(16, 'Charles Leclerc', 'Ferrari'),
  'HAM': DriverInfo(44, 'Lewis Hamilton', 'Ferrari'),
  'PIA': DriverInfo(81, 'Oscar Piastri', 'McLaren'),
  'NOR': DriverInfo(1, 'Lando Norris', 'McLaren'),
  'VER': DriverInfo(3, 'Max Verstappen', 'Red Bull Racing'),
  'HAD': DriverInfo(6, 'Isack Hadjar', 'Red Bull Racing'),
};

/// Poin untuk P1 - P3.
const List<int> kPodiumPoints = [25, 18, 15];

/// Info circuit per round. Round yang belum ada datanya (mis. 16)
/// otomatis tampil "belum diisi" di halaman detail.
const Map<int, RaceCircuitInfo> kRaceCircuitInfo = {
  1: RaceCircuitInfo(
    circuitName: 'Albert Park Circuit',
    location: 'Melbourne, Australia',
    lengthKm: 5.278,
    firstGrandPrix: 1996,
    laps: 58,
    fastestLapTime: '1:19.813',
    fastestLapHolder: 'Charles Leclerc (2024)',
    raceDistanceKm: 306.124,
    trackMapPath: 'assets/images/circuits/australia_circuit.jpg',
  ),
  2: RaceCircuitInfo(
    circuitName: 'Shanghai International Circuit',
    location: 'Shanghai, China',
    lengthKm: 5.451,
    firstGrandPrix: 2004,
    laps: 56,
    fastestLapTime: '1:32.238',
    fastestLapHolder: 'Michael Schumacher (2004)',
    raceDistanceKm: 305.066,
    trackMapPath: 'assets/images/circuits/china_circuit.jpg',
  ),
  3: RaceCircuitInfo(
    circuitName: 'Suzuka International Racing Course',
    location: 'Suzuka, Japan',
    lengthKm: 5.807,
    firstGrandPrix: 1987,
    laps: 53,
    fastestLapTime: '1:30.983',
    fastestLapHolder: 'Lewis Hamilton (2019)',
    raceDistanceKm: 307.471,
    trackMapPath: 'assets/images/circuits/japan_circuit.jpg',
  ),
  4: RaceCircuitInfo(
    circuitName: 'Miami International Autodrome',
    location: 'Miami, United States',
    lengthKm: 5.412,
    firstGrandPrix: 2022,
    laps: 57,
    fastestLapTime: '1:29.708',
    fastestLapHolder: 'Max Verstappen (2023)',
    raceDistanceKm: 308.326,
    trackMapPath: 'assets/images/circuits/miami_circuit.jpg',
  ),
  5: RaceCircuitInfo(
    circuitName: 'Circuit Gilles Villeneuve',
    location: 'Montreal, Canada',
    lengthKm: 4.361,
    firstGrandPrix: 1978,
    laps: 70,
    fastestLapTime: '1:13.078',
    fastestLapHolder: 'Valtteri Bottas (2019)',
    raceDistanceKm: 305.270,
    trackMapPath: 'assets/images/circuits/canada_circuit.jpg',
  ),
  6: RaceCircuitInfo(
    circuitName: 'Circuit de Monaco',
    location: 'Monte Carlo, Monaco',
    lengthKm: 3.337,
    firstGrandPrix: 1950,
    laps: 78,
    fastestLapTime: '1:12.909',
    fastestLapHolder: 'Lewis Hamilton (2021)',
    raceDistanceKm: 260.286,
    trackMapPath: 'assets/images/circuits/monaco_circuit.jpg',
  ),
  7: RaceCircuitInfo(
    circuitName: 'Circuit de Barcelona-Catalunya',
    location: 'Barcelona, Spain',
    lengthKm: 4.657,
    firstGrandPrix: 1991,
    laps: 66,
    fastestLapTime: '1:16.330',
    fastestLapHolder: 'Max Verstappen (2023)',
    raceDistanceKm: 307.236,
    trackMapPath: 'assets/images/circuits/spain_circuit.jpg',
  ),
  8: RaceCircuitInfo(
    circuitName: 'Red Bull Ring',
    location: 'Spielberg, Austria',
    lengthKm: 4.318,
    firstGrandPrix: 1970,
    laps: 71,
    fastestLapTime: '1:05.619',
    fastestLapHolder: 'Carlos Sainz (2020)',
    raceDistanceKm: 306.452,
    trackMapPath: 'assets/images/circuits/austria_circuit.jpg',
  ),
  9: RaceCircuitInfo(
    circuitName: 'Silverstone Circuit',
    location: 'Silverstone, Great Britain',
    lengthKm: 5.891,
    firstGrandPrix: 1950,
    laps: 52,
    fastestLapTime: '1:27.097',
    fastestLapHolder: 'Max Verstappen (2020)',
    raceDistanceKm: 306.198,
    trackMapPath: 'assets/images/circuits/great_britain_circuit.jpg',
  ),
  10: RaceCircuitInfo(
    circuitName: 'Circuit de Spa-Francorchamps',
    location: 'Stavelot, Belgium',
    lengthKm: 7.004,
    firstGrandPrix: 1950,
    laps: 44,
    fastestLapTime: '1:46.286',
    fastestLapHolder: 'Valtteri Bottas (2018)',
    raceDistanceKm: 308.052,
    trackMapPath: 'assets/images/circuits/belgium_circuit.jpg',
  ),
  11: RaceCircuitInfo(
    circuitName: 'Hungaroring',
    location: 'Budapest, Hungary',
    lengthKm: 4.381,
    firstGrandPrix: 1986,
    laps: 70,
    fastestLapTime: '1:16.627',
    fastestLapHolder: 'Lewis Hamilton (2020)',
    raceDistanceKm: 306.63,
    trackMapPath: 'assets/images/circuits/hungary_circuit.jpg',
  ),
  12: RaceCircuitInfo(
    circuitName: 'Circuit Zandvoort',
    location: 'Zandvoort, Netherlands',
    lengthKm: 4.259,
    firstGrandPrix: 1952,
    laps: 72,
    fastestLapTime: '1:11.097',
    fastestLapHolder: 'Lewis Hamilton (2021)',
    raceDistanceKm: 306.587,
    trackMapPath: 'assets/images/circuits/netherlands_circuit.jpg',
  ),
  13: RaceCircuitInfo(
    circuitName: 'Autodromo Nazionale Monza',
    location: 'Monza, Italy',
    lengthKm: 5.793,
    firstGrandPrix: 1950,
    laps: 53,
    fastestLapTime: '1:21.046',
    fastestLapHolder: 'Rubens Barrichello (2004)',
    raceDistanceKm: 306.720,
    trackMapPath: 'assets/images/circuits/italy_circuit.jpg',
  ),
  14: RaceCircuitInfo(
    circuitName: 'Madring',
    location: 'Madrid, Spain',
    lengthKm: 5.414,
    firstGrandPrix: 2026,
    laps: 57,
    fastestLapTime: '1:35.587',
    fastestLapHolder: 'George Russell (2026)',
    raceDistanceKm: 308.399,
    trackMapPath: 'assets/images/circuits/madrid_circuit.jpg',
  ),
  15: RaceCircuitInfo(
    circuitName: 'Baku City Circuit',
    location: 'Baku, Azerbaijan',
    lengthKm: 6.003,
    firstGrandPrix: 2016,
    laps: 51,
    fastestLapTime: '1:43.009',
    fastestLapHolder: 'Charles Leclerc (2019)',
    raceDistanceKm: 306.049,
    trackMapPath: 'assets/images/circuits/azerbaijan_circuit.jpg',
  ),
  // 16: Bahrain -> belum diisi
  17: RaceCircuitInfo(
    circuitName: 'Marina Bay Street Circuit',
    location: 'Singapore',
    lengthKm: 4.940,
    firstGrandPrix: 2008,
    laps: 62,
    fastestLapTime: '1:35.867',
    fastestLapHolder: 'Lewis Hamilton (2023)',
    raceDistanceKm: 306.143,
    trackMapPath: 'assets/images/circuits/singapore_circuit.jpg',
  ),
  18: RaceCircuitInfo(
    circuitName: 'Circuit of the Americas',
    location: 'Austin, United States',
    lengthKm: 5.513,
    firstGrandPrix: 2012,
    laps: 56,
    fastestLapTime: '1:36.169',
    fastestLapHolder: 'Charles Leclerc (2019)',
    raceDistanceKm: 308.405,
    trackMapPath: 'assets/images/circuits/united_states_circuit.jpg',
  ),
  19: RaceCircuitInfo(
    circuitName: 'Autódromo Hermanos Rodríguez',
    location: 'Mexico City, Mexico',
    lengthKm: 4.304,
    firstGrandPrix: 2015,
    laps: 71,
    fastestLapTime: '1:17.774',
    fastestLapHolder: 'Valtteri Bottas (2021)',
    raceDistanceKm: 305.354,
    trackMapPath: 'assets/images/circuits/mexico_circuit.jpg',
  ),
  20: RaceCircuitInfo(
    circuitName: 'Autódromo José Carlos Pace (Interlagos)',
    location: 'São Paulo, Brazil',
    lengthKm: 4.309,
    firstGrandPrix: 1973,
    laps: 71,
    fastestLapTime: '1:10.540',
    fastestLapHolder: 'Valtteri Bottas (2018)',
    raceDistanceKm: 305.879,
    trackMapPath: 'assets/images/circuits/brazil_circuit.jpg',
  ),
};