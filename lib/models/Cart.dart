// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'dart:convert';

Cart cartFromJson(String str) => Cart.fromJson(json.decode(str));

String cartToJson(Cart data) => json.encode(data.toJson());

class Cart {
  String? id;
  String? productId;
  int? numOfItems;

  Cart({
    this.id,
    this.productId,
    this.numOfItems,
  });

  Cart copyWith({
    String? id,
    String? productId,
    int? numOfItems,
  }) =>
      Cart(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        numOfItems: numOfItems ?? this.numOfItems,
      );

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        productId: json["productId"],
        numOfItems: json["numOfItems"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "numOfItems": numOfItems,
      };
}
