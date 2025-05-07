import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kamdig/Balance.dart';
import 'package:kamdig/Bansos.dart';
import 'package:kamdig/Works.dart';
import 'package:kamdig/news.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  runApp(const DashboardApp());
}

class DashboardApp extends StatelessWidget {
  const DashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color.fromARGB(255, 0, 140, 255),
      ),
      home: DashboardPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose(); // selalu dibuang yaa biar ga bocor
    super.dispose();
  }

  String selectedFilter = 'Berita';

  final List<String> filterOptions = ['Berita', 'Bencana', 'Wisata'];

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> data = [
      {
        'title': 'Bangunan',
        'icon': 'assets/images/ic_sketch.png',
        'color': Colors.yellow.shade50,
      },
      {
        'title': 'Bansos',
        'icon': 'assets/images/ic_food.png',
        'color': Colors.orange.shade50,
      },
      {
        'title': 'Acara',
        'icon': 'assets/images/ic_jadwal.png',
        'color': Colors.blue.shade50,
      },
      {
        'title': 'Profile',
        'icon': 'assets/images/ic_user.png',
        'color': Colors.green.shade50,
      },
      {
        'title': 'Dompet',
        'icon': 'assets/images/ic_wallet.png',
        'color': Colors.blueGrey.shade50,
      },
      {
        'title': 'Darurat',
        'icon': 'assets/images/ic_panic.png',
        'color': Colors.red.shade50,
      },
    ];

    final List<Map<String, dynamic>> carouselItems = [
      {
        'create_at': '2023-10-01',
        'image':
            'https://blue.kumparan.com/image/upload/fl_progressive,fl_lossy,c_fill,q_auto:best,w_640/v1634025439/01gce42kqcns2hxcy866946tds.jpg',
        'title': 'Kampung Digital',
        'source':
            'https://kumparan.com/panturapost/sempat-molor-3-pekan-pembangunan-rpu-brebes-baru-mencapai-30-persen-1yoqRlxRL3C',
      },
      {
        'create_at': '2023-10-02',
        'image':
            'https://d1jvl8fx4qy5cj.cloudfront.net/wp-content/uploads/2020/05/Lahan-di-Kawasan-Industri-Brebes_1589270139.jpg',
        'title': 'Pembangunan Kawasan Industri Brebes Mandek Dihadang Pandemi',
        'source':
            'https://www.kompas.id/baca/nusantara/2021/07/24/pembangunan-kawasan-industri-brebes-mandek-dihadang-pandemi/',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   title: Row(
      //     children: [
      //       Image.asset('assets/images/icon.png', height: 40),
      //       const SizedBox(width: 10),
      //       const Text(
      //         'Kampung Digital',
      //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      //       ),
      //     ],
      //   ),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.notifications, color: Colors.black),
      //       onPressed: () {
      //         ScaffoldMessenger.of(context).showSnackBar(
      //           const SnackBar(content: Text('Belum ada notifikasi 😴')),
      //         );
      //       },
      //     ),
      //   ],
      // ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 2 kolom
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    final item = data[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (item['title'] == "Bangunan") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WorksApp(),
                              ),
                            );
                          }
                          if (item['title'] == "Dompet") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BalanceApp(),
                              ),
                            );
                          }
                          if (item['title'] == "Bansos") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BansosApp(),
                              ),
                            );
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: item['color'],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(item['icon'], width: 30, height: 30),
                            const SizedBox(height: 10),
                            Text(
                              item['title'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 255, 84, 4),
                      width: 2,
                    ), // Mengatur warna dan ketebalan border
                    borderRadius: BorderRadius.circular(
                      8,
                    ), // Jika ingin memberi sudut melengkung
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.warning,
                              color: const Color.fromARGB(255, 255, 84, 4),
                              size: 30,
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: const Text(
                                'Anda memiliki tunggakan yang belum di bayar sebesar Rp 50.000 segera membayar agar akun anda tidak di nonaktifkan.',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 125, 126, 126),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ImageSlideshow(
                  width: double.infinity,
                  height: 200,
                  initialPage: 0,
                  indicatorColor: Colors.blue,
                  indicatorBackgroundColor: Colors.grey,
                  autoPlayInterval: 3000,
                  isLoop: true,
                  children:
                      carouselItems.map((item) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Stack(
                            children: [
                              Image.network(
                                item['image'],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 200,
                              ),
                              Positioned(
                                bottom: 10,
                                left: 10,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  // color: Colors.black.withOpacity(0.5),
                                  child: Container(
                                    constraints: BoxConstraints(maxWidth: 200),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          DateFormat("dd MMMM yyyy").format(
                                            DateTime.parse(item['create_at']),
                                          ),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        Text(
                                          item['title'],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                ),

                SizedBox(height: 20),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 0),
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
                                  selectedFilter =
                                      option; // Update the selected filter
                                  print('Selected Filter: $selectedFilter');
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

                const SizedBox(height: 20),

                if (selectedFilter == 'Berita')
                  const Column(children: [NewsWidget()])
                else if (selectedFilter == 'Bencana')
                  const SizedBox(
                    height: 100,
                    child: Center(child: Text('Belum ada')),
                  )
                else if (selectedFilter == 'Wisata')
                  const SizedBox(
                    height: 100,
                    child: Center(child: Text('Belum ada')),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
