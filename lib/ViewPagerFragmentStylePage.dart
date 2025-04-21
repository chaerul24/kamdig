import 'package:flutter/material.dart';
import 'package:kamdig/Chat.dart';
import 'package:kamdig/dashboard.dart';

class ViewPagerFragmentStylePage extends StatefulWidget {
  const ViewPagerFragmentStylePage({Key? key}) : super(key: key);

  @override
  State<ViewPagerFragmentStylePage> createState() =>
      _ViewPagerFragmentStylePageState();
}

class _ViewPagerFragmentStylePageState
    extends State<ViewPagerFragmentStylePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = const [
    DashboardApp(),
    ChatPage(),
    SettingsFragment(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Fragment-style PageView')),
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() => _selectedIndex = index);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

// Fragment-style widget 3
class SettingsFragment extends StatelessWidget {
  const SettingsFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Ini Settings Fragment'));
  }
}
