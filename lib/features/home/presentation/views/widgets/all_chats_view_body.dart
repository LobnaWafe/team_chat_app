import 'package:chats_app/core/my_account.dart';
import 'package:chats_app/features/home/presentation/manager/chats_cubit/chats_cubit.dart';
import 'package:chats_app/features/home/presentation/views/widgets/custom_appbar.dart';
import 'package:chats_app/features/home/presentation/views/widgets/custom_search.dart';
import 'package:chats_app/features/home/presentation/views/widgets/friend_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AllChatsViewBody extends StatelessWidget {
  const AllChatsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(
      create: (context) => ChatsCubit()..getChats(my_email!),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? [const Color(0xFFCCE8FE), Colors.black, Colors.black]
                  : const [Color(0xFFCCE8FE), Colors.white, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 32, right: 16, left: 16),
            child: Column(
              children: [
                const CustomAppbar(),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Spacer(),
                    Text(
                      "Chat List",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                  ],
                ),
                const SizedBox(height: 20),
                const CustomSearch(),
                Expanded(
                  child: BlocBuilder<ChatsCubit, ChatsState>(
                    builder: (context, state) {
                      if (state is ChatsLoading) {
                        return const Center(
                            child: CircularProgressIndicator());
                      } else if (state is ChatsLoaded) {
                        if (state.chats.isEmpty) {
                          return const Center(child: Text("No Chats Yet"));
                        }

                        return ListView.builder(
                          itemCount: state.chats.length,
                          itemBuilder: (context, index) {
                            final chat = state.chats[index];
                            final members = chat.members;

                            final friendEmail = members.firstWhere(
                              (email) => email != my_email,
                              orElse: () => "Unknown",
                            );

                            final lastMessage = chat.lastMessage;
                            final lastTime = chat.lastMessageTime != null
                                ? DateFormat('hh:mm a')
                                    .format(chat.lastMessageTime!)
                                : '';

                            return FriendChat(
                              imageUrl: chat.imageUrl,
                              friendEmail: friendEmail,
                              lastMessage: lastMessage,
                              lastTime: lastTime,
                            );
                          },
                        );
                      } else if (state is ChatsError) {
                        return Center(child: Text('Error: ${state.message}'));
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
