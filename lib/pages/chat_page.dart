import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasewithteacher/components/input.dart';
import 'package:firebasewithteacher/stores/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatefulWidget {
  const ChatPage(
      {super.key,
      required this.recieverUserEmail,
      required this.recieverUserId});

  final String recieverUserEmail;
  final String recieverUserId;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
   ChatController controller = Get.put(ChatController());

   sendMessage() async {
    if (controller.messageController.text.trim().isNotEmpty) {
      controller.sendMessage(widget.recieverUserId);
    }
    controller.messageController.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.recieverUserEmail)),
      body: Column(
        children: [Expanded(child: buildMessageList()), buildMessageInput()],
      ),
    );
  }

  Widget buildMessageInput() {
    return Row(
      children: [
        Expanded(
            child: Input(
                controller: controller.messageController,
                hintText: "Yozish",
                obscureText: false)),
        IconButton(
            onPressed: () {
              sendMessage();
            },
            icon: const Icon(Icons.send))
      ],
    );
  }

  Widget buildMessageList() {
    return StreamBuilder(
        stream: controller.getMessages(
            widget.recieverUserId, controller.firebaseAuth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error:${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loding....");
          }
          return ListView(
            children: snapshot.data!.docs
                .map((document) => buildMessageItem(document))
                .toList(),
          );
        });
  }

  Widget buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var aligment =
        (data['senderId'] == controller.firebaseAuth.currentUser!.uid)
            ? Alignment.centerRight
            : Alignment.centerLeft;
    return Container(
      alignment: aligment,
      child: Column(
        children: [
          Text(data['senderEmail']),
          Text(data['message']),
        ],
      ),
    );
  }
}