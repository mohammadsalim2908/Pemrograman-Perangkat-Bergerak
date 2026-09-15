import 'package:flutter/material.dart';

// 1. PERBAIKAN IMPORT PATH
// Karena academic_dashboard_screen.dart ada di dalam modul_02, 
// kita panggil folder models secara langsung (tidak perlu pakai '../')
import 'models/course.dart'; 

// CATATAN: Jika course_card.dart & header_banner.dart ada di dalam folder "widgets", 
// ubah tulisan di bawah ini menjadi: import 'widgets/course_card.dart';
import 'widgets/course_card.dart';      
import 'widgets/header_banner.dart';    

class AcademicDashboardScreen extends StatefulWidget {
  const AcademicDashboardScreen({super.key});

  @override
  State<AcademicDashboardScreen> createState() => _AcademicDashboardScreenState();
}

class _AcademicDashboardScreenState extends State<AcademicDashboardScreen> {
  // Mengambil data dummy
  final List<Course> _courses = Course.getSampleCourses();
  
  // State untuk filter yang aktif
  String _selectedFilter = 'Semua';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Dashboard Akademik TRPL', 
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF0284C7),
        actions: [
          IconButton(
            icon: const Icon(Icons.dark_mode, color: Colors.white),
            onPressed: () {},
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 900;

          if (isDesktop) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(24.0),
                    // 2. PERBAIKAN CONST: Kata 'const' dihilangkan di sini
                    child: HeaderBanner(
                      studentName: 'Mahasiswa TRPL',
                      nim: '362355401xxx',
                      totalSks: 11,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 24.0, right: 24.0, bottom: 24.0),
                    child: _buildCourseContent(),
                  ),
                ),
              ],
            );
          } else {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2. PERBAIKAN CONST: Kata 'const' dihilangkan di sini juga
                  const SizedBox(height: 8), // (hanya untuk jarak aman jika butuh)
                  HeaderBanner(
                    studentName: 'Mahasiswa TRPL',
                    nim: '362355401xxx',
                    totalSks: 11,
                  ),
                  const SizedBox(height: 24),
                  _buildCourseContent(),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildCourseContent() {
    final filteredCourses = _selectedFilter == 'Semua'
        ? _courses
        : _courses.where((c) => c.category == _selectedFilter).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: ['Semua', 'Teori', 'Praktikum'].map((filter) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: FilterChip(
                  label: Text(filter),
                  selected: _selectedFilter == filter,
                  showCheckmark: _selectedFilter == filter,
                  onSelected: (selected) {
                    setState(() {
                      _selectedFilter = filter;
                    });
                  },
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),
        
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredCourses.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400, 
            mainAxisExtent: 200,     
            crossAxisSpacing: 16,    
            mainAxisSpacing: 16,     
          ),
          itemBuilder: (context, index) {
            return CourseCard(course: filteredCourses[index]);
          },
        ),
      ],
    );
  }
}