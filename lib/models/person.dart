import 'package:flutter/material.dart';

class Person {
  late String id;
  late String name;
  late String contact;
  late Color color;

  Person({
    required this.id,
    required this.name,
    required this.contact,
    required this.color,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['contact'] = this.contact;
    data['color'] = this.color.value;
    return data;
  }

  Person.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    name = json['name'] as String;
    contact = json['contact'] as String;
    color = Color(json['color'] as int);
  }
}
