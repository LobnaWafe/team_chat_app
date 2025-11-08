import 'package:chats_app/features/search_users/presentation/manager/cubit/users_cubit.dart';
import 'package:chats_app/features/search_users/presentation/views/widgets/users_accounts.dart';
import 'package:chats_app/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chats_app/features/home/presentation/views/widgets/custom_search.dart';
import 'package:go_router/go_router.dart';

class UsersViewBody extends StatelessWidget {
  const UsersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(
      create: (_) => UsersCubit()..listenToUsers(), // أو getUsers() لو عايزة مرة واحدة
      child: Container(
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
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back, size: 31, color: Colors.black),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
              const CustomSearch(),
              const SizedBox(height: 10),

              Expanded(
                child: BlocBuilder<UsersCubit, UsersState>(
                  builder: (context, state) {
                    if (state is UsersLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is UsersLoaded) {
                      final users = state.users;
                      if (users.isEmpty) {
                        return const Center(child: Text('No Users yet'));
                      }
                      return ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final user = users[index];
                          return GestureDetector(
                            onTap: (){
                              GoRouter.of(context).push(AppRouter.kChat,extra: users[index]);
                            },
                            child: UsersAccounts(
                             chatUser: user,
                            ),
                          );
                        },
                      );
                    } else if (state is UsersError) {
                      return Center(child: Text('There is a wrong: ${state.message}'));
                    }
                    return const SizedBox.shrink();
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
