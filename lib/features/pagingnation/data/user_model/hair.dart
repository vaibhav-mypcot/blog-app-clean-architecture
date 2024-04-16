import 'dart:convert';

class Hair {
  String? color;
  String? type;

  Hair({this.color, this.type});

  factory Hair.fromMap(Map<String, dynamic> data) => Hair(
        color: data['color'] as String?,
        type: data['type'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'color': color,
        'type': type,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Hair].
  factory Hair.fromJson(String data) {
    return Hair.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Hair] to a JSON string.
  String toJson() => json.encode(toMap());
}
