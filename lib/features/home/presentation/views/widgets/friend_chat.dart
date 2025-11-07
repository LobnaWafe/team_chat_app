import 'package:flutter/material.dart';

class FriendChat extends StatelessWidget {
  final String imageUrl;
  final String friendEmail;
  final String lastMessage;
  final String lastTime;

  const FriendChat({
    super.key,
    required this.imageUrl,
    required this.friendEmail,
    required this.lastMessage,
    required this.lastTime,
  });

  @override
  Widget build(BuildContext context) {
    ImageProvider avatarImage;

    if (imageUrl.startsWith('assets/')) {
      avatarImage = AssetImage(imageUrl);
    } else if (imageUrl.isNotEmpty) {
      avatarImage = NetworkImage(imageUrl);
    } else {
      avatarImage = const AssetImage('assets/images/profile.png');
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: avatarImage,
          ),
          Expanded(
            child: ListTile(
              title: Text(
                friendEmail,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle:
                  Text(lastMessage, style: const TextStyle(color: Colors.grey)),
              trailing: Text(
                lastTime,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              onTap: () {
                // TODO: انتقلي لشاشة الشات مع اليوزر ده
              },
            ),
          ),
        ],
      ),
    );
  }
}
