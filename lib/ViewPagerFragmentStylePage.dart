import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kamdig/Chat.dart';
import 'package:kamdig/Profile.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kamdig/dashboard.dart';
import 'package:kamdig/news.dart';

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
  /*************  ✨ Windsurf Command ⭐  *************/
  /// Creates the state of the ViewPagerFragmentStylePage widget.
  ///
  /// This function is invoked by the framework when the
  /// ViewPagerFragmentStylePage widget is inserted into the tree. It
  /// returns an instance of `_ViewPagerFragmentStylePageState`, which
  /// is the state of the ViewPagerFragmentStylePage.
  /*******  7f99568c-a08e-40ca-bc27-33b330fce578  *******/
  final PageController _pageController = PageController();
  late AnimationController _animationController;
  late Animation<double> _appBarOpacity;

  List<Widget> get _pages => [DashboardPage(), ChatPage(), Profile()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Belum ada notifikasi 😴'),
                                ),
                              );
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
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Tambah chat belum dibuat 😄',
                                      ),
                                    ),
                                  );
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
            // Trigger the animation only when the selected page changes
            if (_selectedIndex == 2) {
              _animationController.forward();
            } else {
              _animationController.reverse();
            }
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
