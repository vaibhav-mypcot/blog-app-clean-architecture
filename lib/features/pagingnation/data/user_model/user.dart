import 'dart:convert';

import 'address.dart';
import 'bank.dart';
import 'company.dart';
import 'crypto.dart';
import 'hair.dart';

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? maidenName;
  int? age;
  String? gender;
  String? email;
  String? phone;
  String? username;
  String? password;
  String? birthDate;
  String? image;
  String? bloodGroup;
  int? height;
  double? weight;
  String? eyeColor;
  Hair? hair;
  String? domain;
  String? ip;
  Address? address;
  String? macAddress;
  String? university;
  Bank? bank;
  Company? company;
  String? ein;
  String? ssn;
  String? userAgent;
  Crypto? crypto;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.maidenName,
    this.age,
    this.gender,
    this.email,
    this.phone,
    this.username,
    this.password,
    this.birthDate,
    this.image,
    this.bloodGroup,
    this.height,
    this.weight,
    this.eyeColor,
    this.hair,
    this.domain,
    this.ip,
    this.address,
    this.macAddress,
    this.university,
    this.bank,
    this.company,
    this.ein,
    this.ssn,
    this.userAgent,
    this.crypto,
  });

  factory User.fromMap(Map<String, dynamic> data) => User(
        id: data['id'] as int?,
        firstName: data['firstName'] as String?,
        lastName: data['lastName'] as String?,
        maidenName: data['maidenName'] as String?,
        age: data['age'] as int?,
        gender: data['gender'] as String?,
        email: data['email'] as String?,
        phone: data['phone'] as String?,
        username: data['username'] as String?,
        password: data['password'] as String?,
        birthDate: data['birthDate'] as String?,
        image: data['image'] as String?,
        bloodGroup: data['bloodGroup'] as String?,
        height: data['height'] as int?,
        weight: (data['weight'] as num?)?.toDouble(),
        eyeColor: data['eyeColor'] as String?,
        hair: data['hair'] == null
            ? null
            : Hair.fromMap(data['hair'] as Map<String, dynamic>),
        domain: data['domain'] as String?,
        ip: data['ip'] as String?,
        address: data['address'] == null
            ? null
            : Address.fromMap(data['address'] as Map<String, dynamic>),
        macAddress: data['macAddress'] as String?,
        university: data['university'] as String?,
        bank: data['bank'] == null
            ? null
            : Bank.fromMap(data['bank'] as Map<String, dynamic>),
        company: data['company'] == null
            ? null
            : Company.fromMap(data['company'] as Map<String, dynamic>),
        ein: data['ein'] as String?,
        ssn: data['ssn'] as String?,
        userAgent: data['userAgent'] as String?,
        crypto: data['crypto'] == null
            ? null
            : Crypto.fromMap(data['crypto'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'maidenName': maidenName,
        'age': age,
        'gender': gender,
        'email': email,
        'phone': phone,
        'username': username,
        'password': password,
        'birthDate': birthDate,
        'image': image,
        'bloodGroup': bloodGroup,
        'height': height,
        'weight': weight,
        'eyeColor': eyeColor,
        'hair': hair?.toMap(),
        'domain': domain,
        'ip': ip,
        'address': address?.toMap(),
        'macAddress': macAddress,
        'university': university,
        'bank': bank?.toMap(),
        'company': company?.toMap(),
        'ein': ein,
        'ssn': ssn,
        'userAgent': userAgent,
        'crypto': crypto?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [User].
  factory User.fromJson(String data) {
    return User.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [User] to a JSON string.
  String toJson() => json.encode(toMap());
}
