import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/FoodCategory.dart';
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

  static Future addToFavorites(User user, String productId,
      {bool remove = false}) async {
    var doc =
        FirebaseFirestore.instance.doc("users/${user.id}/favorites/$productId");
    if (remove == true) {
      await doc.delete();
    } else {
      await doc.set(
        {"productId": productId, "createdAt": FieldValue.serverTimestamp()},
      );
    }
  }

  static Future removeFromFavorites(User user, String productId) async {
    await FirebaseFirestore.instance
        .doc("users/${user.id}/favorites/$productId")
        .delete();
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

  static Stream<List<String>> getFavoritesSnap(String uid) {
    return FirebaseFirestore.instance
        .collection("users/$uid/favorites")
        .snapshots()
        .map((event) =>
            event.docs.map((e) => e.data()["productId"] as String).toList());
  }

  static Stream<MenuItem> getOneProductSnap(String productId) {
    return FirebaseFirestore.instance
        .doc("products/$productId")
        .snapshots()
        .map((event) => MenuItem.fromMap(event.data() ?? {}));
  }

  static Stream<List<MenuItem>> getFoodProductSnap() {
    return FirebaseFirestore.instance.collection("products").snapshots().map(
          (event) => event.docs.map((e) => MenuItem.fromMap(e.data())).toList(),
        );
  }

  static Stream<List<FoodCategory>> getFoodCategorySnap() {
    return FirebaseFirestore.instance.collection("categories").snapshots().map(
          (event) =>
              event.docs.map((e) => FoodCategory.fromJson(e.data())).toList(),
        );
  }

  static Stream<List<Cart>> getUserCart(String userId) {
    return FirebaseFirestore.instance
        .collection("users/$userId/cart")
        .snapshots()
        .map(
          (event) => event.docs.map((e) => Cart.fromJson(e.data())).toList(),
        );
  }

  static Future addToCart(User user, String productId) async {
    return FirebaseFirestore.instance
        .doc("users/${user.id}/cart/${productId}")
        .set({"productId": productId, "numOfItems": FieldValue.increment(1)},
            SetOptions(merge: true));
  }

  static Future removeFromCart(User user, String productId) async {
    return FirebaseFirestore.instance
        .doc("users/${user.id}/cart/${productId}")
        .delete();
  }

  static Map<String, dynamic> addTimestamps(
    Map<String, dynamic> data, {
    bool newDoc = false,
  }) {
    data['updatedAt'] = FieldValue.serverTimestamp();
    if (newDoc) {
      data['createdAt'] = FieldValue.serverTimestamp();
    }
    return data;
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
