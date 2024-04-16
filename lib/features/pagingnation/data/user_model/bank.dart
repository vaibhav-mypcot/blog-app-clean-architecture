import 'dart:convert';

class Bank {
  String? cardExpire;
  String? cardNumber;
  String? cardType;
  String? currency;
  String? iban;

  Bank({
    this.cardExpire,
    this.cardNumber,
    this.cardType,
    this.currency,
    this.iban,
  });

  factory Bank.fromMap(Map<String, dynamic> data) => Bank(
        cardExpire: data['cardExpire'] as String?,
        cardNumber: data['cardNumber'] as String?,
        cardType: data['cardType'] as String?,
        currency: data['currency'] as String?,
        iban: data['iban'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'cardExpire': cardExpire,
        'cardNumber': cardNumber,
        'cardType': cardType,
        'currency': currency,
        'iban': iban,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Bank].
  factory Bank.fromJson(String data) {
    return Bank.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Bank] to a JSON string.
  String toJson() => json.encode(toMap());
}
