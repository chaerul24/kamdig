import 'package:flutter/material.dart';

void main() {
  runApp(WorksApp());
}

class WorksApp extends StatelessWidget {
  WorksApp({super.key});

  final List<Map<String, dynamic>> works = [
    {'title': 'Musholah', 'icon': 'assets/images/masjid.png', 'count': '0'},
    {'title': 'Jalan Rusak', 'icon': 'assets/images/road.png', 'count': '0'},
    {
      'title': 'Lingkungan',
      'icon': 'assets/images/lingkungan.png',
      'count': '0',
    },
    {'title': 'Wisata', 'icon': 'assets/images/wisata.png', 'count': '0'},
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bangunan',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: Row(
            children: [
              Image.asset('assets/images/ic_sketch.png', width: 30, height: 30),
              const SizedBox(width: 8),
              const Text('Bangunan'),
            ],
          ),
          // leading: IconButton(
          //   icon: const Icon(Icons.arrow_back),
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          // ),
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  shrinkWrap: true,
                  childAspectRatio: 1.9, // Semakin besar, semakin pendek item
                  children:
                      works.map((item) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(12),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.grey.withOpacity(0.3),
                            //     spreadRadius: 2,
                            //     blurRadius: 5,
                            //     offset: const Offset(0, 3),
                            //   ),
                            // ],
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: 10),
                              Image.asset(item['icon'], width: 30, height: 30),
                              const SizedBox(height: 8),
                              Text(
                                item['title'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                ),
              ),

              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'SISTEM INFORMASI DESA PEMBANGUNAN',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: 2,
                      width: double.infinity,
                      color: const Color.fromARGB(255, 156, 156, 156),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Merupakan aplikasi yang digunakan untuk mengelola data pembangunan di desa. Aplikasi ini bertujuan untuk mempermudah pengelolaan data dan informasi terkait pembangunan di desa.',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
