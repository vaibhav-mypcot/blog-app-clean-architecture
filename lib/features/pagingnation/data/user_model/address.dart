import 'dart:convert';

import 'coordinates.dart';

class Address {
  String? address;
  String? city;
  Coordinates? coordinates;
  String? postalCode;
  String? state;

  Address({
    this.address,
    this.city,
    this.coordinates,
    this.postalCode,
    this.state,
  });

  factory Address.fromMap(Map<String, dynamic> data) => Address(
        address: data['address'] as String?,
        city: data['city'] as String?,
        coordinates: data['coordinates'] == null
            ? null
            : Coordinates.fromMap(data['coordinates'] as Map<String, dynamic>),
        postalCode: data['postalCode'] as String?,
        state: data['state'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'address': address,
        'city': city,
        'coordinates': coordinates?.toMap(),
        'postalCode': postalCode,
        'state': state,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Address].
  factory Address.fromJson(String data) {
    return Address.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Address] to a JSON string.
  String toJson() => json.encode(toMap());
}
