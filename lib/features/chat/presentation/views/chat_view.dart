import 'package:chats_app/features/chat/presentation/view_models/chat_cubit/chat_cubit.dart';
import 'package:chats_app/features/chat/widgets/chat_view_body.dart';
import 'package:chats_app/features/chat/widgets/custom_app_bar.dart';
import 'package:chats_app/features/search_users/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key, required this.chatUser});
 final ChatUser chatUser;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: Scaffold(
        appBar: AppBar(elevation: 0, title: AppBarRow(chatUser:chatUser)),
        body: SafeArea(child: ChatViewBody(chatUser: chatUser,)),
      ),
    );
  }
}
