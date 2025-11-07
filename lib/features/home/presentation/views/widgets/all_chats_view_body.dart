import 'package:chats_app/features/home/data/models/chats_model.dart';
import 'package:chats_app/features/home/presentation/manager/chats_cubit/chats_cubit.dart';
import 'package:chats_app/features/search_users/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chats_app/core/my_account.dart';
import 'package:chats_app/features/home/presentation/views/widgets/friend_chat.dart';

class AllChatsViewBody extends StatefulWidget {
  const AllChatsViewBody({super.key});

  @override
  State<AllChatsViewBody> createState() => _AllChatsViewBodyState();
}

class _AllChatsViewBodyState extends State<AllChatsViewBody> {
  @override
  void initState() {
    super.initState();
    context.read<ChatsCubit>().getChatsWithFriends(my_email!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatsCubit, ChatsState>(
      builder: (context, state) {
        if (state is ChatsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ChatsError) {
          return Center(child: Text('Error: ${state.message}'));
        }

        if (state is ChatsWithUsersLoaded) {
          if (state.chatsWithUsers.isEmpty) {
            return const Center(child: Text("No chats yet 😅"));
          }

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: state.chatsWithUsers.length,
            itemBuilder: (context, index) {
              final chat = state.chatsWithUsers[index]['chat'] as ChatModel;
              final friend = state.chatsWithUsers[index]['friend'] as ChatUser;

              return FriendChat(chat: chat, friend: friend);
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
