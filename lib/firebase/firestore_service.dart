import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/models/FoodProduct.dart';
import 'package:shop_app/models/User.dart';

class FirestoreService {
  static Future<User> tryCreateNewUserDocument(String uid, String email) async {
    if ((await FirebaseFirestore.instance.doc("users/$uid").get()).exists) {
      return User.fromJson({"email": email, "id": uid});
    }
    await FirebaseFirestore.instance
        .doc("users/$uid")
        .set({"id": uid, "email": email});
    return User.fromJson({"email": email, "id": uid});
  }

  static void updateUserDocument(User user) async {
    print(user.firstName);
    await FirebaseFirestore.instance
        .doc("users/${user.id}")
        .update(user.toJson());
  }

  static Stream<User?> getUserDocumentSnap(String uid) {
    return FirebaseFirestore.instance
        .doc("users/$uid")
        .snapshots()
        .map((event) {
      var data = event.data();
      return data != null ? User.fromJson(data) : null;
    });
  }

  static Stream<List<FoodProduct>> getFoodProductSnap() {
    return FirebaseFirestore.instance.collection("products").snapshots().map(
          (event) =>
              event.docs.map((e) => FoodProduct.fromJson(e.data())).toList(),
        );
  }

  static timeStampsToDateTime(Map<String, dynamic> json) {
    const fieldNames = ["createdAt", "updatedAt"];
    for (var fieldName in fieldNames) {
      if (json[fieldName] != null) {
        json[fieldName] = (json[fieldName] as Timestamp).toDate();
      }
    }
  }
}
