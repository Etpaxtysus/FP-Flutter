import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    void login() async {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login berhasil!')),
        );
        Get.offAllNamed('/main');
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Login gagal')),
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: ListView(
            children: [
              Center(
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/icons/logo.png'),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'Selamat Datang Kembali',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff3498DB),
                  ),
                ),
              ),
              SizedBox(height: 40),
              CustomTextFormField(
                label: 'Email',
                controller: emailController,
              ),
              PasswordTextFormField(
                label: 'Password',
                controller: passwordController,
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 52,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      backgroundColor: Color(0xff3498DB)),
                  onPressed: login,
                  child: Text('Masuk', style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Belum punya akun? '),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/register');
                    },
                    child: Text(
                      'Mendaftar',
                      style: TextStyle(
                        color: Color(0xff3498DB),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(' sekarang')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key, required this.label, required this.controller});
  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
              label: Text(
                label,
                style: TextStyle(color: Color(0xffC0C0C0)),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffC0C0C0)),
              ))),
    );
  }
}

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField(
      {super.key, required this.label, required this.controller});
  final String label;
  final TextEditingController controller;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: widget.controller,
        obscureText: _isObscured,
        decoration: InputDecoration(
          label: Text(
            widget.label,
            style: TextStyle(color: Color(0xffC0C0C0)),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffC0C0C0)),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _isObscured = !_isObscured;
              });
            },
            child: Container(
              padding: EdgeInsets.all(5),
              child: Image.asset(
                _isObscured
                    ? 'assets/images/hide.png'
                    : 'assets/images/view.png',
                width: 24,
                height: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
