import 'dart:convert';

class Crypto {
  String? coin;
  String? wallet;
  String? network;

  Crypto({this.coin, this.wallet, this.network});

  factory Crypto.fromMap(Map<String, dynamic> data) => Crypto(
        coin: data['coin'] as String?,
        wallet: data['wallet'] as String?,
        network: data['network'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'coin': coin,
        'wallet': wallet,
        'network': network,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Crypto].
  factory Crypto.fromJson(String data) {
    return Crypto.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Crypto] to a JSON string.
  String toJson() => json.encode(toMap());
}
