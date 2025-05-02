import 'package:flutter/material.dart';

void main() {
  runApp(OpenchatPageView());
}

class OpenchatPageView extends StatelessWidget {
  const OpenchatPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kamdig',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const OpenchatPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class OpenchatPage extends StatefulWidget {
  const OpenchatPage({super.key});

  @override
  State<OpenchatPage> createState() => OpenchatPageState();
}

class OpenchatPageState extends State<OpenchatPage> {
  final List<Map<String, dynamic>> messages = const [
    {
      'sender': 'james@gmail.com',
      'message': 'Halo, ada yang bisa dibantu?',
      'time': '10:30',
    },
    {
      'sender': 'kamu',
      'message': 'Iya kak, ini aku mau tanya soal kosan...',
      'time': '10:31',
    },
    {
      'sender': 'james@gmail.com',
      'message': 'Silakan, tanya aja 😊',
      'time': '10:32',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Open Chat",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Divider(height: 1),
            Expanded(
              child:
                  messages.isEmpty
                      ? const Center(child: Text("Belum ada pesan"))
                      : ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final msg = messages[index];
                          final isMe = msg['sender'] == 'kamu';

                          return Align(
                            alignment:
                                isMe
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color:
                                    isMe ? Colors.blue[100] : Colors.grey[300],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    msg['message'],
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    msg['time'],
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
