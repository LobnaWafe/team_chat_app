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

  Future<void> getChatsWithFriends(String currentUserEmail) async {
    emit(ChatsLoading());
    try {
      // 🔹 الخطوة 1: جيبي الشاتات الخاصة بالمستخدم الحالي
      final snapshot = await _chatsCollection
          .where('members', arrayContains: currentUserEmail)
          .orderBy('lastMessageTime', descending: true)
          .get();

      final chats = snapshot.docs.map((doc) => ChatModel.fromDoc(doc)).toList();

      // 🔹 الخطوة 2: جيبي بيانات الطرف التاني لكل شات
      final List<Map<String, dynamic>> chatsWithUsers = [];

      for (var chat in chats) {
        // هات الإيميل بتاع الشخص التاني
        final friendEmail = chat.members.firstWhere(
          (email) => email != currentUserEmail,
          orElse: () => '',
        );

        if (friendEmail.isEmpty) continue;

        // هات بياناته من users
        final friendSnapshot = await _usersCollection
            .where('email', isEqualTo: friendEmail)
            .limit(1)
            .get();

        if (friendSnapshot.docs.isNotEmpty) {
          final friend = ChatUser.fromDoc(friendSnapshot.docs.first);

          // دمجي بيانات الشات + المستخدم
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
}
