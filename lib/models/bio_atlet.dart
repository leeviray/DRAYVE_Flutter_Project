class BioAtlet {
  final String id;
  final String nama;
  final String negara;
  final String fotoAset;
  String? fotoUrl; // Tambahan untuk foto dari OpenF1 API

  BioAtlet({required this.id, required this.nama, required this.negara, required this.fotoAset, this.fotoUrl});

  String tampilkanProfil() {
    return "Atlet: $nama dari $negara";
  }
}
