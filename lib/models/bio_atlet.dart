class BioAtlet {
  final String id;
  final String nama;
  final String negara;
  final String fotoAset;

  BioAtlet({required this.id, required this.nama, required this.negara, required this.fotoAset});

  String tampilkanProfil() {
    return "Atlet: $nama dari $negara";
  }
}
