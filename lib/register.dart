import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kamdig/Opencamera.dart';
import 'package:kamdig/ViewPagerFragmentStylePage.dart';
import 'package:kamdig/serve/HttpConnectApi.dart';

void main() {
  runApp(const RegisterApp(imagePath: ''));
}

class RegisterApp extends StatelessWidget {
  final String imagePath;

  const RegisterApp({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: RegisterPage(imagePath: imagePath),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RegisterPage extends StatefulWidget {
  final String imagePath;

  const RegisterPage({super.key, required this.imagePath});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final numberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final Httpconnectapi _httpConnectApi = Httpconnectapi();

  bool isLoading = false;

  void _register() async {
    setState(() => isLoading = true);

    final data = {
      'username': usernameController.text.trim(),
      'email': emailController.text.trim(),
      'number': numberController.text.trim(),
      'password': passwordController.text,
      'password_confirm': confirmPasswordController.text,
      'image_ktp': widget.imagePath,
    };

    try {
      final response = await _httpConnectApi.postFormData('app/register', data);

      setState(() => isLoading = false);

      if (response['status'] == 'success') {
        final token = response['token'];
        final user = response['user'];
        print('JWT Token: $token');
        print('User: $user');

        // Navigasi ke halaman berikutnya
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registrasi berhasil!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const ViewPagerFragmentStylePage(),
          ),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response['message'] ?? 'Registrasi gagal'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: $e'),
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
              children: [
                Image.asset('assets/images/icon.png', width: 100, height: 100),
                const SizedBox(height: 20),
                const Text(
                  'Daftar akun Anda.',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),

                // Username
                _buildTextField(
                  controller: usernameController,
                  label: 'Username',
                  icon: Icons.person,
                ),
                const SizedBox(height: 15),

                // Email
                _buildTextField(
                  controller: emailController,
                  label: 'Email',
                  icon: Icons.email,
                ),
                const SizedBox(height: 15),

                // Number
                _buildTextField(
                  controller: numberController,
                  label: 'Number',
                  icon: Icons.phone,
                ),
                const SizedBox(height: 15),

                // Password
                _buildTextField(
                  controller: passwordController,
                  label: 'Password',
                  icon: Icons.lock,
                  isObscure: true,
                ),
                const SizedBox(height: 15),

                // Password Confirmation
                _buildTextField(
                  controller: confirmPasswordController,
                  label: 'Password Confirmation',
                  icon: Icons.lock,
                  isObscure: true,
                ),
                const SizedBox(height: 20),

                // Gambar KTP
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OpencameraPage(),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child:
                        widget.imagePath != 'null'
                            ? Image.file(
                              File(widget.imagePath),
                              width: double.infinity,
                              height: 146,
                              fit: BoxFit.cover,
                            )
                            : Image.asset(
                              'assets/images/ktp.png',
                              width: 60,
                              height: 60,
                            ),
                  ),
                ),

                const SizedBox(height: 30),

                // Register Button
                Container(
                  width: double.infinity,
                  height: 45,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _register,
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
                              'Register',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isObscure = false,
  }) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        obscureText: isObscure,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
