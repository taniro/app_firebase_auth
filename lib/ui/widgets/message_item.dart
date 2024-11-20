import 'package:app_firebase_auth/services/firebase/firebase_storage_service.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/bubbles/bubble_normal_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageItem extends StatelessWidget {
  final DocumentSnapshot document;
  final String currentUserId;

  const MessageItem(
      {super.key, required this.document, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    FirebaseStorageService firebaseStorageService =
        Provider.of<FirebaseStorageService>(context, listen: false);
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var isSender = data['senderId'] == currentUserId;

    if (data['message'] != null) {
      return BubbleSpecialThree(
        text: data['message'],
        isSender: isSender,
        color: Theme.of(context).colorScheme.tertiary,
        textStyle: TextStyle(color: Theme.of(context).colorScheme.onTertiary),
      );
    } else {
      return FutureBuilder(
          future: firebaseStorageService.downloadFile(data['imageUrl']),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting){
              return CircularProgressIndicator();
            }
            if (snapshot.hasError && !snapshot.hasData){
              return Text ("Error");
            }
            return BubbleNormalImage(
              isSender: isSender,
              color: Theme.of(context).colorScheme.tertiary,
              id: snapshot.data.toString(),
              image: Image(
                image: NetworkImage(snapshot.data.toString()),
              ),
            );
          });
    }
  }
}
