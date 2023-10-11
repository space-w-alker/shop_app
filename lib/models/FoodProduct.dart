// To parse this JSON data, do
//
//     final foodProduct = foodProductFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

FoodProduct foodProductFromJson(String str) =>
    FoodProduct.fromJson(json.decode(str));

String foodProductToJson(FoodProduct data) => json.encode(data.toJson());

class FoodProduct {
  String? id;
  String? name;
  String? description;
  List<String> images;
  int? price;
  double? rating;
  String? categoryId;
  bool? deleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  FoodProduct({
    this.id,
    this.name,
    this.description,
    this.images = const [],
    this.price,
    this.rating,
    this.categoryId,
    this.deleted,
    this.createdAt,
    this.updatedAt,
  });

  FoodProduct copyWith({
    String? id,
    String? name,
    String? description,
    List<String>? images,
    int? price,
    double? rating,
    String? categoryId,
    bool? deleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      FoodProduct(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        images: images ?? this.images,
        price: price ?? this.price,
        rating: rating ?? this.rating,
        categoryId: categoryId ?? this.categoryId,
        deleted: deleted ?? this.deleted,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory FoodProduct.fromJson(Map<String, dynamic> json) => FoodProduct(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        price: json["price"],
        rating: json["rating"],
        categoryId: json["categoryId"],
        deleted: json["deleted"],
        createdAt: json["createdAt"] == null
            ? null
            : (json["createdAt"] as Timestamp).toDate(),
        updatedAt: json["updatedAt"] == null
            ? null
            : (json["updatedAt"] as Timestamp).toDate(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "price": price,
        "rating": rating,
        "categoryId": categoryId,
        "deleted": deleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

var gen = {
  "id": "",
  "name": "",
  "description": "",
  "images": [""],
  "price": 0,
  "rating": 0.0,
  "categoryId": "",
  "deleted": false,
  "createdAt": "2023-10-11T13:57:48Z",
  "updatedAt": "2023-10-11T13:57:48Z"
};
