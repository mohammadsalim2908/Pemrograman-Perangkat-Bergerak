class Course {
  final String code;
  final String name;
  final String lecturer;
  final String room;
  final int sks;
  final double progress;
  final String category;

  Course({
    required this.code,
    required this.name,
    required this.lecturer,
    required this.room,
    required this.sks,
    required this.progress,
    required this.category,
  });

  static List<Course> getSampleCourses() {
    return [
      Course(
        code: 'TRPL501',
        name: 'Pemrograman Berbasis Objek',
        lecturer: 'Bpk. Ahmad, M.Kom',
        room: 'Lab Komputer 1',
        sks: 3,
        progress: 0.8,
        category: 'Praktikum',
      ),
      Course(
        code: 'TRPL502',
        name: 'Teori Komputasi',
        lecturer: 'Ibu Siti, M.T.',
        room: 'Ruang 201',
        sks: 2,
        progress: 0.5,
        category: 'Teori',
      ),
      Course(
        code: 'TRPL503',
        name: 'Rekayasa Perangkat Lunak',
        lecturer: 'Bpk. Budi, M.Sc',
        room: 'Ruang 202',
        sks: 3,
        progress: 0.3,
        category: 'Teori',
      ),
      Course(
        code: 'TRPL504',
        name: 'Pemrograman Mobile Dasar',
        lecturer: 'Ibu Diana, M.Kom',
        room: 'Lab Komputer 2',
        sks: 3,
        progress: 0.1,
        category: 'Praktikum',
      ),
    ];
  }
}