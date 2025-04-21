import 'package:flutter/material.dart';
import 'package:kamdig/main2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kamdig',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashscreenPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashscreenPage extends StatefulWidget {
  const SplashscreenPage({super.key});

  @override
  State<SplashscreenPage> createState() => _SplashscreenPageState();
}

class _SplashscreenPageState extends State<SplashscreenPage> {
  @override
  void initState() {
    super.initState();
    _navigateToDashboard();
  }

  // Fungsi untuk delay dan navigasi ke halaman utama
  Future<void> _navigateToDashboard() async {
    await Future.delayed(const Duration(seconds: 3)); // Delay 3 detik
    // Navigasi ke halaman utama menggunakan Navigator
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Main2()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', width: 150, height: 150),
          ],
        ),
      ),
    );
  }
}
