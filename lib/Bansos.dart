import 'package:flutter/material.dart';
import 'package:kamdig/plugin/NewApp.dart';

void main() {
  runApp(const BansosApp());
}

class BansosApp extends StatelessWidget {
  const BansosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bansos',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedFilter = 'Berita';

  final List<String> filterOptions = ['Berita', 'Daerah', 'Daftar Penerima'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Row(
          children: [
            Image.asset('assets/images/ic_food.png', width: 30, height: 30),
            const SizedBox(width: 8),
            const Text('Bansos'),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(103, 190, 190, 190),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  'https://image.chaerul.biz.id/uploads/bansos.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error, size: 50, color: Colors.red),
                          SizedBox(height: 8),
                          Text('Gagal memuat gambar'),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children:
                    filterOptions.map((option) {
                      final bool isSelected = selectedFilter == option;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (isSelected) const SizedBox(width: 4),
                              Text(option),
                            ],
                          ),
                          selected: isSelected,
                          onSelected: (_) {
                            setState(() {
                              selectedFilter = option;
                            });
                          },
                          selectedColor: Colors.blue,
                          backgroundColor: Colors.grey[300],
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            if (selectedFilter == 'Berita')
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: NewsApp(category: 'Berita'),
              )
            else if (selectedFilter == 'Daerah')
              const Expanded(child: Center(child: Text('Daerah Filter')))
            else if (selectedFilter == 'Daftar Penerima')
              const Expanded(
                child: Center(child: Text('Daftar Penerima Filter')),
              ),
          ],
        ),
      ),
    );
  }
}
