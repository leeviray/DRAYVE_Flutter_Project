import 'bio_atlet.dart';

class Statistik
    extends
        BioAtlet {
  final String tim;
  final int nomorMobil;
  final String fotoMobil; // Tetap memakai foto dari folder gelo

  int _poin;
  int _podium;
  int _juaraDunia;
  int _posisi; // Tambahan posisi klasemen dari Jolpica API
  int _menang; // Tambahan jumlah kemenangan dari Jolpica API

  Statistik({
    required super.id,
    required super.nama,
    required super.negara,
    required super.fotoAset,
    super.fotoUrl, // Menurunkan dari BioAtlet
    required this.tim,
    required this.nomorMobil,
    required this.fotoMobil,
    required int poinAwal,
    required int podiumAwal,
    required int juaraDuniaAwal,
    int posisiAwal = 0,
    int menangAwal = 0,
  }) : _poin = poinAwal,
       _podium = podiumAwal,
       _juaraDunia = juaraDuniaAwal,
       _posisi = posisiAwal,
       _menang = menangAwal;

  int get poin => _poin;
  int get podium => _podium;
  int get juaraDunia => _juaraDunia;
  int get posisi => _posisi;
  int get menang => _menang;

  set poin(
    int nilaiBaru,
  ) {
    if (nilaiBaru >=
        0)
      _poin = nilaiBaru;
  }

  set posisi(
    int nilaiBaru,
  ) {
    if (nilaiBaru >=
        0)
      _posisi = nilaiBaru;
  }

  set menang(
    int nilaiBaru,
  ) {
    if (nilaiBaru >=
        0)
      _menang = nilaiBaru;
  }

  @override
  String tampilkanProfil() {
    return "Pembalap F1: $nama (No. $nomorMobil) dari tim $tim. Total Poin: $_poin";
  }
}
