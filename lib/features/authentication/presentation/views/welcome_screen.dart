import 'package:chats_app/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB9E2FF), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Chat App',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Start with signing up or sign in',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 50),
            Image.asset('assets/image/chat_icon.png', height: 100),
            const SizedBox(height: 80),
            CustomButton(
              text: "Sign In",
              onTap: () {
               // Navigator.pushNamed(context, '/login');
                GoRouter.of(context).push(AppRouter.kSignIn);
              },
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: "Sign Up",
              onTap: () {
               // Navigator.pushNamed(context, '/signup');
                GoRouter.of(context).push(AppRouter.kSignUp);
              },
            ),
          ],
        ),
      ),
    );
  }
}
