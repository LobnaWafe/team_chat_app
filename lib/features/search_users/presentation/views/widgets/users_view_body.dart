import 'package:chats_app/features/search_users/presentation/manager/cubit/users_cubit.dart';
import 'package:chats_app/features/search_users/presentation/views/widgets/users_accounts.dart';
import 'package:chats_app/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chats_app/features/home/presentation/views/widgets/custom_search.dart';
import 'package:go_router/go_router.dart';
import 'package:chats_app/generated/l10n.dart';

class UsersViewBody extends StatefulWidget {
  const UsersViewBody({super.key});

  @override
  State<UsersViewBody> createState() => _UsersViewBodyState();
}

class _UsersViewBodyState extends State<UsersViewBody> {
  String searchText = ''; // 👈 متغير نخزن فيه النص اللي بيتكتب

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(
      create: (_) => UsersCubit()..listenToUsers(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [const Color(0xFFCCE8FE), Colors.black, Colors.black]
                : const [Color(0xFFCCE8FE), Colors.white, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
          child: Column(
            children: [
              // ✅ AppBar بسيط
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back,
                        size: 31, color: Colors.black),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 10),

              // ✅ باقي المحتوى داخل ScrollView
              Expanded(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    // عنوان الصفحة + البحث
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Spacer(),
                              Text(
                                S.of(context).NewChat,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                          const SizedBox(height: 20),
                          // 👇 نمرر callback البحث
                          CustomSearch(
                            onChanged: (value) {
                              setState(() {
                                searchText = value.toLowerCase();
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),

                    // ✅ قائمة المستخدمين
                    BlocBuilder<UsersCubit, UsersState>(
                      builder: (context, state) {
                        if (state is UsersLoading) {
                          return const SliverFillRemaining(
                            child: Center(child: CircularProgressIndicator()),
                          );
                        } else if (state is UsersLoaded) {
                          var users = state.users;

                          // 🔍 الفلترة حسب النص المكتوب
                          if (searchText.isNotEmpty) {
                            users = users
                                .where((user) => (user.name ?? '')
                                    .toLowerCase()
                                    .startsWith(searchText))
                                .toList();
                          }

                          if (users.isEmpty) {
                            return SliverFillRemaining(
                              child: Center(
                                  child:
                                      Text(S.of(context).No_Users_yet)),
                            );
                          }

                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final user = users[index];
                                return GestureDetector(
                                  onTap: () {
                                    GoRouter.of(context).push(
                                      AppRouter.kChat,
                                      extra: user,
                                    );
                                  },
                                  child: UsersAccounts(chatUser: user),
                                );
                              },
                              childCount: users.length,
                            ),
                          );
                        } else if (state is UsersError) {
                          return SliverFillRemaining(
                            child: Center(
                              child: Text(
                                  'There is a wrong: ${state.message}'),
                            ),
                          );
                        }
                        return const SliverToBoxAdapter(child: SizedBox());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
