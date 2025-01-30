import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/pages/app/news_page.dart';
import 'package:myapp/pages/app/search_page.dart';
import 'package:myapp/pages/app/setting_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  bool isNotificationRead = false;

  final List<Widget> _children = [
    const NewsPage(), // Menampilkan NewsPage
    const SearchPage(), // Menampilkan SearchPage
    SettingPage(), // Menampilkan SettingPage
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void toggleNotification() {
    setState(() {
      isNotificationRead = !isNotificationRead;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Mendapatkan warna AppBar berdasarkan tema
    final appBarColor = Theme.of(context).appBarTheme.backgroundColor;
    // Menggunakan titleLarge atau bodyText1
    final textColor =
        Theme.of(context).textTheme.titleLarge?.color ?? Colors.black;
    final iconColor = Theme.of(context).iconTheme.color ?? Colors.black;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: SafeArea(
          child: AppBar(
            elevation: 0,
            backgroundColor: appBarColor, // Sesuaikan dengan warna tema
            flexibleSpace: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: Image.asset(
                      'assets/icons/menu_icon.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    'NewsApp',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color:
                          textColor, // Menggunakan warna teks berdasarkan tema
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isNotificationRead
                          ? Icons.notifications_off
                          : Icons.notifications,
                      color:
                          iconColor, // Menggunakan warna ikon berdasarkan tema
                    ),
                    onPressed: toggleNotification,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: _children[_currentIndex], // Menampilkan halaman yang dipilih
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
