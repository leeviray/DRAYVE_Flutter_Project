// bio_karir.dart
// Data driver Formula 1 2026
// Sumber utama: https://www.formula1.com/en/drivers
//
// Catatan:
// Biography merupakan parafrasa/ringkasan lengkap berdasarkan
// informasi karier pada profil resmi Formula 1.

class DriverBio {
  final String id;
  final String name;
  final String nationality;
  final String team;
  final int number;
  final String dateOfBirth;
  final String placeOfBirth;
  final String biography;
  final String sourceUrl;

  const DriverBio({required this.id, required this.name, required this.nationality, required this.team, required this.number, required this.dateOfBirth, required this.placeOfBirth, required this.biography, required this.sourceUrl});
}

const List<
  DriverBio
>
bioKarir = [
  // ============================================================
  // MERCEDES
  // ============================================================

  DriverBio(
    id: 'george_russell',
    name: 'George Russell',
    nationality: 'United Kingdom',
    team: 'Mercedes',
    number: 63,
    dateOfBirth: '15/02/1998',
    placeOfBirth: "King's Lynn, England",
    biography: '''
George Russell memulai perjalanan balapnya sejak usia muda dan berkembang
melalui dunia karting sebelum melanjutkan ke berbagai kategori balap junior.

Ia kemudian memenangkan gelar GP3 Series pada 2017 setelah menunjukkan
kecepatan dan konsistensi yang kuat. Setahun kemudian ia melanjutkan
kesuksesannya di Formula 2 dan menjadi juara Formula 2 2018.

Performa tersebut membuat Russell masuk ke program junior Mercedes.
Pada 2019 ia mendapatkan kesempatan debut di Formula 1 bersama Williams.
Meskipun Williams pada periode tersebut berada di bagian belakang grid,
Russell secara bertahap menunjukkan kemampuan kualifikasi dan balapnya.

Pada 2020 Russell mendapatkan kesempatan menggantikan Lewis Hamilton
di Mercedes pada Grand Prix Sakhir. Ia tampil kompetitif dalam mobil
Mercedes dan hampir memenangkan balapan tersebut.

Russell kemudian meraih podium Formula 1 pertamanya pada 2021 bersama
Williams di Grand Prix Belgia. Pada 2022 ia resmi bergabung dengan
Mercedes sebagai rekan setim Lewis Hamilton.

Kemenangan Grand Prix pertamanya terjadi pada Grand Prix Sao Paulo 2022.
Russell juga membantu Mercedes meraih kemenangan pada Sprint di akhir
pekan tersebut.

Seiring berjalannya waktu, Russell menjadi salah satu pembalap utama
Mercedes. Ia melanjutkan perannya bersama tim pada era regulasi baru
Formula 1 2026.
''',
    sourceUrl: 'https://www.formula1.com/en/drivers/george-russell',
  ),

  DriverBio(
    id: 'kimi_antonelli',
    name: 'Kimi Antonelli',
    nationality: 'Italy',
    team: 'Mercedes',
    number: 12,
    dateOfBirth: '25/08/2006',
    placeOfBirth: 'Bologna, Italy',
    biography: '''
Andrea Kimi Antonelli berasal dari Bologna, Italia, dan mulai menarik
perhatian sejak berkompetisi di karting.

Ia kemudian masuk ke jenjang balap mobil dan menunjukkan perkembangan
yang sangat cepat. Pada 2022 ia memenangkan gelar Italian Formula 4
dan ADAC Formula 4.

Pada 2023 Antonelli melanjutkan perkembangannya ke Formula Regional.
Ia berhasil memenangkan gelar Formula Regional Middle East sekaligus
Formula Regional European Championship.

Mercedes kemudian memberikan dukungan kepadanya melalui program junior
mereka. Antonelli melanjutkan karier ke Formula 2 tanpa melalui jalur
Formula 3 secara penuh.

Performa kuatnya membuat Mercedes mempertimbangkannya sebagai calon
pembalap masa depan tim. Pada 2025 ia mendapatkan kursi Formula 1 bersama
Mercedes setelah Lewis Hamilton pindah ke Ferrari.

Musim rookie Antonelli menghasilkan sejumlah penampilan kuat dan podium.
Ia kemudian melanjutkan kariernya bersama Mercedes pada musim 2026.
''',
    sourceUrl: 'https://www.formula1.com/en/drivers/kimi-antonelli',
  ),

  // ============================================================
  // FERRARI
  // ============================================================
  DriverBio(
    id: 'charles_leclerc',
    name: 'Charles Leclerc',
    nationality: 'Monaco',
    team: 'Ferrari',
    number: 16,
    dateOfBirth: '16/10/1997',
    placeOfBirth: 'Monte Carlo, Monaco',
    biography: '''
Charles Leclerc lahir di Monte Carlo, Monaco, dan mulai berkompetisi
di karting sejak usia muda.

Ia berkembang melalui berbagai kategori junior dan kemudian mendapatkan
dukungan dari Ferrari Driver Academy. Leclerc memenangkan GP3 Series
pada 2016 sebelum melanjutkan ke Formula 2.

Pada musim Formula 2 2017, Leclerc tampil sangat dominan dan berhasil
merebut gelar juara. Performanya membuatnya mendapatkan kesempatan
untuk masuk Formula 1.

Leclerc melakukan debut Formula 1 bersama Sauber pada 2018. Ia segera
menunjukkan kemampuan yang kuat meskipun menggunakan mobil yang belum
berada di jajaran terdepan.

Pada 2019 Ferrari mempromosikannya ke tim utama untuk menjadi rekan
setim Sebastian Vettel. Pada tahun yang sama Leclerc meraih kemenangan
F1 pertamanya di Grand Prix Belgia.

Ia kemudian memenangkan Grand Prix Italia di Monza dan menjadi salah
satu pembalap utama Ferrari.

Leclerc terus berkembang sebagai pembalap Ferrari dan beberapa kali
bersaing untuk kemenangan serta posisi terdepan. Ia juga meraih
kemenangan di Grand Prix Monaco 2024, salah satu pencapaian penting
dalam kariernya karena Monaco merupakan negara asalnya.

Leclerc tetap menjadi bagian utama Ferrari pada musim 2026.
''',
    sourceUrl: 'https://www.formula1.com/en/drivers/charles-leclerc',
  ),

  DriverBio(
    id: 'lewis_hamilton',
    name: 'Lewis Hamilton',
    nationality: 'United Kingdom',
    team: 'Ferrari',
    number: 44,
    dateOfBirth: '07/01/1985',
    placeOfBirth: 'Stevenage, England',
    biography: '''
Lewis Hamilton lahir di Stevenage, Inggris, dan memulai karier balap
melalui karting.

Ia berkembang dengan sangat cepat dan kemudian mendapatkan dukungan
dari program junior McLaren. Hamilton berhasil memenangkan berbagai
kejuaraan junior sebelum mencapai Formula 1.

Hamilton melakukan debut Formula 1 bersama McLaren pada 2007. Dalam
musim rookie tersebut ia langsung menunjukkan kemampuan untuk
bersaing di posisi terdepan.

Pada 2008 Hamilton memenangkan gelar juara dunia Formula 1 pertamanya
bersama McLaren.

Pada 2013 Hamilton pindah ke Mercedes. Perpindahan tersebut menjadi
awal dari periode yang sangat sukses dalam kariernya.

Bersama Mercedes, Hamilton memenangkan sejumlah gelar dunia dan
mencatat banyak kemenangan, podium, serta pole position.

Ia kemudian menyamai rekor tujuh gelar juara dunia dan mencatat
berbagai rekor statistik Formula 1.

Setelah bertahun-tahun bersama Mercedes, Hamilton pindah ke Ferrari
mulai musim 2025. Kepindahan tersebut menjadi babak baru dalam
kariernya dan ia melanjutkan karier Formula 1 bersama Ferrari pada
musim 2026.
''',
    sourceUrl: 'https://www.formula1.com/en/drivers/lewis-hamilton',
  ),

  // ============================================================
  // MCLAREN
  // ============================================================
  DriverBio(
    id: 'lando_norris',
    name: 'Lando Norris',
    nationality: 'United Kingdom',
    team: 'McLaren',
    number: 1,
    dateOfBirth: '13/11/1999',
    placeOfBirth: 'Bristol, England',
    biography: '''
Lando Norris lahir di Bristol, Inggris, dan memulai karier balapnya
melalui karting.

Ia kemudian berpindah ke balap mobil dan dengan cepat menunjukkan
kemampuan yang kuat di berbagai kategori junior.

Norris bergabung dengan program junior McLaren dan mendapatkan
kesempatan melakukan pengujian Formula 1 sebelum mendapatkan kursi
balap penuh.

Ia melakukan debut Formula 1 bersama McLaren pada musim 2019.
Sejak musim pertamanya Norris menunjukkan kecepatan yang konsisten
dan mampu bersaing untuk poin.

Dalam beberapa musim berikutnya ia berkembang menjadi salah satu
pembalap utama McLaren. Norris mendapatkan podium Formula 1 pertamanya
dan secara bertahap semakin sering bersaing di bagian depan grid.

Kemenangan Grand Prix pertamanya datang pada 2024. Kemenangan tersebut
menjadi tonggak penting dalam kariernya.

Norris kemudian memenangkan gelar juara dunia Formula 1 pada 2025
bersama McLaren.

Pada musim 2026 ia melanjutkan kariernya bersama McLaren dengan nomor
mobil 1 sebagai juara dunia bertahan.
''',
    sourceUrl: 'https://www.formula1.com/en/drivers/lando-norris',
  ),

  DriverBio(
    id: 'oscar_piastri',
    name: 'Oscar Piastri',
    nationality: 'Australia',
    team: 'McLaren',
    number: 81,
    dateOfBirth: '06/04/2001',
    placeOfBirth: 'Melbourne, Australia',
    biography: '''
Oscar Piastri lahir di Melbourne, Australia, dan sejak kecil tertarik
pada dunia balap.

Ia memulai karier melalui karting sebelum berpindah ke balap mobil
di Eropa.

Piastri meraih gelar Formula Renault Eurocup sebelum melanjutkan ke
Formula 3. Ia kemudian memenangkan kejuaraan Formula 3.

Pada tahun berikutnya Piastri naik ke Formula 2 dan kembali memenangkan
gelar juara pada musim debutnya.

Prestasi tersebut menjadikannya salah satu pembalap junior paling
menonjol dan ia kemudian mendapatkan kursi Formula 1 bersama McLaren.

Piastri melakukan debut F1 pada 2023. Ia segera menunjukkan kemampuan
yang kuat dan meraih podium pada musim rookie.

Pada 2024 ia memenangkan Grand Prix pertamanya dan terus berkembang
sebagai salah satu pembalap utama McLaren.

Piastri kemudian menjadi bagian penting dari keberhasilan McLaren
pada musim-musim berikutnya dan tetap membalap untuk tim tersebut
pada musim 2026.
''',
    sourceUrl: 'https://www.formula1.com/en/drivers/oscar-piastri',
  ),

  // ============================================================
  // RED BULL RACING
  // ============================================================
  DriverBio(
    id: 'max_verstappen',
    name: 'Max Verstappen',
    nationality: 'Netherlands',
    team: 'Red Bull Racing',
    number: 3,
    dateOfBirth: '30/09/1997',
    placeOfBirth: 'Hasselt, Belgium',
    biography: '''
Max Verstappen lahir di Hasselt, Belgia, dan tumbuh dalam keluarga
yang sangat dekat dengan dunia motorsport. Ayahnya adalah mantan
pembalap Formula 1 Jos Verstappen.

Max mulai berkompetisi di karting sejak usia sangat muda dan berhasil
memenangkan berbagai kejuaraan karting.

Ia kemudian berpindah ke balap single-seater dan langsung menarik
perhatian karena kecepatannya.

Pada 2014 ia berkompetisi di Formula 3 dan menunjukkan performa yang
sangat kuat. Red Bull kemudian merekrutnya ke dalam program junior.

Verstappen melakukan debut Formula 1 pada 2015 bersama Toro Rosso
ketika masih berusia 17 tahun. Ia menjadi pembalap termuda yang
memulai balapan Formula 1.

Pada 2016 ia dipromosikan ke Red Bull Racing. Pada balapan pertamanya
bersama tim tersebut di Grand Prix Spanyol, Verstappen langsung
memenangkan balapan.

Kemenangan tersebut menjadikannya pemenang Grand Prix termuda dalam
sejarah Formula 1 pada saat itu.

Verstappen kemudian berkembang menjadi salah satu pembalap utama
Formula 1. Pada 2021 ia memenangkan gelar juara dunia pertamanya.

Ia kemudian mempertahankan gelarnya pada 2022 dan 2023, lalu kembali
menjadi juara dunia pada 2024.

Musim 2023 menjadi salah satu musim paling dominan dalam kariernya,
dengan 19 kemenangan dari 23 Grand Prix.

Verstappen tetap menjadi pembalap Red Bull Racing pada musim 2026.
''',
    sourceUrl: 'https://www.formula1.com/en/drivers/max-verstappen',
  ),

  DriverBio(
    id: 'isack_hadjar',
    name: 'Isack Hadjar',
    nationality: 'France',
    team: 'Red Bull Racing',
    number: 6,
    dateOfBirth: '28/09/2004',
    placeOfBirth: 'Paris, France',
    biography: '''
Isack Hadjar lahir di Paris, Prancis, dan berkembang melalui jenjang
balap junior Eropa.

Ia kemudian bergabung dengan program junior Red Bull dan melanjutkan
kariernya melalui Formula 3 serta Formula 2.

Hadjar mendapatkan reputasi sebagai pembalap yang cepat dan kompetitif
di kategori junior.

Pada 2025 ia mendapatkan kesempatan debut Formula 1 bersama Racing
Bulls. Musim rookie tersebut menjadi pengalaman penting baginya untuk
beradaptasi dengan tuntutan Formula 1.

Hadjar berhasil mendapatkan podium dan menunjukkan perkembangan yang
membuatnya semakin diperhitungkan dalam program Red Bull.

Pada musim 2026 ia mendapatkan promosi ke Red Bull Racing untuk
melanjutkan karier Formula 1 bersama tim utama.
''',
    sourceUrl: 'https://www.formula1.com/en/drivers/isack-hadjar',
  ),

  // ============================================================
  // RACING BULLS
  // ============================================================
  DriverBio(
    id: 'liam_lawson',
    name: 'Liam Lawson',
    nationality: 'New Zealand',
    team: 'Racing Bulls',
    number: 30,
    dateOfBirth: '11/02/2002',
    placeOfBirth: 'Hastings, New Zealand',
    biography: '''
Liam Lawson berasal dari Hastings, Selandia Baru, dan memulai karier
balap sejak usia muda.

Ia berkembang melalui berbagai kategori single-seater dan berhasil
memenangkan balapan di sejumlah kejuaraan junior.

Lawson kemudian bergabung dengan program junior Red Bull dan menjadi
salah satu pembalap cadangan mereka.

Kesempatan Formula 1 pertamanya datang pada 2023 ketika ia menggantikan
Daniel Ricciardo yang mengalami cedera. Lawson tampil dalam beberapa
Grand Prix dan berhasil mencetak poin.

Setelah mendapatkan pengalaman tersebut, ia memperoleh kesempatan
menjadi pembalap penuh pada 2025.

Ia sempat mendapatkan kursi di Red Bull Racing sebelum kembali ke
Racing Bulls.

Pada musim 2026 Lawson kembali membalap untuk Racing Bulls dan
melanjutkan pengalamannya di Formula 1.
''',
    sourceUrl: 'https://www.formula1.com/en/drivers/liam-lawson',
  ),

  DriverBio(
    id: 'arvid_lindblad',
    name: 'Arvid Lindblad',
    nationality: 'United Kingdom',
    team: 'Racing Bulls',
    number: 41,
    dateOfBirth: '08/08/2007',
    placeOfBirth: 'London, England',
    biography: '''
Arvid Lindblad lahir di London dan berkembang melalui dunia karting
sebelum bergabung dengan program junior Red Bull.

Ia menunjukkan perkembangan yang sangat cepat ketika berpindah ke
single-seater.

Lindblad mencatat hasil penting di Formula 3 dan Formula 2 dan menjadi
salah satu pembalap termuda yang memenangkan balapan di kedua kategori
tersebut.

Perkembangannya membuat Red Bull memberikan kesempatan kepadanya
untuk melakukan pengujian dan mendapatkan pengalaman menggunakan
mobil Formula 1.

Pada 2026 Lindblad mendapatkan kesempatan debut Formula 1 bersama
Racing Bulls.

Ia menjadi salah satu rookie termuda di grid Formula 1 musim 2026.
''',
    sourceUrl: 'https://www.formula1.com/en/drivers/arvid-lindblad',
  ),

  // ============================================================
  // ALPINE
  // ============================================================
  DriverBio(
    id: 'pierre_gasly',
    name: 'Pierre Gasly',
    nationality: 'France',
    team: 'Alpine',
    number: 10,
    dateOfBirth: '07/02/1996',
    placeOfBirth: 'Rouen, France',
    biography: '''
Pierre Gasly lahir di Rouen, Prancis, dan mulai berkompetisi di karting
sebelum melanjutkan ke berbagai kategori single-seater.

Ia kemudian masuk ke program Red Bull dan berkembang melalui jenjang
junior.

Gasly memenangkan gelar GP2 pada 2016 dan kemudian mendapatkan
kesempatan debut Formula 1 bersama Toro Rosso pada 2017.

Pada 2019 ia dipromosikan ke Red Bull Racing. Setelah periode tersebut,
Gasly kembali ke Toro Rosso yang kemudian berganti nama menjadi
AlphaTauri.

Puncak awal kariernya datang pada Grand Prix Italia 2020 ketika ia
meraih kemenangan Formula 1 pertamanya.

Kemenangan tersebut menjadi salah satu momen penting dalam karier
Gasly dan membuatnya semakin dikenal sebagai salah satu pembalap
kompetitif di grid.

Gasly kemudian bergabung dengan Alpine dan menjadi bagian penting
dari proyek tim tersebut.

Ia tetap membalap untuk Alpine pada musim 2026.
''',
    sourceUrl: 'https://www.formula1.com/en/drivers/pierre-gasly',
  ),

  DriverBio(
    id: 'franco_colapinto',
    name: 'Franco Colapinto',
    nationality: 'Argentina',
    team: 'Alpine',
    number: 43,
    dateOfBirth: '27/05/2003',
    placeOfBirth: 'Buenos Aires, Argentina',
    biography: '''
Franco Colapinto lahir di Buenos Aires, Argentina, dan memulai karier
balapnya sejak usia muda.

Ia kemudian berpindah ke Eropa untuk mengembangkan kariernya di berbagai
kategori balap junior.

Colapinto berhasil mencapai Formula 2 dan menunjukkan kemampuan yang
cukup untuk mendapatkan perhatian tim Formula 1.

Pada 2024 ia mendapatkan kesempatan debut Formula 1 bersama Williams
setelah menggantikan Logan Sargeant.

Colapinto mencetak poin dalam periode awalnya di Formula 1 dan menjadi
salah satu pembalap Argentina yang kembali mendapatkan perhatian besar
di kelas utama.

Setelah periode bersama Williams, Colapinto melanjutkan kariernya
bersama Alpine.

Ia tetap menjadi bagian dari Alpine pada musim Formula 1 2026.
''',
    sourceUrl: 'https://www.formula1.com/en/drivers/franco-colapinto',
  ),

  // ============================================================
  // HAAS
  // ============================================================
  DriverBio(
    id: 'esteban_ocon',
    name: 'Esteban Ocon',
    nationality: 'France',
    team: 'Haas F1 Team',
    number: 31,
    dateOfBirth: '17/09/1996',
    placeOfBirth: 'Évreux, France',
    biography: '''
Esteban Ocon berasal dari Évreux, Prancis, dan memulai perjalanan
balapnya melalui karting.

Ia kemudian berkembang melalui berbagai kategori junior sebelum
bergabung dengan program Mercedes.

Ocon melakukan debut Formula 1 pada 2016 dan kemudian membela Force
India, yang kemudian berkembang menjadi Racing Point.

Ia juga pernah membalap untuk Renault yang kemudian berubah menjadi
Alpine.

Pada Grand Prix Hungaria 2021 Ocon meraih kemenangan Formula 1
pertamanya. Kemenangan tersebut menjadi salah satu pencapaian terbesar
dalam kariernya.

Setelah beberapa musim bersama Alpine, Ocon pindah ke Haas untuk
musim 2025.

Ia kemudian melanjutkan kariernya bersama Haas pada musim 2026.
''',
    sourceUrl: 'https://www.formula1.com/en/drivers/esteban-ocon',
  ),

  DriverBio(
    id: 'oliver_bearman',
    name: 'Oliver Bearman',
    nationality: 'United Kingdom',
    team: 'Haas F1 Team',
    number: 87,
    dateOfBirth: '08/05/2005',
    placeOfBirth: 'Chelmsford, England',
    biography: '''
Oliver Bearman lahir di Chelmsford, Inggris, dan berkembang melalui
karting serta balap single-seater.

Ia kemudian bergabung dengan Ferrari Driver Academy dan melanjutkan
kariernya melalui Formula 3 dan Formula 2.

Bearman mendapatkan perhatian besar pada 2024 ketika ia melakukan
debut Formula 1 secara mendadak bersama Ferrari di Grand Prix Arab
Saudi.

Ia menggantikan Carlos Sainz yang tidak dapat mengikuti balapan.
Bearman mampu tampil kompetitif dan mencetak poin pada debutnya.

Ia kemudian mendapatkan beberapa kesempatan latihan Formula 1 sebelum
akhirnya mendapatkan kursi penuh bersama Haas.

Pada musim 2025 ia menjadi pembalap Haas dan melanjutkan kariernya
bersama tim tersebut pada musim 2026.
''',
    sourceUrl: 'https://www.formula1.com/en/drivers/oliver-bearman',
  ),

  // ============================================================
  // AUDI
  // ============================================================
  DriverBio(
    id: 'nico_hulkenberg',
    name: 'Nico Hulkenberg',
    nationality: 'Germany',
    team: 'Audi',
    number: 27,
    dateOfBirth: '19/08/1987',
    placeOfBirth: 'Emmerich am Rhein, Germany',
    biography: '''
Nico Hulkenberg adalah pembalap Jerman berpengalaman yang memulai
kariernya melalui karting dan berbagai kejuaraan junior.

Ia memenangkan GP2 Series pada 2009 sebelum naik ke Formula 1.

Hulkenberg melakukan debut F1 bersama Williams pada 2010.

Sepanjang kariernya ia membela berbagai tim, termasuk Force India,
Sauber, Renault, Racing Point, Aston Martin dan Haas.

Ia dikenal sebagai pembalap yang mampu menunjukkan kecepatan kuat
terutama dalam sesi kualifikasi.

Hulkenberg sempat meninggalkan grid penuh waktu dan menjalankan peran
sebagai pembalap cadangan sebelum kembali secara penuh.

Ia kemudian kembali membalap bersama Haas dan Kick Sauber.

Pada 2025 ia meraih podium Formula 1 pertamanya setelah bertahun-tahun
berkarier di kelas utama.

Mulai musim 2026 ia menjadi bagian dari proyek Audi Formula 1.
''',
    sourceUrl: 'https://www.formula1.com/en/drivers/nico-hulkenberg',
  ),

  DriverBio(
    id: 'gabriel_bortoleto',
    name: 'Gabriel Bortoleto',
    nationality: 'Brazil',
    team: 'Audi',
    number: 5,
    dateOfBirth: '14/10/2004',
    placeOfBirth: 'São Paulo, Brazil',
    biography: '''
Gabriel Bortoleto berasal dari São Paulo, Brasil, dan mulai membangun
kariernya melalui karting.

Ia kemudian pindah ke Eropa dan berkembang melalui kategori single-seater.

Bortoleto berhasil memenangkan Formula 3 dan kemudian melanjutkan
ke Formula 2.

Ia kembali tampil kuat dan berhasil merebut gelar Formula 2 sebelum
naik ke Formula 1.

Bortoleto kemudian bergabung dengan proyek Sauber yang selanjutnya
berkembang menjadi tim Audi.

Ia melakukan debut Formula 1 pada 2025 dan menjadi salah satu pembalap
Brasil generasi baru di grid.

Pada musim 2026 ia melanjutkan karier bersama Audi.
''',
    sourceUrl: 'https://www.formula1.com/en/drivers/gabriel-bortoleto',
  ),

  // ============================================================
  // WILLIAMS
  // ============================================================
  DriverBio(
    id: 'carlos_sainz',
    name: 'Carlos Sainz',
    nationality: 'Spain',
    team: 'Williams',
    number: 55,
    dateOfBirth: '01/09/1994',
    placeOfBirth: 'Madrid, Spain',
    biography: '''
Carlos Sainz lahir di Madrid, Spanyol, dan merupakan putra dari
pereli Carlos Sainz Sr.

Ia mengembangkan karier balap melalui karting dan berbagai kategori
junior.

Sainz bergabung dengan program Red Bull dan mendapatkan kesempatan
debut Formula 1 bersama Toro Rosso pada 2015.

Setelah itu ia membela Renault, McLaren dan Ferrari.

Bersama McLaren ia mulai menunjukkan perkembangan besar dan meraih
beberapa podium Formula 1.

Pada periode bersama Ferrari, Sainz meraih beberapa kemenangan
Grand Prix dan menjadi salah satu pembalap penting tim.

Ia kemudian pindah ke Williams untuk musim 2025.

Sainz melanjutkan kariernya bersama Williams pada musim 2026.
''',
    sourceUrl: 'https://www.formula1.com/en/drivers/carlos-sainz',
  ),

  DriverBio(
    id: 'alexander_albon',
    name: 'Alexander Albon',
    nationality: 'Thailand',
    team: 'Williams',
    number: 23,
    dateOfBirth: '23/03/1996',
    placeOfBirth: 'London, England',
    biography: '''
Alexander Albon lahir di London dan berkompetisi dengan lisensi
Thailand.

Ia memulai karier balap melalui karting dan berkembang melalui
berbagai kategori junior Eropa.

Albon kemudian bergabung dengan program Red Bull dan berhasil mencapai
Formula 1.

Ia melakukan debut pada 2019 bersama Toro Rosso.

Pada pertengahan musim tersebut ia dipromosikan ke Red Bull Racing.

Setelah periode bersama Red Bull, Albon menjadi pembalap cadangan
dan kemudian kembali ke grid bersama Williams.

Di Williams ia menjadi pembalap utama dan membantu tim berkembang
dalam beberapa musim.

Albon tetap membela Williams pada musim 2026.
''',
    sourceUrl: 'https://www.formula1.com/en/drivers/alexander-albon',
  ),

  // ============================================================
  // ASTON MARTIN
  // ============================================================
  DriverBio(
    id: 'fernando_alonso',
    name: 'Fernando Alonso',
    nationality: 'Spain',
    team: 'Aston Martin',
    number: 14,
    dateOfBirth: '29/07/1981',
    placeOfBirth: 'Oviedo, Spain',
    biography: '''
Fernando Alonso lahir di Oviedo, Spanyol, dan merupakan salah satu
pembalap paling berpengalaman dalam sejarah Formula 1.

Ia memulai karier melalui karting sebelum masuk ke berbagai kategori
single-seater.

Alonso melakukan debut Formula 1 pada 2001.

Ia kemudian bergabung dengan Renault dan memenangkan gelar juara dunia
pada 2005 dan 2006.

Setelah itu Alonso membela McLaren dan Ferrari dalam beberapa periode
berbeda.

Bersama Ferrari ia beberapa kali bersaing dalam perebutan gelar dunia.

Alonso juga memperluas kariernya ke ajang motorsport lain, termasuk
World Endurance Championship dan Indianapolis 500.

Ia kembali ke Formula 1 pada 2021 bersama Alpine.

Mulai 2023 Alonso bergabung dengan Aston Martin dan langsung
menghasilkan banyak podium.

Ia tetap menjadi bagian dari Aston Martin pada musim 2026.
''',
    sourceUrl: 'https://www.formula1.com/en/drivers/fernando-alonso',
  ),

  DriverBio(
    id: 'lance_stroll',
    name: 'Lance Stroll',
    nationality: 'Canada',
    team: 'Aston Martin',
    number: 18,
    dateOfBirth: '29/10/1998',
    placeOfBirth: 'Montreal, Canada',
    biography: '''
Lance Stroll lahir di Montreal, Kanada, dan memulai karier melalui
karting.

Ia kemudian berkembang melalui berbagai kategori junior dan meraih
kesuksesan di Formula 3.

Pada 2017 Stroll melakukan debut Formula 1 bersama Williams.

Dalam musim debutnya ia berhasil meraih podium pada Grand Prix
Azerbaijan.

Ia juga mencatat sejarah dengan menjadi salah satu pembalap termuda
yang mencapai baris depan grid pada periode awal kariernya.

Setelah Williams, Stroll bergabung dengan Racing Point.

Ketika Racing Point berubah menjadi Aston Martin, ia melanjutkan
karier bersama tim tersebut.

Stroll tetap menjadi pembalap Aston Martin pada musim 2026.
''',
    sourceUrl: 'https://www.formula1.com/en/drivers/lance-stroll',
  ),

  // ============================================================
  // CADILLAC
  // ============================================================
  DriverBio(
    id: 'sergio_perez',
    name: 'Sergio Perez',
    nationality: 'Mexico',
    team: 'Cadillac',
    number: 11,
    dateOfBirth: '26/01/1990',
    placeOfBirth: 'Guadalajara, Mexico',
    biography: '''
Sergio Perez lahir di Guadalajara, Meksiko, dan memulai karier
motorsport sejak usia muda.

Ia kemudian pindah ke Eropa untuk mengejar karier single-seater.

Perez berhasil mencapai Formula 1 dan melakukan debut bersama Sauber
pada 2011.

Ia kemudian membela McLaren, Force India, Racing Point dan Red Bull.

Sepanjang kariernya Perez dikenal memiliki kemampuan mengelola ban
dan mempertahankan performa dalam balapan jarak panjang.

Kemenangan Formula 1 pertamanya datang pada Grand Prix Sakhir 2020
bersama Racing Point.

Setelah itu ia bergabung dengan Red Bull Racing dan meraih beberapa
kemenangan serta podium tambahan.

Perez meninggalkan Formula 1 setelah musim 2024.

Pada 2026 ia kembali ke grid sebagai salah satu pembalap Cadillac,
bersama tim baru tersebut pada era masuknya Cadillac ke Formula 1.
''',
    sourceUrl: 'https://www.formula1.com/en/drivers/sergio-perez',
  ),

  DriverBio(
    id: 'valtteri_bottas',
    name: 'Valtteri Bottas',
    nationality: 'Finland',
    team: 'Cadillac',
    number: 77,
    dateOfBirth: '28/08/1989',
    placeOfBirth: 'Nastola, Finland',
    biography: '''
Valtteri Bottas lahir di Nastola, Finlandia, dan mulai berkompetisi
dalam karting sebelum berkembang melalui berbagai kategori junior.

Ia memenangkan berbagai kejuaraan junior dan kemudian mendapatkan
kesempatan masuk Formula 1 bersama Williams pada 2013.

Bottas menunjukkan performa yang konsisten dan kemudian mendapatkan
kesempatan bergabung dengan Mercedes pada 2017.

Bersama Mercedes ia meraih sejumlah kemenangan dan podium serta
membantu tim memenangkan beberapa gelar konstruktor.

Bottas juga menjadi salah satu pembalap yang beberapa kali meraih
pole position dan kemenangan Grand Prix selama periode bersama
Mercedes.

Setelah Mercedes, Bottas bergabung dengan Alfa Romeo/Sauber.

Ia kemudian mengambil peran sebagai pembalap cadangan setelah
meninggalkan kursi penuh waktu.

Pada musim 2026 Bottas kembali ke grid Formula 1 bersama Cadillac,
menjadi bagian dari proyek baru tim tersebut.
''',
    sourceUrl: 'https://www.formula1.com/en/drivers/valtteri-bottas',
  ),
];
