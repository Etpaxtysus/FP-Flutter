import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    void register() async {
      if (passwordController.text.trim() !=
          confirmPasswordController.text.trim()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password tidak cocok')),
        );
        return;
      }

      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registrasi berhasil!')),
        );
        Get.offAllNamed('/main');
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Terjadi kesalahan')),
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
                  'Selamat Datang',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff3498DB),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  'Silahkan Mendaftar',
                  style: TextStyle(
                    fontSize: 16,
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
              PasswordTextFormField(
                label: 'Konfirmasi Password',
                controller: confirmPasswordController,
              ),
              SizedBox(
                height: 52,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      backgroundColor: Color(0xff3498DB)),
                  onPressed: register,
                  child:
                      Text('Mendaftar', style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Sudah punya akun? silahkan '),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/login');
                    },
                    child: Text(
                      'masuk',
                      style: TextStyle(
                        color: Color(0xff3498DB),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
      padding: const EdgeInsets.only(bottom: 25),
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
