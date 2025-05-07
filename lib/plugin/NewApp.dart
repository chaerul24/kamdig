import 'package:flutter/material.dart';
import 'package:kamdig/OpenArticel.dart';
import 'package:kamdig/model/NewsModel.dart';
import 'package:kamdig/serve/HttpConnectApi.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // penting buat init async
  await initializeDateFormatting('id_ID', null); // ini kunci utamanya
  runApp(NewsApp(category: 'Berita'));
}

class NewsApp extends StatefulWidget {
  final String category;
  const NewsApp({super.key, required this.category});
  @override
  State<NewsApp> createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  late Future<List<NewsModel>> newsFuture;

  @override
  void initState() {
    super.initState();
    newsFuture = Httpconnectapi().getNews();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NewsModel>>(
      future: newsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Shimmer loading
          return shimmerLoading(context);
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('Tidak ada berita tersedia.');
        }

        final newsList = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: newsList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 20,
                childAspectRatio: 3,
              ),
              itemBuilder: (context, index) {
                final item = newsList[index];
                return newsCard(item);
              },
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  Widget shimmerLoading(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 2,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 20,
            childAspectRatio: 3,
          ),
          itemBuilder: (context, index) {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  shimmerBox(width: 100, height: 150),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        shimmerBox(width: 150, height: 10),
                        const SizedBox(height: 5),
                        shimmerBox(
                          width: MediaQuery.of(context).size.width - 100,
                          height: 15,
                        ),
                        const SizedBox(height: 6),
                        shimmerBox(width: 100, height: 15),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget shimmerBox({required double width, required double height}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(width: width, height: height, color: Colors.grey[300]),
    );
  }

  Widget newsCard(NewsModel item) {
    return GestureDetector(
      onTap: () {
        // Handle tap event here, e.g., navigate to a detail page
        print('Tapped on: ${item.title}');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OpenArticlePage(id: item.id)),
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                item.image,
                width: 100,
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    item.createdAt,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),

                  const Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.comment, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(item.comment.toString()),
                        const SizedBox(width: 10),
                        Icon(
                          Icons.remove_red_eye,
                          size: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(item.views.toString()),
                      ],
                    ),
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
