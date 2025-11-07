import 'package:chats_app/features/search_users/data/models/user_model.dart';
import 'package:flutter/material.dart';

class UsersAccounts extends StatelessWidget {
  final ChatUser chatUser; 

  const UsersAccounts({
    super.key,
    required this.chatUser,
  });

  @override
  Widget build(BuildContext context) {
    final String name = chatUser.name;
    final String email = chatUser.email;
    final String imageUrl = chatUser.imageUrl;

    ImageProvider avatarImage;
    if (imageUrl.startsWith('assets/')) {
      avatarImage = AssetImage(imageUrl);
    } else {
      avatarImage = NetworkImage(imageUrl);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: avatarImage,
          ),
          Expanded(
            child: ListTile(
              title: Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                email,
                style: const TextStyle(color: Colors.grey),
              ),
              onTap: () {
             
              },
            ),
          ),
        ],
      ),
    );
  }
}
