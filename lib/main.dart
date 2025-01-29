import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:myapp/pages/app/get_started_page.dart';
import 'package:myapp/pages/app/main_page.dart';
import 'package:myapp/pages/app/news_detail_page.dart';
import 'package:myapp/pages/auth/login_page.dart';
import 'package:myapp/pages/auth/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inisialisasi Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Final Project',
      initialRoute: '/get-started',
      getPages: [
        GetPage(name: '/get-started', page: () => const GetStartedPage()),
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/register', page: () => const RegisterPage()),
        GetPage(name: '/main', page: () => const MainPage()),
        GetPage(name: '/news-detail', page: () => const NewsDetailPage()),
      ],
    );
  }
}
