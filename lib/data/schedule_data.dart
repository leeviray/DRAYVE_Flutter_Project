import 'package:flutter/material.dart';

/// Satu posisi podium (P1 / P2 / P3) pada sebuah balapan.
class RacePodium {
  final String driverCode; // contoh: 'RUS'
  final String result; // P1: waktu total, P2/P3: selisih

  const RacePodium(this.driverCode, this.result);
}

/// Satu balapan pada kalender F1 2026.
class ScheduleRace {
  final int round;
  final String countryCode; // kode ISO 2 huruf, untuk nama file bendera
  final String countryName;
  final String dateRange;
  final String raceName;
  final List<RacePodium> podium; // urut P1, P2, P3

  const ScheduleRace({
    required this.round,
    required this.countryCode,
    required this.countryName,
    required this.dateRange,
    required this.raceName,
    required this.podium,
  });
}

/// Warna tim untuk avatar pembalap (sementara sebelum foto pembalap ada).
const Map<String, Color> kDriverTeamColor = {
  'RUS': Color(0xFF27F4D2), // Mercedes
  'ANT': Color(0xFF27F4D2), // Mercedes
  'LEC': Color(0xFFE8002D), // Ferrari
  'HAM': Color(0xFFE8002D), // Ferrari
  'PIA': Color(0xFFFF8000), // McLaren
  'NOR': Color(0xFFFF8000), // McLaren
  'VER': Color(0xFF3671C6), // Red Bull
  'HAD': Color(0xFF3671C6), // Red Bull
};

/// 20 balapan: Round 1 (Australia) sampai Round 20 (Brazil).
const List<ScheduleRace> kScheduleRaces = [
  ScheduleRace(
    round: 1,
    countryCode: 'au',
    countryName: 'Australia',
    dateRange: '06 - 08 MAR',
    raceName: 'FORMULA 1 QATAR AIRWAYS AUSTRALIAN GRAND PRIX 2026',
    podium: [
      RacePodium('RUS', '1:23:06.801'),
      RacePodium('ANT', '+2.974'),
      RacePodium('LEC', '+15.519'),
    ],
  ),
  ScheduleRace(
    round: 2,
    countryCode: 'cn',
    countryName: 'China',
    dateRange: '13 - 15 MAR',
    raceName: 'FORMULA 1 HEINEKEN CHINESE GRAND PRIX 2026',
    podium: [
      RacePodium('ANT', '1:33:15.607'),
      RacePodium('RUS', '+5.515'),
      RacePodium('HAM', '+25.267'),
    ],
  ),
  ScheduleRace(
    round: 3,
    countryCode: 'jp',
    countryName: 'Japan',
    dateRange: '27 - 29 MAR',
    raceName: 'FORMULA 1 ARAMCO JAPANESE GRAND PRIX 2026',
    podium: [
      RacePodium('ANT', '1:28:03.403'),
      RacePodium('PIA', '+13.722'),
      RacePodium('LEC', '+15.27'),
    ],
  ),
  ScheduleRace(
    round: 4,
    countryCode: 'us',
    countryName: 'Miami',
    dateRange: '01 - 03 MAY',
    raceName: 'FORMULA 1 CRYPTO.COM MIAMI GRAND PRIX 2026',
    podium: [
      RacePodium('ANT', '1:33:19.273'),
      RacePodium('NOR', '+3.264'),
      RacePodium('PIA', '+27.092'),
    ],
  ),
  ScheduleRace(
    round: 5,
    countryCode: 'ca',
    countryName: 'Canada',
    dateRange: '22 - 24 MAY',
    raceName: 'FORMULA 1 LENOVO GRAND PRIX DU CANADA 2026',
    podium: [
      RacePodium('ANT', '1:28:15.758'),
      RacePodium('HAM', '+10.768'),
      RacePodium('VER', '+11.276'),
    ],
  ),
  ScheduleRace(
    round: 6,
    countryCode: 'mc',
    countryName: 'Monaco',
    dateRange: '05 - 07 JUN',
    raceName: 'FORMULA 1 LOUIS VUITTON GRAND PRIX DE MONACO 2026',
    podium: [
      RacePodium('ANT', '2:23:31.243'),
      RacePodium('HAM', '+6.271'),
      RacePodium('HAD', '+23.394'),
    ],
  ),
  ScheduleRace(
    round: 7,
    countryCode: 'es',
    countryName: 'Barcelona-Catalunya',
    dateRange: '12 - 14 JUN',
    raceName: 'FORMULA 1 MSC CRUISES GRAN PREMIO DE BARCELONA-CATALUNYA 2026',
    podium: [
      RacePodium('HAM', '1:32:28.105'),
      RacePodium('RUS', '+19.561'),
      RacePodium('NOR', '+23.719'),
    ],
  ),
  ScheduleRace(
    round: 8,
    countryCode: 'at',
    countryName: 'Austria',
    dateRange: '26 - 28 JUN',
    raceName: 'FORMULA 1 LENOVO AUSTRIAN GRAND PRIX 2026',
    podium: [
      RacePodium('RUS', '1:26:37.979'),
      RacePodium('VER', '+1.611'),
      RacePodium('ANT', '+1.986'),
    ],
  ),
  ScheduleRace(
    round: 9,
    countryCode: 'gb',
    countryName: 'Great Britain',
    dateRange: '03 - 05 JUL',
    raceName: 'FORMULA 1 PIRELLI BRITISH GRAND PRIX 2026',
    podium: [
      RacePodium('LEC', '1:27:11.335'),
      RacePodium('RUS', '+0.427'),
      RacePodium('HAM', '+0.772'),
    ],
  ),
  ScheduleRace(
    round: 10,
    countryCode: 'be',
    countryName: 'Belgium',
    dateRange: '17 - 19 JUL',
    raceName: 'FORMULA 1 MOËT & CHANDON BELGIAN GRAND PRIX 2026',
    podium: [
      RacePodium('ANT', '1:24:42.479'),
      RacePodium('LEC', '+1.952'),
      RacePodium('VER', '+11.586'),
    ],
  ),
  ScheduleRace(
    round: 11,
    countryCode: 'hu',
    countryName: 'Hungary',
    dateRange: '24 - 26 JUL',
    raceName: 'FORMULA 1 AWS HUNGARIAN GRAND PRIX 2026',
    podium: [
      RacePodium('NOR', '1:39:56.180'),
      RacePodium('VER', '+15.08'),
      RacePodium('ANT', '+18.728'),
    ],
  ),
  ScheduleRace(
    round: 12,
    countryCode: 'nl',
    countryName: 'Netherlands',
    dateRange: '21 - 23 AUG',
    raceName: 'FORMULA 1 HEINEKEN DUTCH GRAND PRIX 2026',
    podium: [
      RacePodium('NOR', '2:04:44.859'),
      RacePodium('ANT', '+11.536'),
      RacePodium('RUS', '+15.906'),
    ],
  ),
  ScheduleRace(
    round: 13,
    countryCode: 'it',
    countryName: 'Italy',
    dateRange: '04 - 06 SEP',
    raceName: 'FORMULA 1 PIRELLI GRAN PREMIO D\u2019ITALIA 2026',
    podium: [
      RacePodium('ANT', '1:51:15.281'),
      RacePodium('RUS', '+3.857'),
      RacePodium('VER', '+14.718'),
    ],
  ),
  ScheduleRace(
    round: 14,
    countryCode: 'es',
    countryName: 'Spain',
    dateRange: '11 - 13 SEP',
    raceName: 'FORMULA 1 TAG HEUER GRAN PREMIO DE ESPAÑA 2026',
    podium: [
      RacePodium('ANT', '1:34:23.754'),
      RacePodium('VER', '+4.351'),
      RacePodium('NOR', '+5.089'),
    ],
  ),
  ScheduleRace(
    round: 15,
    countryCode: 'az',
    countryName: 'Azerbaijan',
    dateRange: '24 - 26 SEP',
    raceName: 'FORMULA 1 QATAR AIRWAYS AZERBAIJAN GRAND PRIX 2026',
    podium: [
      RacePodium('RUS', '1:38:02.143'),
      RacePodium('VER', '+0.196'),
      RacePodium('HAD', '+10.704'),
    ],
  ),
  ScheduleRace(
    round: 16,
    countryCode: 'bh',
    countryName: 'Bahrain',
    dateRange: '02 - 04 OCT',
    raceName: 'FORMULA 1 GULF AIR BAHRAIN GRAND PRIX IN MALAYSIA 2026',
    podium: [
      RacePodium('VER', '1:47:14.808'),
      RacePodium('ANT', '+2.307'),
      RacePodium('HAM', '+4.919'),
    ],
  ),
  ScheduleRace(
    round: 17,
    countryCode: 'sg',
    countryName: 'Singapore',
    dateRange: '09 - 11 OCT',
    raceName: 'FORMULA 1 SINGAPORE AIRLINES SINGAPORE GRAND PRIX 2026',
    podium: [
      RacePodium('VER', '1:42:00.785'),
      RacePodium('LEC', '+7.335'),
      RacePodium('ANT', '+24.573'),
    ],
  ),
  ScheduleRace(
    round: 18,
    countryCode: 'us',
    countryName: 'United States',
    dateRange: '23 - 25 OCT',
    raceName: 'FORMULA 1 MSC CRUISES UNITED STATES GRAND PRIX 2026',
    podium: [
      RacePodium('ANT', '1:35:16.650'),
      RacePodium('LEC', '+13.078'),
      RacePodium('VER', '+17.485'),
    ],
  ),
  ScheduleRace(
    round: 19,
    countryCode: 'mx',
    countryName: 'Mexico',
    dateRange: '30 OCT - 01 NOV',
    raceName: 'FORMULA 1 GRAN PREMIO DE LA CIUDAD DE MÉXICO 2026',
    podium: [
      RacePodium('VER', '2:20:28.772'),
      RacePodium('HAM', '+0.799'),
      RacePodium('ANT', '+4.006'),
    ],
  ),
  ScheduleRace(
    round: 20,
    countryCode: 'br',
    countryName: 'Brazil',
    dateRange: '06 - 08 NOV',
    raceName: 'FORMULA 1 MSC CRUISES GRANDE PRÊMIO DE SÃO PAULO 2026',
    podium: [
      RacePodium('NOR', '1:35:23.504'),
      RacePodium('VER', '+14.602'),
      RacePodium('HAD', '+24.485'),
    ],
  ),
];