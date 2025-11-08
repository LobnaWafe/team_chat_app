import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chats_app/features/chat/data/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  
  CollectionReference chatsRef = FirebaseFirestore.instance.collection("Chats");
  StreamSubscription? _messagesSubscription; // ✅ أضف هذا

  void addMessage({
    required String senderEmail,
    required String reciverEmail,
    required MessageModel message
  }) async {
    try {
      String idChannel = generateIDs(senderEmail, reciverEmail);
      DocumentReference chatDoc = chatsRef.doc(idChannel);
      
      await chatDoc.set({
        "members": [senderEmail, reciverEmail],
        "lastMessage": message.content,
        "lastMessageTime": message.createdAt,
      }, SetOptions(merge: true));

      await chatDoc.collection("messages").add({
        "senderEmail": senderEmail,
        "reciverEmail": reciverEmail,
        "text": message.content,
        "createdAt": message.createdAt,
        "messageType": message.type,
        "lat": message.lat,
        "lng": message.lng
      });
    } catch (e) {
      if (!isClosed) emit(ChatError(errorMsg: e.toString()));
    }
  }

  void getMessages({
    required String senderEmail,
    required String reciverEmail,
  }) {
    // ✅ ألغِ أي اشتراك سابق أولاً
    _messagesSubscription?.cancel();
    
    String idChannel = generateIDs(senderEmail, reciverEmail);
    
    _messagesSubscription = chatsRef
        .doc(idChannel)
        .collection("messages")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .listen((event) {
      List<MessageModel> messages = [];
      for (var doc in event.docs) {
        messages.add(MessageModel.fromJson(doc.data()));
      }

      // ✅ تحقق من أن الـ Cubit لم يُغلق قبل emit
      if (!isClosed) {
        emit(ChatSuccess(messages: messages));
      }
    }, onError: (error) {
      // ✅ تحقق من أن الـ Cubit لم يُغلق قبل emit
      if (!isClosed) {
        emit(ChatError(errorMsg: error.toString()));
      }
    });
  }

  String generateIDs(String senderEmail, String reciverEmail) {
    String cleanSender = senderEmail.replaceAll(RegExp(r'[^\w]'), '_');
    String cleanReciver = reciverEmail.replaceAll(RegExp(r'[^\w]'), '_');
   
    String idChannel = cleanSender.compareTo(cleanReciver) > 0
        ? '${cleanReciver}_$cleanSender'
        : '${cleanSender}_$cleanReciver';
    return idChannel;
  }

  // ✅ أهم جزء: أضف دالة close لإلغاء الاشتراك
  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}