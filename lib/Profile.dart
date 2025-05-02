import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> data = [
      {
        "avatar": "https://avatars.githubusercontent.com/u/160778594?v=4",
        "username": "Chaerul MobDev",
        "email": "chaerul@gmail.com",
      },
    ];

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ClipOval(
            child: Image.network(
              data[0]["avatar"],
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            data[0]["username"],
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(data[0]["email"], style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          Container(
            width: 250,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.black, // Warna stroke
                width: 1, // Tebal stroke
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Teks di tengah
                const Center(
                  child: Text(
                    'Ubah Profil',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Icon di kiri
                const Positioned(
                  left: 16,
                  child: Icon(Icons.edit, color: Colors.black),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          Container(
            width: 250,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Teks di tengah
                const Center(
                  child: Text(
                    'Dompet Saya',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Gambar di kiri
                Positioned(
                  left: 16,
                  child: Image.asset(
                    'assets/images/ic_wallet_black.png',
                    width: 24,
                    height: 24,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          Container(
            width: 250,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.black, // Warna stroke
                width: 1, // Tebal stroke
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Teks di tengah
                const Center(
                  child: Text(
                    'Tentang Aplikasi',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Icon di kiri
                const Positioned(
                  left: 16,
                  child: Icon(Icons.info_outline, color: Colors.black),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          Container(
            width: 250,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.black, // Warna stroke
                width: 1, // Tebal stroke
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Teks di tengah
                const Center(
                  child: Text(
                    'Pengaturan',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Icon di kiri
                const Positioned(
                  left: 16,
                  child: Icon(Icons.settings, color: Colors.black),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          Container(
            width: 250,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.red, // Warna stroke
                width: 1, // Tebal stroke
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Teks di tengah
                const Center(
                  child: Text(
                    'LogOut',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Icon di kiri
                const Positioned(
                  left: 16,
                  child: Icon(Icons.exit_to_app_sharp, color: Colors.red),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
