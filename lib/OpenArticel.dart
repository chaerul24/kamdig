import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kamdig/model/NewsModel.dart';
import 'package:kamdig/serve/HttpConnectApi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Make sure to initialize async tasks
  await initializeDateFormatting(
    'id_ID',
    null,
  ); // This is the key to localization
  runApp(const OpenArticle());
}

class OpenArticle extends StatelessWidget {
  const OpenArticle({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kamdig',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const OpenArticlePage(id: ""),
      debugShowCheckedModeBanner: false,
    );
  }
}

class OpenArticlePage extends StatefulWidget {
  final String id;
  const OpenArticlePage({super.key, required this.id});

  @override
  State<OpenArticlePage> createState() => _OpenArticlePageState();
}

class _OpenArticlePageState extends State<OpenArticlePage> {
  final FlutterTts flutterTts = FlutterTts(); // Inisialisasi FlutterTts
  bool isFavorite = false; // Menyimpan status favorite
  final Map<String, dynamic> data = {
    'id': '',
    'title': '',
    'artikel': '',
    'create_at': '',
    'image': '',
    'comment': '',
    'views': '',
    'posted_by': '',
  }; // Data artikel yang akan ditampilkan

  late Future<NewsModel> newsFuture;
  final Httpconnectapi _httpConnectApi =
      Httpconnectapi(); // Inisialisasi Httpconnectapi
  late bool isLoading = false; // Menyimpan status loading

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage('id-ID'); // Set bahasa Indonesia
    await flutterTts.setPitch(1); // Set pitch suara
    await flutterTts.speak(text); // Membaca teks
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite; // Toggle status favorite
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      isLoading = true; // Set loading menjadi true
    });

    if (widget.id.isEmpty) {
      debugPrint("ID kosong");
    } else {
      debugPrint("ID: ${widget.id}");

      try {
        final response = await _httpConnectApi.getData(
          'api/v1/news/${widget.id}',
        );

        debugPrint("Response: $response"); // Log response dari server

        if (response['status'] == 'success') {
          final data_ = response['data'];
          setState(() {
            data['id'] = data_['id'];
            data['title'] = data_['title'];
            data['artikel'] = data_['artikel'];
            data['create_at'] = data_['create_at'];
            data['image'] = data_['image'];
            data['comment'] = data_['comment'];
            data['views'] = data_['views'];
            data['posted_by'] = data_['posted_by'];
            isLoading =
                false; // Set loading menjadi false setelah data berhasil dimuat
          });
          debugPrint("Data: ${data['title']}"); // Log data yang diterima
        } else {
          print('Error Response: ${response['message']}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response['message'] ?? 'Gagal memuat artikel'),
              backgroundColor: Colors.red,
            ),
          );
          setState(() {
            isLoading = false; // Set loading menjadi false jika terjadi error
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Jaringan bermasalah'),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          isLoading =
              false; // Set loading menjadi false jika terjadi error jaringan
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Open Article'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Pop the current screen off the stack
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Text(
                  data['views'], // contoh: '100k'
                  style: const TextStyle(fontSize: 16),
                ),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    size: 20,
                  ),
                  onPressed:
                      _toggleFavorite, // Menambahkan aksi untuk toggle favorite
                ),
              ],
            ),
          ),
        ],
      ),
      body:
          isLoading
              ? Center(
                child: CircularProgressIndicator(),
              ) // Tampilkan indikator loading saat isLoading true
              : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ), // Atur radius sesuai keinginan
                        child: Image.network(
                          data['image'],
                          width: double.infinity,
                          height: 180,
                          fit: BoxFit.fill,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  value:
                                      loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              (loadingProgress
                                                      .expectedTotalBytes ??
                                                  1)
                                          : null,
                                ),
                              );
                            }
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset('assets/images/disconnected.png'),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                    right: 10,
                                  ),
                                  child: Text(
                                    data['title'],
                                    style: const TextStyle(
                                      fontSize: 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                        left: 10,
                        right: 10,
                      ),
                      child: Html(
                        data: data['artikel'],
                        style: {
                          'p': Style(
                            fontSize: FontSize(16.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                          'h1': Style(
                            fontSize: FontSize(20.0),
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        },
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
