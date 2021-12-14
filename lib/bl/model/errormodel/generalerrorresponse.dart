import 'dart:convert';

class GeneralError {
  String exception;
  String errorcode;
  String message;
  GeneralError({
    required this.exception,
    required this.errorcode,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'exception': exception,
      'errorcode': errorcode,
      'message': message,
    };
  }

  factory GeneralError.fromMap(Map<String, dynamic> map) {
    return GeneralError(
      exception: map['exception'] ?? '',
      errorcode: map['errorcode'] ?? '',
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory GeneralError.fromJson(String source) =>
      GeneralError.fromMap(json.decode(source));

  @override
  String toString() =>
      'GeneralError(exception: $exception, errorcode: $errorcode, message: $message)';
}
