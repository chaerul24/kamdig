import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kamdig/Chat.dart';
import 'package:kamdig/Notification.dart';
import 'package:kamdig/Profile.dart';
import 'package:kamdig/dashboard.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

///
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // WAJIB buat nunggu async
  await initializeDateFormatting('id_ID', null); // Inisialisasi format lokal
  runApp(const ViewPagerFragmentStylePage());
}

class ViewPagerFragmentStylePage extends StatefulWidget {
  const ViewPagerFragmentStylePage({super.key});

  @override
  State<ViewPagerFragmentStylePage> createState() =>
      _ViewPagerFragmentStylePageState();
}

class _ViewPagerFragmentStylePageState extends State<ViewPagerFragmentStylePage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  late AnimationController _animationController;
  late Animation<double> _appBarOpacity;
  void showModernInputSheet() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 16,
            left: 24,
            right: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Bar penanda bisa ditarik
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Isi Data Pengguna',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Simpan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  final nama = nameController.text;
                  final email = emailController.text;
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Tersimpan: $nama ($email)')),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  List<Widget> get _pages => [DashboardPage(), ChatPage(), Profile()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller for smooth AppBar animation
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _appBarOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          _selectedIndex != 2
              ? PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: AnimatedBuilder(
                  animation: _appBarOpacity,
                  builder: (context, child) {
                    return AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      automaticallyImplyLeading: false,
                      title: Row(
                        children: [
                          Image.asset('assets/images/icon.png', height: 40),
                          const SizedBox(width: 10),
                          if (_selectedIndex == 2)
                            const Text(
                              'Profile',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          if (_selectedIndex == 1)
                            const Text(
                              'Chating',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          if (_selectedIndex == 0)
                            const Text(
                              'Home',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                        ],
                      ),
                      actions: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.dark_mode,
                            color:
                                _appBarOpacity.value == 1.0
                                    ? Colors.black
                                    : Colors.white,
                          ),
                        ),
                        if (_selectedIndex == 0)
                          IconButton(
                            icon: const Icon(
                              Icons.notifications,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NotificationApp(),
                                  ),
                                );
                              });
                            },
                          ),
                        if (_selectedIndex == 1)
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  showModernInputSheet();
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.group_add,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Buat group')),
                                  );
                                },
                              ),
                            ],
                          ),
                        if (_selectedIndex == 2)
                          IconButton(
                            icon: const Icon(
                              Icons.exit_to_app_sharp,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Tambah chat belum dibuat 😄'),
                                ),
                              );
                            },
                          ),
                      ],
                    );
                  },
                ),
              )
              : null, // If profile is selected, don't show AppBar
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        height: 60.0,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: _selectedIndex == 0 ? Colors.white : Colors.white60,
          ),
          Icon(
            Icons.message,
            size: 30,
            color: _selectedIndex == 1 ? Colors.white : Colors.white60,
          ),
          Icon(
            Icons.person,
            size: 30,
            color: _selectedIndex == 2 ? Colors.white : Colors.white60,
          ),
        ],
        onTap: (index) {
          _onItemTapped(index);
        },
        backgroundColor: Colors.white,
        color: Colors.blueAccent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
      ),
    );
  }
}
