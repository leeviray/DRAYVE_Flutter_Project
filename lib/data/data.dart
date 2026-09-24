import '../models/statistik.dart';

// Array (List) untuk menyimpan kumpulan object data pembalap
List<
  Statistik
>
listPembalap = [
  Statistik(
    id: "drv_01",
    nama: "Max Verstappen",
    negara: "Belanda",
    tim: "Red Bull Racing",
    nomorMobil: 1,
    poinAwal: 410,
    podiumAwal: 98,
    juaraDuniaAwal: 3,
    fotoAset: "assets/images/verstappen.png", // Nanti siapkan file fotonya dengan nama ini
  ),
  Statistik(
    id: "drv_02",
    nama: "Lewis Hamilton",
    negara: "Inggris Raya",
    tim: "Ferrari",
    nomorMobil: 44,
    poinAwal: 250,
    podiumAwal: 197,
    juaraDuniaAwal: 7,
    fotoAset: "assets/images/hamilton.png",
  ),
  Statistik(
    id: "drv_03",
    nama: "Charles Leclerc",
    negara: "Monako",
    tim: "Ferrari",
    nomorMobil: 16,
    poinAwal: 280,
    podiumAwal: 30,
    juaraDuniaAwal: 0,
    fotoAset: "assets/images/leclerc.png",
  ),
  Statistik(
    id: "drv_04",
    nama: "Lando Norris",
    negara: "Inggris Raya",
    tim: "McLaren",
    nomorMobil: 4,
    poinAwal: 295,
    podiumAwal: 15,
    juaraDuniaAwal: 0,
    fotoAset: "assets/images/norris.png",
  ),
];
