import 'dart:convert';

class NewUserResponse {
  String leadid;
  String admin_token;
  String status;
  String usertype;
  NewUserResponse({
    required this.leadid,
    required this.admin_token,
    required this.status,
    required this.usertype,
  });

  Map<String, dynamic> toMap() {
    return {
      'leadid': leadid,
      'admin_token': admin_token,
      'status': status,
      'usertype': usertype,
    };
  }

  factory NewUserResponse.fromMap(Map<String, dynamic> map) {
    return NewUserResponse(
      leadid: map['leadid'] ?? '',
      admin_token: map['admin_token'] ?? '',
      status: map['status'] ?? '',
      usertype: map['usertype'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NewUserResponse.fromJson(String source) =>
      NewUserResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NewUserResponse(leadid: $leadid, admin_token: $admin_token, status: $status, usertype: $usertype)';
  }
}
