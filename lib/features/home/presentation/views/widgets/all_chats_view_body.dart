import 'package:chats_app/features/home/data/models/chats_model.dart';
import 'package:chats_app/features/home/presentation/manager/chats_cubit/chats_cubit.dart';
import 'package:chats_app/features/home/presentation/views/widgets/custom_appbar.dart';
import 'package:chats_app/features/search_users/data/models/user_model.dart';
import 'package:chats_app/generated/l10n.dart';
import 'package:chats_app/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chats_app/core/my_account.dart';
import 'package:chats_app/features/home/presentation/views/widgets/friend_chat.dart';
import 'package:chats_app/features/home/presentation/views/widgets/custom_search.dart';
import 'package:go_router/go_router.dart';

class AllChatsViewBody extends StatefulWidget {
  const AllChatsViewBody({super.key});

  @override
  State<AllChatsViewBody> createState() => _AllChatsViewBodyState();
}

class _AllChatsViewBodyState extends State<AllChatsViewBody> {
  String searchText = ''; // 🔍 لتخزين النص المكتوب في البحث

  @override
  void initState() {
    super.initState();
    context.read<ChatsCubit>().listenToChatsWithFriends(my_email!);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
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
            const CustomAppbar(),
            const SizedBox(height: 10),
            Expanded(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // ✅ العنوان + البحث
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Spacer(),
                            Text(
                              S.of(context).MyChats,
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                          ],
                        ),
                        const SizedBox(height: 20),
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

                  // ✅ عرض الشاتات
                  BlocBuilder<ChatsCubit, ChatsState>(
                    builder: (context, state) {
                      if (state is ChatsLoading) {
                        return const SliverFillRemaining(
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      if (state is ChatsError) {
                        return SliverFillRemaining(
                          child: Center(child: Text('Error: ${state.message}')),
                        );
                      }

                      if (state is ChatsWithUsersLoaded) {
                        var chatsWithUsers = state.chatsWithUsers;

                        // 🔍 الفلترة حسب النص المكتوب
                        if (searchText.isNotEmpty) {
                          chatsWithUsers = chatsWithUsers.where((item) {
                            final friend =
                                item['friend'] as ChatUser?;
                            final name = friend?.name?.toLowerCase() ?? '';
                            return name.startsWith(searchText);
                          }).toList();
                        }

                        if (chatsWithUsers.isEmpty) {
                          return const SliverFillRemaining(
                            child: Center(child: Text("No chats yet 😅")),
                          );
                        }

                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final chat =
                                  chatsWithUsers[index]['chat'] as ChatModel;
                              final friend =
                                  chatsWithUsers[index]['friend'] as ChatUser;

                              return GestureDetector(
                                onTap: () {
                                  GoRouter.of(context).push(
                                    AppRouter.kChat,
                                    extra: friend,
                                  );
                                },
                                child: FriendChat(chat: chat, friend: friend),
                              );
                            },
                            childCount: chatsWithUsers.length,
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
    );
  }
}
