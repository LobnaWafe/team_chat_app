import 'package:cloud_firestore/cloud_firestore.dart';

class ChatUser {
  final String uid;
  final String name;
  final String email;
  final String imageUrl;
  final DateTime? createdAt;

  ChatUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.imageUrl,
    this.createdAt,
  });

  factory ChatUser.fromMap(Map<String, dynamic> map) {
    final ts = map['createdAt'];
    DateTime? created;
    if (ts is Timestamp) {
      created = ts.toDate();
    } else if (ts is DateTime) {
      created = ts;
    }
    return ChatUser(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      createdAt: created,
    );
  }

  factory ChatUser.fromDoc(DocumentSnapshot doc) =>
      ChatUser.fromMap(doc.data() as Map<String, dynamic>);
}
