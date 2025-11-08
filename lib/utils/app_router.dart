import 'dart:convert';
import 'dart:developer';

import 'package:chats_app/cach/cach_helper.dart';
import 'package:chats_app/core/my_account.dart';
import 'package:chats_app/features/authentication/data/models/user_model.dart';
import 'package:chats_app/features/authentication/presentation/views/login_screen.dart';
import 'package:chats_app/features/authentication/presentation/views/signup_screen.dart';
import 'package:chats_app/features/authentication/presentation/views/welcome_screen.dart';
import 'package:chats_app/features/chat/presentation/views/chat_view.dart';
import 'package:chats_app/features/chat/presentation/views/map_view.dart';
import 'package:chats_app/features/profile/presentation/view/profile_view.dart';
import 'package:chats_app/features/search_users/data/models/user_model.dart';
import 'package:chats_app/navigaton.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const String kSignUp = "/sign_up_view";
  static const String kSignIn = "/login_view";
  static const String kChat = "/chat_view";
  static const String kProfile = "/profile_view";
  static const String kMap = "/map_view";
  static const String knormalNavigation = "/normal_navigation_view";
  static const String kWelcome = "/welcome_view";

  static final router = GoRouter(
    routes: [
      // ✅ المسار الرئيسي (تحديد البداية)
      GoRoute(
        path: '/',
        builder: (context, state) {
          final userString = CacheHelper.getData(key: "user");
          if (userString != null) {
            try {
              final userMap = jsonDecode(userString);
              final userModel = UserModel.fromJson(userMap);
              my_email = userModel.email;
              log("✅ user found");
              return NormalBottom();
            } on Exception catch (e) {
              log("⚠️ user not found: $e");
            }
          }
          return const WelcomeScreen();
        },
      ),

      // ✅ شاشة الشات
      GoRoute(
        path: kChat,
        builder: (context, state) {
          final data = state.extra as ChatUser;
          return ChatView(chatUser: data);
        },
      ),

      // ✅ شاشة تسجيل الدخول
      GoRoute(
        path: kSignIn,
        builder: (context, state) => const LoginScreen(),
      ),

      // ✅ شاشة تسجيل الحساب
      GoRoute(
        path: kSignUp,
        builder: (context, state) => const SignUpScreen(),
      ),

      // ✅ شاشة البروفايل
      GoRoute(
        path: kProfile,
        builder: (context, state) => const ProfileView(),
      ),

      // ✅ شاشة الـ Navigation (القائمة السفلية)
      GoRoute(
        path: knormalNavigation,
        builder: (context, state) => NormalBottom(),
      ),

  
      GoRoute(
        path: kWelcome,
        builder: (context, state) => WelcomeScreen()
      ),

      // ✅ شاشة الخريطة
      GoRoute(
        path: kMap,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          return MapView(
            senderEmail: data['senderEmail'],
            reciverEmail: data['reciverEmail'],
          );
        },
      ),
    ],
  );
}
