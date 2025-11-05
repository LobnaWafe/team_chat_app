import 'package:chats_app/features/home/presentation/views/widgets/theme_toggle_app.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back,size: 31,color: Colors.black,),
        ),
        Spacer(),
       ThemeToggleApp(),
      ],
    );
  }
}
