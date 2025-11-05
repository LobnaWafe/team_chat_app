import 'package:chats_app/features/authentication/presentation/views/sign_up_view.dart';
import 'package:chats_app/features/chat/presentation/views/chat_view.dart';
import 'package:chats_app/features/chat/presentation/views/map_view.dart';
import 'package:chats_app/features/profile/presentation/view/profile_view.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static final String kSignUp = "/sign_up_view";
  static final String kChat = "/chat_view";
  static final String kProfile = "/profile_view";
  static final String kMap = "/map_view";

  static final router = GoRouter(routes: [

   GoRoute(path: "/",builder: (context,state)=>ChatView()),
   // GoRoute(path: '/',builder: (context,state)=>SignInView()),
    GoRoute(path: '/',builder: (context,state)=>ProfileView()),
    GoRoute(path: kSignUp,builder: (context,state)=>SignUpView()),
    GoRoute(path: kMap,builder: (context,state){
    final data = state.extra as Map<String, dynamic>;
    return MapView(
      senderEmail: data['senderEmail'],
      reciverEmail: data['reciverEmail'],
    );
    }),
   
  ]);
}