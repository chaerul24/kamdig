import 'package:flutter/material.dart';

void main() {
  runApp(ChatPage());
}

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kamdig',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ChatPageView(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ChatPageView extends StatefulWidget {
  const ChatPageView({super.key});

  @override
  State<ChatPageView> createState() => ChatPageViewState();
}

class ChatPageViewState extends State<ChatPageView> {
  @override
  void initState() {
    super.initState();
    _navigateToDashboard();
  }

  // Fungsi untuk delay dan navigasi ke halaman utama
  Future<void> _navigateToDashboard() async {
    await Future.delayed(const Duration(seconds: 3)); // Delay 3 detik
    // Navigasi ke halaman utama menggunakan Navigator
    // Navigator.pushReplacement(
    //   context,
    //   // MaterialPageRoute(builder: (context) => Main2()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}
