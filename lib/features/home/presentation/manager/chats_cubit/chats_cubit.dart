import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chats_app/features/home/data/models/chats_model.dart';
import 'package:chats_app/features/search_users/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit() : super(ChatsInitial());

  final _chatsCollection = FirebaseFirestore.instance.collection('Chats');
  final _usersCollection = FirebaseFirestore.instance.collection('users');
  StreamSubscription? _chatsSubscription; // ✅ أضف subscription

  // ✅ دالة للإستماع للتحديثات الفورية
  void listenToChatsWithFriends(String currentUserEmail) {
    emit(ChatsLoading());
    
    // ✅ ألغِ أي اشتراك سابق
    _chatsSubscription?.cancel();

    _chatsSubscription = _chatsCollection
        .where('members', arrayContains: currentUserEmail)
        .orderBy('lastMessageTime', descending: true)
        .snapshots() // ✅ استخدم snapshots() بدل get()
        .listen((snapshot) async {
      try {
        final chats = snapshot.docs.map((doc) => ChatModel.fromDoc(doc)).toList();

        final List<Map<String, dynamic>> chatsWithUsers = [];

        for (var chat in chats) {
          final friendEmail = chat.members.firstWhere(
            (email) => email != currentUserEmail,
            orElse: () => '',
          );

          if (friendEmail.isEmpty) continue;

          final friendSnapshot = await _usersCollection
              .where('email', isEqualTo: friendEmail)
              .limit(1)
              .get();

          if (friendSnapshot.docs.isNotEmpty) {
            final friend = ChatUser.fromDoc(friendSnapshot.docs.first);
            chatsWithUsers.add({
              'chat': chat,
              'friend': friend,
            });
          }
        }

        if (!isClosed) {
          emit(ChatsWithUsersLoaded(chatsWithUsers));
        }
      } catch (e) {
        if (!isClosed) {
          emit(ChatsError(e.toString()));
        }
      }
    });
  }

  // ✅ احتفظ بالدالة القديمة إذا كنت تحتاجها
  Future<void> getChatsWithFriends(String currentUserEmail) async {
    emit(ChatsLoading());
    try {
      final snapshot = await _chatsCollection
          .where('members', arrayContains: currentUserEmail)
          .orderBy('lastMessageTime', descending: true)
          .get();

      final chats = snapshot.docs.map((doc) => ChatModel.fromDoc(doc)).toList();

      final List<Map<String, dynamic>> chatsWithUsers = [];

      for (var chat in chats) {
        final friendEmail = chat.members.firstWhere(
          (email) => email != currentUserEmail,
          orElse: () => '',
        );

        if (friendEmail.isEmpty) continue;

        final friendSnapshot = await _usersCollection
            .where('email', isEqualTo: friendEmail)
            .limit(1)
            .get();

        if (friendSnapshot.docs.isNotEmpty) {
          final friend = ChatUser.fromDoc(friendSnapshot.docs.first);
          chatsWithUsers.add({
            'chat': chat,
            'friend': friend,
          });
        }
      }

      emit(ChatsWithUsersLoaded(chatsWithUsers));
    } catch (e) {
      emit(ChatsError(e.toString()));
    }
  }

  // ✅ أضف دالة close
  @override
  Future<void> close() {
    _chatsSubscription?.cancel();
    return super.close();
  }
}