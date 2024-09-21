import 'package:flutter/material.dart';
import 'package:pop_up_the_local/services/login_service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인'),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Center(
                child: IconButton.filled(
                    onPressed: nativeGoogleSignIn, icon: Icon(Icons.login))),
            Expanded(
              child: Container(
                color: const Color(0xffF2F2F7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
