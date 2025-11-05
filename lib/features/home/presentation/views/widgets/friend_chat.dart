import 'package:flutter/material.dart';

class FriendChat extends StatelessWidget {
  const FriendChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage('assets/images/profile.png'),
        ),
        Expanded(
          child: ListTile(
            title: Text(
              "Fatma Ramadan",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("Hellooo", style: TextStyle(color: Colors.grey)),
            trailing: Text(
              "12:45 PM",
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}
