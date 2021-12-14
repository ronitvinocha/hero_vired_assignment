import 'dart:convert';

import 'package:hero_vired/bl/model/authmodel/usertoken.dart';

class UserTokenWrapper {
  String user_token;
  UserTokenWrapper({
    required this.user_token,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_token': user_token,
    };
  }

  factory UserTokenWrapper.fromMap(Map<String, dynamic> map) {
    return UserTokenWrapper(
      user_token: map['user_token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserTokenWrapper.fromJson(String source) =>
      UserTokenWrapper.fromMap(json.decode(source));

  @override
  String toString() => 'UserTokenWrapper(user_token: $user_token)';
}
