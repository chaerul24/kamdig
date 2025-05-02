import 'package:flutter/material.dart';

void main() {
  runApp(NotificationApp());
}

class NotificationApp extends StatelessWidget {
  NotificationApp({super.key});

  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'Pembangunan Mushola',
      'message': 'Sedang dalam proses pembangunan mushola baru',
      'images': 'https://kamdig.chaerul.biz.id/icon/developing.png',
      'time': '10:30',
      'category': 'Pembangunan',
    },
    {
      'title': 'Informasi Penting',
      'message': 'Ini adalah isi notifikasi 2',
      'images': 'https://kamdig.chaerul.biz.id/icon/information.png',
      'time': '09:00',
      'category': 'Pemberitahuan',
    },
    {
      'title': 'Informasi Aplikasi',
      'message': 'Update terbaru fitur aplikasi',
      'images': 'https://kamdig.chaerul.biz.id/icon/info (1).png',
      'time': '08:00',
      'category': 'Informasi',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: const Text('Notification'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notif = notifications[index];
            final bool hasImage = notif['images'] != 'null';

            return ListTile(
              leading:
                  hasImage
                      ? Image.network(
                        notif['images'],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                      : const Icon(Icons.notifications),
              title: Text(notif['title']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notif['message']),
                  const SizedBox(height: 4),
                  Text(
                    notif['time'],
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${notif['title']} ditekan')),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
