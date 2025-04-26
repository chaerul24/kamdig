import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // penting buat init async
  await initializeDateFormatting('id_ID', null); // ini kunci utamanya
  runApp(const OpenArticle());
}

class OpenArticle extends StatelessWidget {
  const OpenArticle({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kamdig',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const OpenArticlePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class OpenArticlePage extends StatefulWidget {
  const OpenArticlePage({super.key});

  @override
  State<OpenArticlePage> createState() => _OpenArticlePageState();
}

class _OpenArticlePageState extends State<OpenArticlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Open Article')),
      body: const Center(child: Text('Open Article')),
    );
  }
}
