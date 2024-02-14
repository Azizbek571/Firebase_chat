import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotifications() async {
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    final fCMToken = await firebaseMessaging.getToken();
    print('Token:------    $fCMToken');
  }
}