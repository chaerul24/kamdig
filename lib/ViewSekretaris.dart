import 'package:flutter/material.dart';

void main() {
  runApp(const ViewSekretarisPageView());
}

class ViewSekretarisPageView extends StatelessWidget {
  const ViewSekretarisPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kamdig',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ViewSekretarisPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ViewSekretarisPage extends StatelessWidget {
  const ViewSekretarisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('View Sekretaris')),
      body: const Center(child: Text('View Sekretaris')),
    );
  }
}
