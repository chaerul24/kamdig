import 'package:flutter/material.dart';
import 'package:kamdig/ViewPagerFragmentStylePage.dart';
import 'package:kamdig/dashboard.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/icon.png', width: 100, height: 100),
                const SizedBox(height: 20),
                const Text(
                  'Masuk ke Akun Anda.',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),

                // Email
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  height: 45,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person), // Icon di kiri
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Password
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  height: 45,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'password',
                      prefixIcon: Icon(Icons.lock), // Icon di kiri
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Tombol Login
                Container(
                  width: double.infinity,
                  height: 40,
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => const ViewPagerFragmentStylePage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 125, 126, 126),
                      width: 2,
                    ), // Mengatur warna dan ketebalan border
                    borderRadius: BorderRadius.circular(
                      8,
                    ), // Jika ingin memberi sudut melengkung
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Aplikasi ini hanya bisa diakses sama kampung yang sudah bekerja sama dengan kampung digital, Jika Kampung anda belum bekerja sama silahkan klik Free Trial',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color.fromARGB(255, 125, 126, 126),
                              ),
                            ),
                            SizedBox(height: 10),
                            const Text(
                              'Free Trial',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 2, 98, 224),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      'Hubungi Kami di :',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/ic_whatsapp.png',
                          width: 40,
                          height: 40,
                        ),
                        const SizedBox(width: 50),
                        Image.asset(
                          'assets/images/ic_instagram.png',
                          width: 40,
                          height: 40,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
