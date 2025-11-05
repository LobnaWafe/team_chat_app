import 'package:bloc/bloc.dart';
import 'package:chats_app/features/chat/data/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
 CollectionReference chatsRef = FirebaseFirestore.instance.collection("Chats");

 void addMessage({required String senderEmail,required String reciverEmail,
 required MessageModel message})async{

     // 🧩 1️⃣ تنظيف الإيميلات من الرموز غير الصالحة في Firestore ID
      String idChannel = generateIDs(senderEmail, reciverEmail);
 
 DocumentReference chatDoc = chatsRef.doc(idChannel);
await chatDoc.set({
 
        "members": [senderEmail, reciverEmail],
        "lastMessage": message.content,
        "lastMessageTime": message.createdAt,

       // "createdAt": FieldValue.serverTimestamp(),
 },SetOptions(merge: true));

await chatDoc.collection("messages").add({
        "senderEmail": senderEmail,
        "reciverEmail":reciverEmail,
        "text": message.content,
        "createdAt": message.createdAt,
        "messageType": message.type,
        "lat":message.lat,
        "lng":message.lng
      });
  
 }

void getMessages({
    required String senderEmail,
    required String reciverEmail,
  }) {
    String idChannel = generateIDs(senderEmail, reciverEmail);
    // print("ides : $idChannel");
    // print("here");
    chatsRef
        .doc(idChannel)
        .collection("messages")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .listen((event) {
      List<MessageModel> messages = [];
    //  print("eventt : ${event.docs}");
      for (var doc in event.docs) {
      //  print("doc : $doc");
        messages.add(MessageModel.fromJson(doc.data()));
      }

      emit(ChatSuccess(messages:messages));
    });
  }

 String generateIDs(String senderEmail, String reciverEmail) {
   
        // 🧩 1️⃣ تنظيف الإيميلات من الرموز غير الصالحة في Firestore ID
   String cleanSender = senderEmail.replaceAll(RegExp(r'[^\w]'), '_');
   String cleanReciver = reciverEmail.replaceAll(RegExp(r'[^\w]'), '_');
   
   // 🧩 2️⃣ إنشاء idChannel ثابت بغض النظر عن الترتيب
   String idChannel = cleanSender.compareTo(cleanReciver) > 0
       ? '${cleanReciver}_$cleanSender'
       : '${cleanSender}_$cleanReciver';
   return idChannel;
 }
}
