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
}
