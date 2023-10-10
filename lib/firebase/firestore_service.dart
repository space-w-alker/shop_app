import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static void createNewUserDocument(String uid, String email) async {
    await FirebaseFirestore.instance
        .doc("users/$uid")
        .set({"id": uid, "email": email});
  }
}
