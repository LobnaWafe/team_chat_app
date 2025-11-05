import 'package:chats_app/features/home/presentation/views/widgets/custom_search.dart';
import 'package:chats_app/features/search_users/presentation/views/widgets/users_accounts.dart';
import 'package:flutter/material.dart';

class UsersViewBody extends StatelessWidget {
  const UsersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
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
        padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_back, size: 31,color: Colors.black,),
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: 20),
            const Row(
              children: [
                Spacer(),
                Text(
                  "Users In The Server",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: 20),
            CustomSearch(),
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return const UsersAccounts();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
