import 'package:flutter/material.dart';

import 'login_screen.dart';

class HomeScreen
    extends
        StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<
    HomeScreen
  >
  createState() => _HomeScreenState();
}

class _HomeScreenState
    extends
        State<
          HomeScreen
        > {
  // Fungsi navigasi ke halaman Login saat user menekan "Masuk" atau "Daftar"
  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(
          milliseconds: 400,
        ),
        pageBuilder: (
          context,
          animation,
          secondaryAnimation,
        ) => const LoginScreen(), // Hapus 'const' jika compiler web error lagi
        transitionsBuilder:
            (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
      ),
    );
  }

  // Data Dummy Produk Mobil
  final List<
    Map<
      String,
      dynamic
    >
  >
  carProducts = [
    {
      'name': 'Honda Civic RS 1.5 Turbo',
      'price': 'Rp 539 Juta',
      'year': '2023',
      'mileage': '15.000 km',
      'location': 'Jakarta Selatan',
      'condition': 'Bekas',
      'imageUrl': 'https://images.unsplash.com/photo-1605559424843-9e4c228bf1c2?q=80&w=600&auto=format&fit=crop',
    },
    {
      'name': 'Toyota Fortuner 2.8 GR Sport',
      'price': 'Rp 624 Juta',
      'year': '2022',
      'mileage': '32.000 km',
      'location': 'Surabaya',
      'condition': 'Bekas',
      'imageUrl': 'https://images.unsplash.com/photo-1590362891991-f776e747a588?q=80&w=600&auto=format&fit=crop',
    },
    {
      'name': 'Hyundai Ioniq 5 Signature',
      'price': 'Rp 748 Juta',
      'year': '2024',
      'mileage': '0 km',
      'location': 'Tangerang',
      'condition': 'Baru',
      'imageUrl': 'https://images.unsplash.com/photo-1662908852329-3733ba868172?q=80&w=600&auto=format&fit=crop',
    },
    {
      'name': 'BMW 320i M Sport',
      'price': 'Rp 1.13 Miliar',
      'year': '2023',
      'mileage': '8.500 km',
      'location': 'Jakarta Barat',
      'condition': 'Bekas',
      'imageUrl': 'https://images.unsplash.com/photo-1555353540-64fd8b373cae?q=80&w=600&auto=format&fit=crop',
    },
    {
      'name': 'Wuling Air EV Long Range',
      'price': 'Rp 238 Juta',
      'year': '2024',
      'mileage': '0 km',
      'location': 'Bandung',
      'condition': 'Baru',
      'imageUrl': 'https://images.unsplash.com/photo-1678857597148-735957b98d25?q=80&w=600&auto=format&fit=crop',
    },
    {
      'name': 'Mitsubishi Pajero Dakar',
      'price': 'Rp 577 Juta',
      'year': '2021',
      'mileage': '45.000 km',
      'location': 'Semarang',
      'condition': 'Bekas',
      'imageUrl': 'https://images.unsplash.com/photo-1629897048514-3dd741427278?q=80&w=600&auto=format&fit=crop',
    },
  ];

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: const Color(
        0xFF0F0F1A,
      ),
      body: Column(
        children: [
          // ==========================================
          // 1. HEADER (TOP NAVIGATION BAR) - Referensi Tokopedia
          // ==========================================
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: const Color(
                0xFF1E1E2E,
              ),
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.withOpacity(
                    0.1,
                  ),
                ),
              ),
            ),
            child: Row(
              children: [
                // Logo DRAYVE
                const Text(
                  "DRAYVE",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Color(
                      0xFF2CB67F,
                    ),
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                // Teks Kategori
                Text(
                  "Kategori",
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),

                // Search Bar Lebar di Tengah
                Expanded(
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(
                        0xFF0F0F1A,
                      ),
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                      border: Border.all(
                        color: Colors.grey.withOpacity(
                          0.2,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          color: Colors.grey,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: TextField(
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Cari merek, model, atau tahun mobil...",
                              hintStyle: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                              contentPadding: const EdgeInsets.only(
                                bottom: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),

                // Ikon Keranjang/Notifikasi
                const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white70,
                ),
                const SizedBox(
                  width: 24,
                ),

                // Tombol Masuk (Outlined)
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color(
                        0xFF2CB67F,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                  onPressed: _navigateToLogin,
                  child: const Text(
                    "Masuk",
                    style: TextStyle(
                      color: Color(
                        0xFF2CB67F,
                      ),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),

                // Tombol Daftar (Elevated)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                      0xFF2CB67F,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                  onPressed: _navigateToLogin,
                  child: const Text(
                    "Daftar",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ==========================================
          // 2. MAIN CONTENT AREA (Scrollable)
          // ==========================================
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                // Constraint lebar maksimal untuk tampilan Web Desktop
                child: Container(
                  width: 1100,
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- MAIN BANNER PROMO ---
                      Container(
                        width: double.infinity,
                        height: 250, // Lebar dan tinggi menyerupai banner hijau utama
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            16,
                          ),
                          gradient: const LinearGradient(
                            colors: [
                              Color(
                                0xFF2CB67F,
                              ),
                              Color(
                                0xFF0D5E40,
                              ),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(
                                40.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Yuk, cari mobil di DRAYVE",
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Text(
                                    "Temukan kendaraan impian dari beragam pilihan",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: const Color(
                                        0xFF2CB67F,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 32,
                                        vertical: 18,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          8,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: const Text(
                                      "Cek Sekarang",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Ilustrasi Placeholder di Kanan
                            Positioned(
                              right: 20,
                              bottom: -20,
                              child: Icon(
                                Icons.directions_car,
                                size: 280,
                                color: Colors.white.withOpacity(
                                  0.2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),

                      // --- SPLIT LAYOUT: MEREK POPULER & CARI CEPAT ---
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Sisi Kiri: Merek Populer (Menggantikan Kategori Populer)
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 180,
                              padding: const EdgeInsets.all(
                                24,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFF1E1E2E,
                                ),
                                borderRadius: BorderRadius.circular(
                                  16,
                                ),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(
                                    0.1,
                                  ),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Merek Populer",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            const Color(
                                              0xFF2CB67F,
                                            ).withOpacity(
                                              0.2,
                                            ),
                                        borderRadius: BorderRadius.circular(
                                          8,
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "Promo Brand Pilihan",
                                          style: TextStyle(
                                            color: Color(
                                              0xFF2CB67F,
                                            ),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),

                          // Sisi Kanan: Simulasi / Cari Cepat (Menggantikan Top Up & Tagihan)
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 180,
                              padding: const EdgeInsets.all(
                                24,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFF1E1E2E,
                                ),
                                borderRadius: BorderRadius.circular(
                                  16,
                                ),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(
                                    0.1,
                                  ),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Cari Kendaraan Cepat",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "Filter Lanjut",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color:
                                              const Color(
                                                0xFF2CB67F,
                                              ).withOpacity(
                                                0.8,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Merek",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      const Text(
                                        "Tahun",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),

                                      Container(
                                        padding: const EdgeInsets.only(
                                          bottom: 4,
                                        ),
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Color(
                                                0xFF2CB67F,
                                              ),
                                              width: 2,
                                            ),
                                          ),
                                        ),

                                        child: const Text(
                                          "Harga Maksimal",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Icon(
                                        Icons.more_vert,
                                        color: Colors.grey[400],
                                        size: 18,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey.withOpacity(
                                                0.3,
                                              ),
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),
                                          child: const Text(
                                            "Rp 500 Juta",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.grey[700],
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 24,
                                            vertical: 16,
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: const Text(
                                          "Cari",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),

                      // --- BARIS IKON KATEGORI KECIL BAWAH ---
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 24,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFF1E1E2E,
                          ),
                          borderRadius: BorderRadius.circular(
                            16,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildCategoryIcon(
                              Icons.car_rental,
                              "Mobil Baru",
                            ),
                            _buildCategoryIcon(
                              Icons.time_to_leave,
                              "Mobil Bekas",
                            ),
                            _buildCategoryIcon(
                              Icons.electric_car,
                              "Mobil Listrik",
                            ),
                            _buildCategoryIcon(
                              Icons.handyman,
                              "Suku Cadang",
                            ),
                            _buildCategoryIcon(
                              Icons.build,
                              "Servis Rutin",
                            ),
                            _buildCategoryIcon(
                              Icons.shield,
                              "Asuransi",
                            ),
                            _buildCategoryIcon(
                              Icons.computer,
                              "Aksesoris",
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),

                      // --- GRIDVIEW DAFTAR MOBIL ---
                      const Text(
                        "Rekomendasi Untukmu",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4, // Diubah jadi 4 kolom karena tampilan desktop lebih luas
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.70,
                        ),
                        itemCount: carProducts.length,
                        itemBuilder:
                            (
                              context,
                              index,
                            ) {
                              return _buildCarProductCard(
                                carProducts[index],
                              );
                            },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget Helper untuk Ikon Kategori Baris Bawah
  Widget _buildCategoryIcon(
    IconData icon,
    String label,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(
            12,
          ),
          decoration: BoxDecoration(
            color: const Color(
              0xFF0F0F1A,
            ),
            borderRadius: BorderRadius.circular(
              12,
            ),
            border: Border.all(
              color: Colors.grey.withOpacity(
                0.2,
              ),
            ),
          ),
          child: Icon(
            icon,
            color: const Color(
              0xFF2CB67F,
            ),
            size: 24,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  // Widget Helper untuk Card Produk Mobil
  Widget _buildCarProductCard(
    Map<
      String,
      dynamic
    >
    car,
  ) {
    return GestureDetector(
      onTap: () {
        // Nanti diisi navigasi ke Tugas 5 (Detail Page)
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(
            0xFF1E1E2E,
          ),
          borderRadius: BorderRadius.circular(
            12,
          ),
          border: Border.all(
            color: Colors.grey.withOpacity(
              0.1,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(
                0.2,
              ),
              blurRadius: 4,
              offset: const Offset(
                0,
                2,
              ),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(
                          12,
                        ),
                      ),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image.network(
                      car['imageUrl'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color:
                            car['condition'] ==
                                'Baru'
                            ? const Color(
                                0xFF2CB67F,
                              )
                            : Colors.black.withOpacity(
                                0.7,
                              ),
                        borderRadius: BorderRadius.circular(
                          4,
                        ),
                      ),
                      child: Text(
                        car['condition'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(
                  12.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      car['price'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(
                          0xFF2CB67F,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      car['name'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 12,
                          color: Colors.grey[500],
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            car['location'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[500],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
