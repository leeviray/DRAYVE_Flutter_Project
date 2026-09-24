import 'bio_atlet.dart';

class Statistik
    extends
        BioAtlet {
  final String tim;
  final int nomorMobil;

  int _poin;
  int _podium;
  int _juaraDunia;

  Statistik({required super.id, required super.nama, required super.negara, required super.fotoAset, required this.tim, required this.nomorMobil, required int poinAwal, required int podiumAwal, required int juaraDuniaAwal})
    : _poin = poinAwal,
      _podium = podiumAwal,
      _juaraDunia = juaraDuniaAwal;

  int get poin => _poin;
  int get podium => _podium;
  int get juaraDunia => _juaraDunia;

  set poin(
    int nilaiBaru,
  ) {
    if (nilaiBaru >=
        0) {
      _poin = nilaiBaru;
    }
  }

  @override
  String tampilkanProfil() {
    return "Pembalap F1: $nama (No. $nomorMobil) dari tim $tim. Total Poin: $_poin";
  }
}
