import 'package:flutter/material.dart';
import 'package:kamdig/ViewPagerFragmentStylePage.dart';
import 'package:kamdig/register.dart';
import 'package:kamdig/serve/HttpConnectApi.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final Httpconnectapi _httpConnectApi = Httpconnectapi();
  final storage = FlutterSecureStorage();

  bool isLoading = false;

  void _login() async {
    setState(() => isLoading = true);

    final data = {
      'username': usernameController.text.trim(),
      'password': passwordController.text,
    };

    try {
      final response = await _httpConnectApi.postFormData('app/login', data);

      setState(() => isLoading = false);

      if (response['status'] == 'success') {
        final token = response['token'];
        final user = response['user'];
        print('JWT Token: $token');
        print('User: $user');

        var check = await _httpConnectApi.saveToken(token);
        if (check) {
          print('Token saved successfully');
        } else {
          print('Failed to save token');
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login berhasil!'),
            backgroundColor: Colors.green,
          ),
        );
        // Navigasi ke halaman berikutnya setelah login berhasil
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ViewPagerFragmentStylePage(),
          ),
        );
      } else {
        // If there's an error, show the error message
        print('Error Response: ${response['message']}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response['message'] ?? 'Login gagal'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      setState(() => isLoading = false);
      print('Error during POST request: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

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

                // Username
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 45,
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Password
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 45,
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
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
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child:
                        isLoading
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                            : const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                  ),
                ),

                const SizedBox(height: 30),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => const RegisterApp(imagePath: 'null'),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 125, 126, 126),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Aplikasi ini hanya bisa diakses sama kampung yang sudah bekerja sama dengan kampung digital. Jika Kampung anda belum bekerja sama silahkan klik Free Trial',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color.fromARGB(255, 125, 126, 126),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Free Trial',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 2, 98, 224),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Column(
                  children: [
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
