class ErrorResponse {
  int? status;
  String? message;
  Map<String, dynamic>? errors;

  ErrorResponse({required this.status, this.message, this.errors});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    data['errors'] = errors;
    return data;
  }
}