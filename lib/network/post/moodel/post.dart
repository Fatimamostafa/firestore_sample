import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? id;
  String? postId;
  String? ownerId;
  String? username;
  String? description;
  Timestamp? timestamp;

  PostModel({
    required this.id,
    required this.postId,
    required this.ownerId,
    required this.description,
    required this.username,
    required this.timestamp,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['postId'];
    ownerId = json['ownerId'];
    username = json['username'];
    description = json['description'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['postId'] = postId;
    data['ownerId'] = ownerId;
    data['description'] = description;
    data['timestamp'] = timestamp;
    data['username'] = username;
    return data;
  }
}
