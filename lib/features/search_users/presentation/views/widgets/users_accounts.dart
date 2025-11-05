import 'package:flutter/material.dart';

class UsersAccounts extends StatelessWidget {
  const UsersAccounts({super.key});

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
            subtitle: Text("fatma@gmail.com", style: TextStyle(color: Colors.grey)),

          ),
        ),
      ],
    );
  }
}
