import 'package:chats_app/features/home/presentation/views/widgets/custom_appbar.dart';
import 'package:chats_app/features/home/presentation/views/widgets/custom_search.dart';
import 'package:chats_app/features/home/presentation/views/widgets/friend_chat.dart';
import 'package:flutter/material.dart';

class AllChatsViewBody extends StatelessWidget {
  const AllChatsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [Color(0xFFCCE8FE), Colors.black, Colors.black]
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
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                ],
              ),
              const SizedBox(height: 20),
              const CustomSearch(),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const FriendChat();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
