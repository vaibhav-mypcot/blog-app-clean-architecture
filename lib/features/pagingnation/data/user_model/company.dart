import 'dart:convert';

import 'address.dart';

class Company {
  Address? address;
  String? department;
  String? name;
  String? title;

  Company({this.address, this.department, this.name, this.title});

  factory Company.fromMap(Map<String, dynamic> data) => Company(
        address: data['address'] == null
            ? null
            : Address.fromMap(data['address'] as Map<String, dynamic>),
        department: data['department'] as String?,
        name: data['name'] as String?,
        title: data['title'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'address': address?.toMap(),
        'department': department,
        'name': name,
        'title': title,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Company].
  factory Company.fromJson(String data) {
    return Company.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Company] to a JSON string.
  String toJson() => json.encode(toMap());
}
