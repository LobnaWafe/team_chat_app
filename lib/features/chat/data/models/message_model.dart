import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String id;
  final String from;
  final String to;
  final String content;
  final DateTime createdAt;
  final String type; // "text" أو "location"
  final double? lat;
  final double? lng;

  MessageModel({
    required this.id,
    required this.from,
    required this.to,
    required this.content,
    required this.createdAt,
    this.type = "text",
    this.lat,
    this.lng,
  });

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'from': from,
  //     'to': to,
  //     'content': content,
  //     'createdAt': createdAt,
  //     'type': type,
  //     'lat': lat,
  //     'lng': lng,
  //   };
  // }
  
factory MessageModel.fromJson(Map<String, dynamic> json) {
  final createdAt = json['createdAt'];
  return MessageModel(
    id: json['id'] ?? "",
    from: json['senderEmail'] ?? "",
    to: json['reciverEmail'] ?? "",
    content: json['text'] ?? "",
    createdAt: createdAt is Timestamp ? createdAt.toDate() : DateTime.now(),
    type: json['messageType'] ?? "text",
    lat: json['lat']?.toDouble(),
    lng: json['lng']?.toDouble(),
  );
}

}
