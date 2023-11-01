// To parse this JSON data, do
//
//     final menuItem = menuItemFromMap(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

MenuItem menuItemFromMap(String str) => MenuItem.fromMap(json.decode(str));

String menuItemToMap(MenuItem data) => json.encode(data.toMap());

class MenuItem {
  String? type;
  String? id;
  String? name;
  String? description;
  List<String> image;
  double? rating;
  String? categoryId;
  int? preparationTime;
  Offers? offers;
  Nutrition? nutrition;
  bool? deleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? uiTag;

  MenuItem({
    this.type,
    this.id,
    this.name,
    this.description,
    this.image = const [],
    this.rating,
    this.categoryId,
    this.preparationTime,
    this.offers,
    this.nutrition,
    this.deleted,
    this.createdAt,
    this.updatedAt,
    this.uiTag,
  });

  MenuItem copyWith({
    String? type,
    String? id,
    String? name,
    String? description,
    List<String>? image,
    double? rating,
    String? categoryId,
    int? preparationTime,
    Offers? offers,
    Nutrition? nutrition,
    bool? deleted,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? uiTag,
  }) =>
      MenuItem(
        type: type ?? this.type,
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        image: image ?? this.image,
        rating: rating ?? this.rating,
        categoryId: categoryId ?? this.categoryId,
        preparationTime: preparationTime ?? this.preparationTime,
        offers: offers ?? this.offers,
        nutrition: nutrition ?? this.nutrition,
        deleted: deleted ?? this.deleted,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        uiTag: uiTag ?? this.uiTag,
      );

  factory MenuItem.fromMap(Map<String, dynamic> json) => MenuItem(
        type: json["@type"],
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"] == null
            ? []
            : List<String>.from(json["image"]!.map((x) => x)),
        rating: json["rating"],
        categoryId: json["categoryId"],
        preparationTime: json["preparationTime"],
        offers: json["offers"] == null ? null : Offers.fromMap(json["offers"]),
        nutrition: json["nutrition"] == null
            ? null
            : Nutrition.fromMap(json["nutrition"]),
        deleted: json["deleted"],
        createdAt: json["createdAt"] == null
            ? null
            : (json["createdAt"] as Timestamp).toDate(),
        updatedAt: json["updatedAt"] == null
            ? null
            : (json["updatedAt"] as Timestamp).toDate(),
      );

  Map<String, dynamic> toMap() => {
        "@type": type,
        "id": id,
        "name": name,
        "description": description,
        "image": image == null ? [] : List<dynamic>.from(image!.map((x) => x)),
        "rating": rating,
        "categoryId": categoryId,
        "preparationTime": preparationTime,
        "offers": offers?.toMap(),
        "nutrition": nutrition?.toMap(),
        "deleted": deleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Nutrition {
  String? type;
  String? servingSize;
  int? calories;
  int? carbohydrateContent;
  int? proteinContent;
  int? fatContent;

  Nutrition({
    this.type,
    this.servingSize,
    this.calories,
    this.carbohydrateContent,
    this.proteinContent,
    this.fatContent,
  });

  Nutrition copyWith({
    String? type,
    String? servingSize,
    int? calories,
    int? carbohydrateContent,
    int? proteinContent,
    int? fatContent,
  }) =>
      Nutrition(
        type: type ?? this.type,
        servingSize: servingSize ?? this.servingSize,
        calories: calories ?? this.calories,
        carbohydrateContent: carbohydrateContent ?? this.carbohydrateContent,
        proteinContent: proteinContent ?? this.proteinContent,
        fatContent: fatContent ?? this.fatContent,
      );

  factory Nutrition.fromMap(Map<String, dynamic> json) => Nutrition(
        type: json["@type"],
        servingSize: json["servingSize"],
        calories: json["calories"],
        carbohydrateContent: json["carbohydrateContent"],
        proteinContent: json["proteinContent"],
        fatContent: json["fatContent"],
      );

  Map<String, dynamic> toMap() => {
        "@type": type,
        "servingSize": servingSize,
        "calories": calories,
        "carbohydrateContent": carbohydrateContent,
        "proteinContent": proteinContent,
        "fatContent": fatContent,
      };
}

class Offers {
  String? type;
  double? price;
  String? priceCurrency;

  Offers({
    this.type,
    this.price,
    this.priceCurrency,
  });

  Offers copyWith({
    String? type,
    double? price,
    String? priceCurrency,
  }) =>
      Offers(
        type: type ?? this.type,
        price: price ?? this.price,
        priceCurrency: priceCurrency ?? this.priceCurrency,
      );

  factory Offers.fromMap(Map<String, dynamic> json) => Offers(
        type: json["@type"],
        price: json["price"]?.toDouble(),
        priceCurrency: json["priceCurrency"],
      );

  Map<String, dynamic> toMap() => {
        "@type": type,
        "price": price,
        "priceCurrency": priceCurrency,
      };
}
