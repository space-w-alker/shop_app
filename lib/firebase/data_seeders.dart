import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/firebase/firestore_service.dart';

void seedAll() async {
  await seedMenuItems();
}

Future<void> seedMenuItems() async {
  var p = await FirebaseFirestore.instance.collection("products").count().get();
  if (p.count < 1) {
    log("Seeding products...");
    for (var i = 0; i < menuItems.length; i++) {
      var docData = menuItems[i];
      var doc = await FirebaseFirestore.instance
          .collection("products")
          .add(FirestoreService.addTimestamps(docData, newDoc: true));
      await doc.update({"id": doc.id});
    }
  }
}

var menuItems = [
  {
    "@type": "MenuItem",
    "name": "Spaghetti Bolognese",
    "image": ["https://picsum.photos/200/300"],
    "description": "Delicious pasta with meat sauce",
    "offers": {"@type": "Offer", "price": 12.99, "priceCurrency": "USD"},
    "preparationTime": 20,
    "rating": 2.1,
    "nutrition": {
      "@type": "NutritionInformation",
      "servingSize": "1 plate",
      "calories": 550,
      "carbohydrateContent": 45,
      "proteinContent": 20,
      "fatContent": 12
    }
  },
  {
    "@type": "MenuItem",
    "name": "Grilled Salmon",
    "image": ["https://picsum.photos/200/300"],
    "description": "Freshly grilled salmon fillet with lemon butter sauce",
    "offers": {"@type": "Offer", "price": 16.99, "priceCurrency": "USD"},
    "preparationTime": 45,
    "rating": 4.1,
    "nutrition": {
      "@type": "NutritionInformation",
      "servingSize": "1 piece",
      "calories": 350,
      "carbohydrateContent": 10,
      "proteinContent": 28,
      "fatContent": 20
    }
  },
  {
    "@type": "MenuItem",
    "name": "Caesar Salad",
    "image": ["https://picsum.photos/200/300"],
    "description": "Fresh romaine lettuce, croutons, and Caesar dressing",
    "offers": {"@type": "Offer", "price": 8.99, "priceCurrency": "USD"},
    "preparationTime": 10,
    "rating": 4.9,
    "nutrition": {
      "@type": "NutritionInformation",
      "servingSize": "1 bowl",
      "calories": 250,
      "carbohydrateContent": 15,
      "proteinContent": 8,
      "fatContent": 18
    }
  }
];
