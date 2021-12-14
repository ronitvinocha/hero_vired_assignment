import 'dart:convert';

class CreateUserResponse {
  int id;
  String username;
  CreateUserResponse({
    required this.id,
    required this.username,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
    };
  }

  factory CreateUserResponse.fromMap(Map<String, dynamic> map) {
    return CreateUserResponse(
      id: map['id']?.toInt() ?? 0,
      username: map['username'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateUserResponse.fromJson(String source) =>
      CreateUserResponse.fromMap(json.decode(source));

  @override
  String toString() => 'CreateUserResponse(id: $id, username: $username)';
}
