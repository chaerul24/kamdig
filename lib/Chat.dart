import 'package:flutter/material.dart';
import 'package:kamdig/OpenChat.dart';

void main() {
  runApp(const ChatPage());
}

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

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
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> userChat = [
    {
      'username': 'James',
      'avatar': 'https://avatars.githubusercontent.com/u/160778594?v=4',
      'status': 'online',
      'message': 'Halo, apa kabar?',
      'read': true,
      'time': '10:00 AM',
      'email': 'james@gmail.com',
    },
    {
      'username': 'Jhon',
      'avatar': 'https://avatars.githubusercontent.com/u/136873290?v=4',
      'status': 'online',
      'message': 'Selamat malam, Chaerul',
      'read': false,
      'time': '10:00 AM',
      'email': 'james@gmail.com',
    },
  ];

  List<Map<String, dynamic>> _filteredChat = [];

  @override
  void initState() {
    super.initState();
    _filteredChat = userChat;
  }

  void _filterChat(String keyword) {
    setState(() {
      _filteredChat =
          userChat.where((chat) {
            final username = chat['username'].toString().toLowerCase();
            final message = chat['message'].toString().toLowerCase();
            return username.contains(keyword.toLowerCase()) ||
                message.contains(keyword.toLowerCase());
          }).toList();
    });
  }

  Future<void> _refreshChat() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _filteredChat = userChat;
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Search bar
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
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OpenchatPageView(),
                          ),
                          (route) => false,
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
