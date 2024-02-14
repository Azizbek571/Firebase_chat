// import 'package:chat_firebase_for_lesson/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasewithteacher/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final TextEditingController messageController =
      TextEditingController(); //textfield controlleri uchun

  Future<void> sendMessage(String receiverId) async {
    try {
      final String currentUserId = firebaseAuth.currentUser!.uid;

      final String currentUserEmail =
          firebaseAuth.currentUser!.email.toString();

      final Timestamp timestamp = Timestamp.now();

      MessageModel newMessage = MessageModel(
          message: messageController.text,
          receiverId: receiverId,
          senderEmail: currentUserEmail,
          senderId: currentUserId,
          timestamp: timestamp);

      List<String> ids = [currentUserId, receiverId];

      ids.sort();

      String chatRoomId = ids.join("_");

      await fireStore
          .collection('chat_rooms')
          .doc(chatRoomId)
          .collection('messages')
          .add(newMessage.toMap());
    } catch (err) {
      print(err);
    }
  }

  // messagelardi olish
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
