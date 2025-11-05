
import 'package:flutter/material.dart';

class AppBarRow extends StatelessWidget {
  const AppBarRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 22, // حجم الصورة
          backgroundColor: Colors.transparent, // لون الخلفية لو الصورة ما اتحملت
          backgroundImage: NetworkImage(
            "https://hkxtaqbisnboczqhsodv.supabase.co/storage/v1/object/public/avatars/profilePhotos/1759188884597.png",
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          "Lobna Wafe",
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}