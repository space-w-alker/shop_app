import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String id;
  String email;
  String? firstName;
  String? lastName;
  String? fullName;
  String? phoneNumber;
  String? address;
  bool? onBoarded;

  User({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.fullName,
    this.phoneNumber,
    this.address,
    this.onBoarded,
  });

  User copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? fullName,
    String? phoneNumber,
    String? address,
    bool? onBoarded,
  }) =>
      User(
          id: id ?? this.id,
          email: email ?? this.email,
          firstName: firstName ?? this.firstName,
          lastName: lastName ?? this.lastName,
          fullName: fullName ?? this.fullName,
          phoneNumber: phoneNumber ?? this.phoneNumber,
          address: address ?? this.address,
          onBoarded: onBoarded ?? this.onBoarded);

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] ?? '',
        email: json["email"] ?? '',
        firstName: json["firstName"],
        lastName: json["lastName"],
        fullName: json["fullName"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        onBoarded: json["onBoarded"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "address": address,
        "onBoarded": onBoarded,
      };
}
