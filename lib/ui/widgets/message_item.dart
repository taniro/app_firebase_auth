import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  final DocumentSnapshot document;
  final String currentUserId;

  const MessageItem(
      {super.key, required this.document, required this.currentUserId});

  @override
  Widget build(BuildContext context) {

    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var isSender = data['senderId'] == currentUserId;

    return BubbleSpecialThree(
      text: data['message'],
      isSender: isSender,
      color: Theme.of(context).colorScheme.tertiary,
      textStyle: TextStyle(
          color: Theme.of(context).colorScheme.onTertiary
      ),
    );
  }
}