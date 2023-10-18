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
    "nutrition": {
      "@type": "NutritionInformation",
      "servingSize": "1 plate",
      "calories": "550 calories",
      "carbohydrateContent": "45 grams",
      "proteinContent": "20 grams",
      "fatContent": "12 grams"
    }
  },
  {
    "@type": "MenuItem",
    "name": "Grilled Salmon",
    "image": ["https://picsum.photos/200/300"],
    "description": "Freshly grilled salmon fillet with lemon butter sauce",
    "offers": {"@type": "Offer", "price": 16.99, "priceCurrency": "USD"},
    "nutrition": {
      "@type": "NutritionInformation",
      "servingSize": "1 piece",
      "calories": "350 calories",
      "carbohydrateContent": "10 grams",
      "proteinContent": "28 grams",
      "fatContent": "20 grams"
    }
  },
  {
    "@type": "MenuItem",
    "name": "Caesar Salad",
    "image": ["https://picsum.photos/200/300"],
    "description": "Fresh romaine lettuce, croutons, and Caesar dressing",
    "offers": {"@type": "Offer", "price": 8.99, "priceCurrency": "USD"},
    "nutrition": {
      "@type": "NutritionInformation",
      "servingSize": "1 bowl",
      "calories": "250 calories",
      "carbohydrateContent": "15 grams",
      "proteinContent": "8 grams",
      "fatContent": "18 grams"
    }
  }
];
