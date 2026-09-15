import 'package:flutter/material.dart';

class RuangPraktikumScreen extends StatefulWidget {
  const RuangPraktikumScreen({super.key});

  @override
  State<RuangPraktikumScreen> createState() => _RuangPraktikumScreenState();
}

class _RuangPraktikumScreenState extends State<RuangPraktikumScreen> {
  // State untuk BottomNav / Sidebar
  int _selectedIndex = 0;
  // State untuk Filter
  String _selectedFilter = 'Semua';

  // Data dummy list of map
  final List<Map<String, dynamic>> _labData = [
    {
      'title': 'Mobile Programming',
      'room': 'Lab 1',
      'status': 'Berlangsung',
      'time': '08:00 - 10:00',
      'assistants': 2,
      'icon': Icons.computer,
      'statusColor': Colors.green,
    },
    {
      'title': 'Rekayasa Perangkat Lunak',
      'room': 'Lab 2',
      'status': 'Akan datang',
      'time': '10:00 - 12:00',
      'assistants': 2,
      'icon': Icons.settings,
      'statusColor': Colors.blue,
    },
    {
      'title': 'Basis Data',
      'room': 'Lab 3',
      'status': 'Selesai',
      'time': '13:00 - 15:00',
      'assistants': 2,
      'icon': Icons.storage,
      'statusColor': Colors.grey,
    },
    {
      'title': 'Lab 2',
      'room': 'Ruang tersedia untuk sesi berikutnya',
      'status': 'Tersedia',
      'time': '',
      'assistants': 0, // 0 = tidak ditampilkan
      'icon': Icons.door_front_door,
      'statusColor': Colors.teal,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Cek apakah tampilan desktop
            final isDesktop = constraints.maxWidth > 900;

            // Langsung kembalikan konten utama, karena Sidebar sudah diurus oleh main.dart
            return SingleChildScrollView(
              padding: EdgeInsets.all(isDesktop ? 32.0 : 16.0),
              child: _buildMainContent(isDesktop: isDesktop),
            );
          },
        ),
      ),
    ); 
  }

  // WIDGET UTAMA (KONTEN TENGAH)
  Widget _buildMainContent({required bool isDesktop}) {
    // Memfilter data lab
    final filteredData = _selectedFilter == 'Semua'
        ? _labData
        : _labData.where((lab) => lab['status'] == _selectedFilter).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ruang Praktikum Hari Ini',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                ),
                const SizedBox(height: 4),
                Text(
                  'Jadwal dan status penggunaan laboratorium',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
            if (isDesktop)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_month, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 8),
                    const Text('Senin, 21 Apr 2025', style: TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 24),

        // Dua Kartu Ringkasan
        Row(
          children: [
            Expanded(child: _buildSummaryCard(Icons.calendar_today, '3 sesi', 'Hari ini', Colors.blue)),
            const SizedBox(width: 16),
            Expanded(child: _buildSummaryCard(Icons.door_front_door, '1 ruang tersedia', 'dari 3 ruang', Colors.blue)),
          ],
        ),
        const SizedBox(height: 24),

        // Filter Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: ['Semua', 'Berlangsung', 'Akan datang', 'Selesai', 'Tersedia'].map((filter) {
              final isSelected = _selectedFilter == filter;
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ChoiceChip(
                  label: Text(filter),
                  selected: isSelected,
                  selectedColor: Colors.blue[600],
                  labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.grey[700]),
                  backgroundColor: Colors.white,
                  side: BorderSide(color: isSelected ? Colors.transparent : Colors.grey.shade300),
                  onSelected: (selected) {
                    setState(() => _selectedFilter = filter);
                  },
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 24),

        // Grid Kartu Jadwal
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredData.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400,
            mainAxisExtent: 160, 
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            return _buildLabCard(filteredData[index]);
          },
        ),

        // Banner bawah (Hanya di Desktop)
        if (isDesktop)
          Container(
            margin: const EdgeInsets.only(top: 24),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(Icons.lightbulb_outline, color: Colors.blue[700]),
                const SizedBox(width: 12),
                Text(
                  'Laboratorium yang terjadwal dengan baik,\nmendukung pengalaman belajar yang lebih maksimal.',
                  style: TextStyle(color: Colors.blue[800]),
                ),
              ],
            ),
          )
      ],
    );
  }

  // Desain Sidebar Kiri untuk versi Desktop
  Widget _buildSidebar() {
    return Container(
      width: 250,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item Navigasi
          _buildNavItem(Icons.home_filled, 'Beranda', 0),
          _buildNavItem(Icons.calendar_today, 'Jadwal', 1),
          _buildNavItem(Icons.door_front_door_outlined, 'Ruang', 2),
          _buildNavItem(Icons.more_horiz, 'Lainnya', 3),
          
          const Spacer(),
          
          // Info Bawah Navigasi
          const Icon(Icons.event_note, color: Colors.blue, size: 32),
          const SizedBox(height: 12),
          const Text(
            'Praktikum\nLebih Teratur\nHasil Lebih Baik',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, height: 1.3),
          ),
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
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

  Widget _buildSummaryCard(IconData icon, String title, String subtitle, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabCard(Map<String, dynamic> lab) {
    Color statusColor = lab['statusColor'];
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          // Row Atas: Status dan Jam
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: statusColor.withOpacity(0.3)),
                ),
                child: Text(
                  lab['status'],
                  style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
              if (lab['time'].toString().isNotEmpty)
                Text(
                  lab['time'],
                  style: TextStyle(color: Colors.grey[600], fontSize: 12, fontWeight: FontWeight.w500),
                ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Row Bawah: Ikon dan Detail Lab
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(lab['icon'], color: Colors.blue.shade700, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lab['title'],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 14, color: Colors.grey[500]),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            lab['room'],
                            style: TextStyle(color: Colors.grey[600], fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    if (lab['assistants'] > 0) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.people, size: 14, color: Colors.grey[500]),
                          const SizedBox(width: 4),
                          Text(
                            'Asisten: ${lab['assistants']} orang',
                            style: TextStyle(color: Colors.grey[600], fontSize: 12),
                          ),
                        ],
                      ),
                    ]
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}