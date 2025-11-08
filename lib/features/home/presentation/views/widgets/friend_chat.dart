import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:chats_app/features/home/data/models/chats_model.dart';
import 'package:chats_app/features/search_users/data/models/user_model.dart';

class FriendChat extends StatelessWidget {
  final ChatModel chat;
  final ChatUser friend;
  final VoidCallback? onTap;

  const FriendChat({
    super.key,
    required this.chat,
    required this.friend,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final time = chat.lastMessageTime != null
        ? DateFormat('hh:mm a').format(chat.lastMessageTime!)
        : '';

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: friend.imageUrl.isNotEmpty
            ? NetworkImage(friend.imageUrl)
            : const AssetImage('assets/images/profile.png') as ImageProvider,
        radius: 25,
      ),
      title: Text(
        friend.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        chat.lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        time,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
      onTap: onTap,
    );
  }
}