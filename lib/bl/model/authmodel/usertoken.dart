import 'dart:convert';

class UserToken {
  String token;
  String privatetoken;
  UserToken({
    required this.token,
    required this.privatetoken,
  });

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'privatetoken': privatetoken,
    };
  }

  factory UserToken.fromMap(Map<String, dynamic> map) {
    return UserToken(
      token: map['token'] ?? '',
      privatetoken: map['privatetoken'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserToken.fromJson(String source) =>
      UserToken.fromMap(json.decode(source));

  @override
  String toString() => 'UserToken(token: $token, privatetoken: $privatetoken)';
}
