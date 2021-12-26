import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? username;
  String? email;
  String? id;
  Timestamp? signedUpAt;

  UserModel({
    required this.username,
    required this.email,
    required this.id,
    required this.signedUpAt,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    signedUpAt = json['signedUpAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['signedUpAt'] = signedUpAt;
    data['id'] = id;

    return data;
  }
}
