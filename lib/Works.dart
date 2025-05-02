import 'package:flutter/material.dart';

void main() {
  runApp(const WorksApp());
}

class WorksApp extends StatelessWidget {
  const WorksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Works',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Works')),
        body: const Center(child: Text('Works Page')),
      ),
    );
  }
}
