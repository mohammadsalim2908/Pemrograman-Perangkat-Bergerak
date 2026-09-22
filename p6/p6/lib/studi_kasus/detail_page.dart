import 'package:flutter/material.dart';
import 'route_page.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    super.key,
    required this.placeName,
  });

  final String placeName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Lokasi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.green.shade100,
              ),
              child: const Center(
                child: Icon(
                  Icons.park,
                  size: 100,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              placeName,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Row(
              children: [
                Icon(Icons.location_on),
                SizedBox(width: 4),
                Text('Area Utara'),
              ],
            ),

            const SizedBox(height: 16),

            const Text(
              'Tempat yang nyaman untuk bersantai, '
              'berdiskusi, atau mengerjakan tugas.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RoutePage(),
                    ),
                  );
                },
                child: const Text('Lihat Rute'),
              ),
            ),

            const SizedBox(height: 8),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Kembali'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}