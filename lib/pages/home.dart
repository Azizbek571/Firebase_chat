import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasewithteacher/pages/chat_page.dart';
import 'package:firebasewithteacher/stores/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LoginController controller = Get.put(LoginController());
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('HomePage'),
      actions: [IconButton(onPressed: (){
        controller.logOut();
      }, icon: const Icon(Icons.logout))],
      ),
      body: userList());
  }

  Widget userList() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          return ListView(
            children:
                snapshot.data!.docs.map((doc) => userBuildItem(doc)).toList(),
          );
        });
  }

  Widget userBuildItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    if (auth.currentUser!.email != data['email']) {
      return ListTile(
        title: Text(data['email']),
        onTap: () {
          Get.to(() => ChatPage(
                recieverUserEmail: data['email'],
                recieverUserId: data['uid'],
              ));
        },
      );
    } else {
      return Container();
    }
  }
}