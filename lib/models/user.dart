import 'package:flutter/material.dart';

class User {
  final Color color;
  final String userName;
  final String id;

  User(this.id, this.color, this.userName);

  factory User.fromJson(Map<String, dynamic> json) {
    final colorValue = json['color'];
    final color = Color(colorValue);
    return User(json['id'], color, json['userName']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userName": userName,
      "color": color.value,
    };
  }
}
