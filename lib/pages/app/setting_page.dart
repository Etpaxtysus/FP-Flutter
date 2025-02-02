import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SettingPage extends StatelessWidget {
  SettingPage({super.key});
  final RxBool isDarkMode = RxBool(Get.isDarkMode);

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Settings',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          ListTile(
            leading: Icon(Icons.account_circle, color: Colors.blue),
            title: Text('Profile'),
            subtitle: user != null
                ? Text('Email: ${user.email}')
                : Text('Not Logged In'),
            onTap: () {},
          ),
          Obx(() {
            return ListTile(
              leading: Icon(Icons.dark_mode, color: Colors.blue),
              title: Text('Dark Mode'),
              trailing: Switch(
                value: isDarkMode
                    .value, 
                onChanged: (bool value) {
                  isDarkMode.value = value;
                  Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
                },
              ),
            );
          }),

          const Divider(),

          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text('Logout'),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Get.offAllNamed('/get-started');
            },
          ),
        ],
      ),
    );
  }
}
