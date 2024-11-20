import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  final String senderId;
  final String senderEmail;
  final String? message;
  final String? imageUrl;
  final Timestamp timestamp;

  Message({required this.senderId, required this.senderEmail, this.message, this.imageUrl, required this.timestamp});

  Map<String, dynamic> toMap(){
    return {
      'senderId':senderId,
      'senderEmail':senderEmail,
      'message':message,
      'imageUrl':imageUrl,
      'timestamp':timestamp
    };
  }
}