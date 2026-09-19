import 'package:flutter/material.dart';

import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _handleLogout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Dummy Data Produk Mobil
    final List<Map<String, dynamic>> carProducts = [
      {
        'name': 'Honda Civic RS 2023',
        'price': 'Rp 539 Juta',
        'type': 'Sedan',
        'condition': 'Baru',
        'colorBg': Colors.redAccent.withOpacity(0.8),
      },
      {
        'name': 'Toyota Fortuner GR',
        'price': 'Rp 624 Juta',
        'type': 'SUV',
        'condition': 'Bekas',
        'colorBg': Colors.blueAccent.withOpacity(0.8),
      },
      {
        'name': 'Hyundai Ioniq 5',
        'price': 'Rp 748 Juta',
        'type': 'Listrik',
        'condition': 'Baru',
        'colorBg': Colors.greenAccent.shade700.withOpacity(0.8),
      },
      {
        'name': 'BMW 320i M Sport',
        'price': 'Rp 1.13 Miliar',
        'type': 'Sedan',
        'condition': 'Bekas',
        'colorBg': Colors.orangeAccent.withOpacity(0.8),
      },
      {
        'name': 'Mitsubishi Pajero',
        'price': 'Rp 577 Juta',
        'type': 'SUV',
        'condition': 'Bekas',
        'colorBg': Colors.purpleAccent.withOpacity(0.8),
      },
      {
        'name': 'Wuling Air EV',
        'price': 'Rp 238 Juta',
        'type': 'Listrik',
        'condition': 'Baru',
        'colorBg': Colors.tealAccent.shade700.withOpacity(0.8),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "AutoMarket",
          style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white70),
            tooltip: 'Logout',
            onPressed: () => _handleLogout(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Sapaan & Search Bar
            const Text(
              "Halo, Ray",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "Mau cari mobil apa hari ini?",
              style: TextStyle(fontSize: 15, color: Colors.grey[400]),
            ),
            const SizedBox(height: 24),

            // Search Bar (Desain Dummy)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E2E),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 12),
                  Text(
                    "Cari merek atau model...",
                    style: TextStyle(color: Colors.grey[500], fontSize: 15),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.tune,
                    color: Color(0xFF7F5AF0),
                  ), // Ikon filter
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Kategori Mobil (Bisa di-scroll ke samping)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryChip("Semua", true),
                  _buildCategoryChip("SUV", false),
                  _buildCategoryChip("Sedan", false),
                  _buildCategoryChip("Mobil Listrik", false),
                  _buildCategoryChip("Hatchback", false),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Judul Bagian Produk
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Rekomendasi Teratas",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Lihat Semua",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.greenAccent.shade400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // GridView Produk Mobil
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio:
                    0.70, // Rasio diubah agar muat gambar + teks detail
              ),
              itemCount: carProducts.length,
              itemBuilder: (context, index) {
                final car = carProducts[index];
                return _buildCarProductCard(
                  car['name'],
                  car['price'],
                  car['type'],
                  car['condition'],
                  car['colorBg'],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget Helper untuk Kategori
  Widget _buildCategoryChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF7F5AF0) : const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? Colors.transparent : Colors.grey.withOpacity(0.3),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey[400],
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  // Widget Helper untuk Produk Mobil
  Widget _buildCarProductCard(
    String name,
    String price,
    String type,
    String condition,
    Color bgColor,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Area Gambar Mobil (Menggunakan Icon dan Background Color)
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Icon(
                      Icons.directions_car,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  // Badge Kondisi (Baru/Bekas)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        condition,
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
          ),
          // Area Detail Teks
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.settings_suggest,
                        size: 12,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        type,
                        style: TextStyle(fontSize: 11, color: Colors.grey[400]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Color(
                        0xFF2CB67F,
                      ), // Hijau yang melambangkan uang/harga
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
