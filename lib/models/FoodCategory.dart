import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

FoodCategory foodCategoryFromJson(String str) =>
    FoodCategory.fromJson(json.decode(str));

String foodCategoryToJson(FoodCategory data) => json.encode(data.toJson());

class FoodCategory {
  String? id;
  String? name;
  String? description;
  String? image;
  int? itemsCount;
  bool? deleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  FoodCategory({
    this.id,
    this.name,
    this.description,
    this.image,
    this.itemsCount,
    this.deleted,
    this.createdAt,
    this.updatedAt,
  });

  FoodCategory copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    int? itemsCount,
    bool? deleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      FoodCategory(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        image: image ?? this.image,
        itemsCount: itemsCount ?? this.itemsCount,
        deleted: deleted ?? this.deleted,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory FoodCategory.fromJson(Map<String, dynamic> json) => FoodCategory(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        itemsCount: json["itemsCount"],
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
        "image": image,
        "itemsCount": itemsCount,
        "deleted": deleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
