import 'package:flutter/material.dart';
import 'modul_02/academic_dashboard_screen.dart';
import 'modul_02/study_kasus/ruang_praktikum.dart';

void main() {
  runApp(const PoliwangiProfileApp());
}

class PoliwangiProfileApp extends StatelessWidget {
  const PoliwangiProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profil Mahasiswa TRPL',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0D9488),
        ),
        useMaterial3: true,
      ),
      home: const MainDashboardScreen(),
    );
  }
}

// NEW
class MainDashboardScreen extends StatefulWidget {
  const MainDashboardScreen({super.key});

  @override
  State<MainDashboardScreen> createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const AcademicDashboardScreen(),
    const Center(child: Text('Halaman Jadwal (Belum dibuat)')),
    const RuangPraktikumScreen(),
    const Center(child: Text('Halaman Lainnya (Belum dibuat)')),
  ];

  @override
  Widget build(BuildContext context) {
    // Mengecek apakah lebar layar lebih dari 900px (Desktop/Tablet)
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      body: isDesktop
          ? Row(
              children: [
                _buildSidebar(), // Memanggil Sidebar jika layar lebar
                Expanded(child: _pages[_selectedIndex]), // Halaman konten
              ],
            )
          : _pages[_selectedIndex], // Langsung tampilkan halaman jika mobile
          
      // Bottom Navbar HANYA muncul jika BUKAN desktop
      bottomNavigationBar: isDesktop 
          ? null 
          : BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) => setState(() => _selectedIndex = index),
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.blue[700],
              unselectedItemColor: Colors.grey,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Beranda'),
                BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Jadwal'),
                BottomNavigationBarItem(icon: Icon(Icons.door_front_door_outlined), label: 'Ruang'),
                BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'Lainnya'),
              ],
            ),
    );
  }

  // =========================================================
  // WIDGET SIDEBAR (Khusus Desktop)
  // =========================================================
  Widget _buildSidebar() {
    return Container(
      width: 250,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNavItem(Icons.home_filled, 'Beranda', 0),
          _buildNavItem(Icons.calendar_today, 'Jadwal', 1),
          _buildNavItem(Icons.door_front_door_outlined, 'Ruang', 2),
          _buildNavItem(Icons.more_horiz, 'Lainnya', 3),
          const Spacer(),
          const Icon(Icons.event_note, color: Colors.blue, size: 32),
          const SizedBox(height: 12),
          const Text(
            'Praktikum\nLebih Teratur\nHasil Lebih Baik',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, height: 1.3),
          ),
          const SizedBox(height: 12),
          Container(
            width: 40, height: 4,
            decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(2)),
          )
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String title, int index) {
    final isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => setState(() => _selectedIndex = index),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[50] : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.blue[700] : Colors.grey[600]),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.blue[700] : Colors.grey[700],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}