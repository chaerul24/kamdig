import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kamdig/Balance.dart';
import 'package:kamdig/OpenChat.dart';
import 'package:kamdig/Works.dart';
import 'package:kamdig/news.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color.fromARGB(255, 0, 140, 255),
      ),
      home: ChatPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _chatList = [
    {
      'username': 'Chaerul',
      'message': 'Halo, apa kabar?',
      'time': '10:30',
      'read': true,
      'status': 'online',
      'avatar': 'https://avatars.githubusercontent.com/u/160778594?v=4',
    },
  ];

  List<Map<String, dynamic>> _filteredChat = [];

  @override
  void initState() {
    super.initState();
    _filteredChat = List.from(_chatList);
  }

  void _filterChat(String keyword) {
    if (keyword.isEmpty) {
      _filteredChat = List.from(_chatList);
    } else {
      _filteredChat =
          _chatList
              .where(
                (chat) =>
                    chat['username'].toLowerCase().contains(
                      keyword.toLowerCase(),
                    ) ||
                    chat['message'].toLowerCase().contains(
                      keyword.toLowerCase(),
                    ),
              )
              .toList();
    }
  }

  Future<void> _refreshChat() async {
    await Future.delayed(const Duration(seconds: 1));
    // Simulasikan pembaruan data
    setState(() {
      _chatList.shuffle(); // contoh: urutkan acak untuk efek refresh
      _filteredChat = List.from(_chatList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: SizedBox(
              height: 45,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Cari chat...',
                  prefixIcon: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: const Icon(Icons.search),
                  ),
                  suffixIcon:
                      _searchController.text.isNotEmpty
                          ? IconButton(
                            icon: Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: const Icon(Icons.clear),
                            ),
                            onPressed: () {
                              _searchController.clear();
                              _filterChat('');
                              setState(() {});
                            },
                          )
                          : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onChanged: (value) {
                  _filterChat(value);
                  setState(() {});
                },
              ),
            ),
          ),

          // Chat list with pull to refresh
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: RefreshIndicator(
                onRefresh: _refreshChat,
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: _filteredChat.length,
                  itemBuilder: (context, index) {
                    final user = _filteredChat[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user['avatar']),
                        radius: 25,
                      ),
                      title: Text(
                        user['username'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          if (user['read'])
                            const Icon(
                              Icons.check,
                              size: 16,
                              color: Colors.blue,
                            ),
                          const SizedBox(width: 4),
                          Text(user['message']),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(user['time']),
                          const SizedBox(height: 6),
                          if (user['status'] == 'online')
                            const Icon(
                              Icons.circle,
                              size: 12,
                              color: Colors.green,
                            ),
                        ],
                      ),
                      onTap: () {
                        // Aksi saat item diklik, misalnya buka chat dengan user
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OpenchatPage(),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
