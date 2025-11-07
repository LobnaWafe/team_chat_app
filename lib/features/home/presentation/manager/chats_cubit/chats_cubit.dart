import 'package:bloc/bloc.dart';
import 'package:chats_app/features/home/data/models/chats_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
 // ✅ استيراد الموديل

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit() : super(ChatsInitial());

  final _chatsCollection = FirebaseFirestore.instance.collection('Chats');

  Future<void> getChats(String currentUserEmail) async {
    emit(ChatsLoading());
    try {
      final snapshot = await _chatsCollection
          .where('members', arrayContains: currentUserEmail)
          .orderBy('lastMessageTime', descending: true)
          .get();

      // 🟢 نحول كل Document إلى ChatModel
      final chats = snapshot.docs.map((doc) => ChatModel.fromDoc(doc)).toList();

      emit(ChatsLoaded(chats));
    } catch (e) {
      emit(ChatsError(e.toString()));
    }
  }
}
