class LoginResponse {
  String? message;
  String? otp;
  String? expiresAt;

  LoginResponse({this.message, this.otp, this.expiresAt});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    // The outer message is usually generic like "Vendor OTP sent successfully"
    // The data object contains specific details
    
    // Check if 'data' exists and is a Map
    if (json['data'] != null && json['data'] is Map) {
      var data = json['data'];
      message = data['message']; // Inner message
      otp = data['otp']?.toString();
      expiresAt = data['expiresAt'];
    } else {
      // Fallback if structure is flat
      message = json['message'];
      otp = json['otp']?.toString();
    }
  }
}

class VerifyOtpResponse {
  String? accessToken;
  String? message;
  int? userId;

  VerifyOtpResponse({this.accessToken, this.message, this.userId});

  VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    
    if (json['data'] != null && json['data'] is Map) {
      var data = json['data'];
      accessToken = data['accessToken'];
      userId = data['id']; // Assuming ID might be returned
      // Also check for user object inside data if structure is deeply nested
      if (data['user'] != null && data['user'] is Map) {
         // potential user details parsing
      }
    } else {
      accessToken = json['accessToken'];
    }
  }
}
