import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DataBaseMethod {
  Future addUserDetails(Map<String, dynamic> userInfoMap, String Id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(Id)
        .set(userInfoMap);
  }

  Future<QuerySnapshot> getUserByMail(String mail) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("Email", isEqualTo: mail)
        .get();
  }

  createChatRoom(
      String chatroomid, Map<String, dynamic> chatRoomInfoMap) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("ChatRooms")
        .doc(chatroomid)
        .get();
    if (snapshot.exists) {
      return true;
    } else {
      return FirebaseFirestore.instance
          .collection("ChatRooms")
          .doc(chatroomid)
          .set(chatRoomInfoMap);
    }
  }

  Future addMessageFIrebase(String chatroomid, String messageId,
      Map<String, dynamic> messageInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("ChatRooms")
        .doc(chatroomid)
        .collection("chats")
        .doc(messageId)
        .set(messageInfoMap);
  }

  Future LastMessageFIrebase(
      String chatroomid, Map<String, dynamic> lastmessageInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("ChatRooms")
        .doc(chatroomid)
        .update(lastmessageInfoMap);
  }
}
