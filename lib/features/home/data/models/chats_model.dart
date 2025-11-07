import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String id;
  final String imageUrl;
  final List<String> members;
  final String lastMessage;
  final DateTime? lastMessageTime;

  ChatModel({
    required this.id,
    required this.members,
    required this.lastMessage,
    required this.imageUrl,
    this.lastMessageTime,
  });

  factory ChatModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return ChatModel(
      id: doc.id,
      members: List<String>.from(data['members'] ?? []),
      lastMessage: data['lastMessage'] ?? '',
      imageUrl: data['imageUrl'] ?? 'assets/images/profile.png', // 🟢 fallback
      lastMessageTime: (data['lastMessageTime'] as Timestamp?)?.toDate(),
    );
  }
}
