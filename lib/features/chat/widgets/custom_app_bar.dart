
import 'package:chats_app/features/search_users/data/models/user_model.dart';
import 'package:flutter/material.dart';

class AppBarRow extends StatelessWidget {
  const AppBarRow({super.key, required this.chatUser});
final ChatUser chatUser;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         CircleAvatar(
          radius: 22, // حجم الصورة
          backgroundColor: Colors.transparent, // لون الخلفية لو الصورة ما اتحملت
          backgroundImage:  chatUser.imageUrl.isNotEmpty
            ? NetworkImage(chatUser.imageUrl)
            : const AssetImage('assets/images/profile.png') as ImageProvider,
        ),
        const SizedBox(width: 8),
         Text(
          chatUser.name ,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}