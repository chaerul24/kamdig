import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(BalanceApp());
}

class BalanceApp extends StatelessWidget {
  BalanceApp({super.key});

  final List<Map<String, dynamic>> transactionList = [
    {"balance": 1000000, "owner": "Chaerul", "date": "2023-10-01"},
  ];

  final List<Map<String, dynamic>> fiturList = [
    {"title": "Top Up", "icon": Icons.add_circle},
    {"title": "Bayar Tagihan", "icon": Icons.receipt_long},
    {"title": "Kirim Saldo", "icon": Icons.send},
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 77, 131, 233),
          title: Row(
            children: [
              const Icon(
                Icons.account_balance_wallet,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(
                'Dompet Saya',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Text(
              //   '${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0).format(transactionList[0]["balance"])}',
              //   style: const TextStyle(
              //     color: Colors.white,
              //     fontSize: 15,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 77, 131, 233),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          NumberFormat.currency(
                            locale: 'id_ID',
                            symbol: 'Rp',
                            decimalDigits: 0,
                          ).format(transactionList[0]["balance"]),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  Container(
                    width: double.infinity,
                    height: 130,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 1,
                          ),
                      itemCount: fiturList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final fitur = fiturList[index];
                        return GestureDetector(
                          onTap: () {
                            // Tambahkan aksi masing-masing di sini
                            print('Klik: ${fitur["title"]}');
                          },
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  77,
                                  131,
                                  233,
                                ),
                                child: Icon(
                                  fitur["icon"],
                                  size: 30,
                                  color: const Color.fromARGB(
                                    255,
                                    255,
                                    255,
                                    255,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                fitur["title"],
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 15, 15, 15),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 10,
                    ),
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
                                Container(
                                  width: double.infinity,
                                  height: 200,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: NetworkImage(item['image']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    // color: Colors.black.withOpacity(0.5),
                                    child: Container(
                                      constraints: BoxConstraints(
                                        maxWidth: 200,
                                      ),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
