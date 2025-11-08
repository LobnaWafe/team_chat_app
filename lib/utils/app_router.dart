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
  static final String kSignUp = "/sign_up_view";
  static final String kSignIn = "/login_view";
  static final String kChat = "/chat_view";
  static final String kProfile = "/profile_view";
  static final String kMap = "/map_view";
  static final String knormalNavigation = "/normal_navigation_view";
  static final String kWelcome = "/welcome_view";

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          final userString = CacheHelper.getData(key: "user");
          if (userString != null) {
            try {
              final userMap = jsonDecode(userString);
              final userModel = UserModel.fromJson(userMap);
              my_email = userModel.email;
              log("user found");
              return NormalBottom();
            } on Exception catch (e) {
              log("user not found ");
            }
          }

<<<<<<< HEAD
  GoRoute(path: kChat,builder: (context,state)=>ChatView()),
    GoRoute(path: '/',builder: (context,state)=>LoginScreen()),
    GoRoute(path: kProfile,builder: (context,state)=>ProfileView()),
    GoRoute(path: kSignUp,builder: (context,state)=>SignUpScreen()),
    GoRoute(path: knormalNavigation,builder: (context,state)=>NormalBottom()),
    GoRoute(path: kMap,builder: (context,state){
    final data = state.extra as Map<String, dynamic>;
    return MapView(
      senderEmail: data['senderEmail'],
      reciverEmail: data['reciverEmail'],
    );
    }),
  
  ]);
}
=======
          return WelcomeScreen();
        },
      ),
      GoRoute(
        path: kChat,
        builder: (context, state) {
          final data = state.extra as ChatUser;
          return ChatView(chatUser: data);
        },
      ),
      GoRoute(path: kSignIn, builder: (context, state) => LoginScreen()),
      GoRoute(path: kProfile, builder: (context, state) => ProfileView()),
      GoRoute(path: kSignUp, builder: (context, state) => SignUpScreen()),
       GoRoute(path: kWelcome, builder: (context, state) => WelcomeScreen()),
      GoRoute(
        path: knormalNavigation,
        builder: (context, state) => NormalBottom(),
      ),
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
>>>>>>> 6f663ea56d3c242300646ffd81572cc0dcec1a85
