class UserModel {
  final String uid;
  final String name;
  final String email;
  final String imageUrl;
  final String createdAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.createdAt,
  });

  // لتحويل JSON إلى كائن UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      createdAt: json['createdAt'] != null 
    ? json['createdAt'].toString() 
    : '',

    );
  }

  // لتحويل الكائن إلى JSON (Map) لتخزينه في Firestore
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'createdAt': createdAt,
    };
  }
}
