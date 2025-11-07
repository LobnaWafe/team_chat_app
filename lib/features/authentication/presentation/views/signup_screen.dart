import 'dart:io';
import 'package:chats_app/core/my_account.dart';
import 'package:chats_app/features/authentication/presentation/view_model/cubits/cubit/auth_cubit.dart';
import 'package:chats_app/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/TextField.dart';
import '../widgets/custom_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );
      if (picked != null) {
        setState(() {
          _imageFile = File(picked.path);
        });
      }
    } catch (_) {
      _showSnackBar('Failed to pick image', Colors.redAccent);
    }
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
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB9E2FF), Color(0xFFFFFFFF)],
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthLoading) {
                  _showSnackBar('Creating account...', Colors.blueAccent);
                } else if (state is AuthSuccess) {
                  _showSnackBar(state.message, Colors.green);
                //  Navigator.pushReplacementNamed(context, '/login');
                GoRouter.of(context).push(AppRouter.kSignIn);
                } else if (state is AuthError) {
                  _showSnackBar(state.message, Colors.redAccent);
                }
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Color(0xFF1C3A5F),
                            size: 22,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: _pickImageFromGallery,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white.withOpacity(0.2),
                          backgroundImage: _imageFile != null
                              ? FileImage(_imageFile!)
                              : const AssetImage('assets/image/sign_icon.png'),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets.all(5),
                              child: const Icon(
                                Icons.camera_alt,
                                size: 16,
                                color: Color(0xFF5EBBFF),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        name: "Name",
                        hint: "Enter your name",
                        controller: _nameController,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        name: "Email",
                        hint: "Enter your email",
                        controller: _emailController,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        name: "Password",
                        hint: "Enter your password",
                        obscure: true,
                        controller: _passwordController,
                      ),
                      const SizedBox(height: 18),
                      CustomButton(
                        text: "Sign Up",
                        onTap: () {
                          context.read<AuthCubit>().signUp(
                                name: _nameController.text.trim(),
                                email: _emailController.text.trim(),
                                password: _passwordController.text,
                                image: _imageFile,
                              );
                              my_email=_emailController.text.trim();
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(color: Colors.black54),
                          ),
                          TextButton(
                            onPressed: () {
                              
                              GoRouter.of(context).pushReplacement(AppRouter.kSignIn);

                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: Color(0xFF5EBBFF),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
