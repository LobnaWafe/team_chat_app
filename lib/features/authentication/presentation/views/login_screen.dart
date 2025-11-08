
import 'package:chats_app/core/my_account.dart';
import 'package:chats_app/features/authentication/presentation/view_model/cubits/cubit/auth_cubit.dart';
import 'package:chats_app/features/authentication/presentation/widgets/TextField.dart';
import 'package:chats_app/features/authentication/presentation/widgets/custom_button.dart';
import 'package:chats_app/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message, Color color) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB9E2FF), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthLoading) {
                  _showSnackBar('Logging in...', Colors.blueAccent);
                } else if (state is AuthSuccess) {
                  _showSnackBar(state.message, Colors.green);
                //  Navigator.pushReplacementNamed(context, '/home');
                GoRouter.of(context).pushReplacement(AppRouter.knormalNavigation);
                
                } else if (state is AuthError) {
                  _showSnackBar(state.message, Colors.redAccent);
                }
              },
              builder: (context, state) {
                return ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Color(0xFF1C3A5F), size: 24),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Center(
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 1.1),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Center(child: Image.asset("assets/image/sign_icon.png", height: 100)),
                    const SizedBox(height: 20),
                    CustomTextField(name: "Email", hint: "Enter your email", controller: emailController),
                    const SizedBox(height: 15),
                    CustomTextField(name: "Password", hint: "Enter your password", obscure: true, controller: passwordController),
                    const SizedBox(height: 25),
                    Center(
                      child: CustomButton(
                        text: "Login",
                        onTap: () {
                          context.read<AuthCubit>().login(
                                email: emailController.text.trim(),
                                password: passwordController.text,
                              );
                              my_email=emailController.text.trim(); //<--
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}