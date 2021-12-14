import 'dart:convert';

class ErrorResponse {
  String status;
  String msg;
  ErrorResponse({
    required this.status,
    required this.msg,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'msg': msg,
    };
  }

  factory ErrorResponse.fromMap(Map<String, dynamic> map) {
    return ErrorResponse(
      status: map['status'] ?? '',
      msg: map['msg'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorResponse.fromJson(String source) =>
      ErrorResponse.fromMap(json.decode(source));

  @override
  String toString() => 'ErrorResponse(status: $status, msg: $msg)';
}
