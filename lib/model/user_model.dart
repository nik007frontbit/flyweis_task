class UserModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNo;
  String? profileImage;
  String? role;
  bool? isEmailVerified;
  bool? isPhoneVerified;
  int? planId;

  UserModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNo,
      this.profileImage,
      this.role,
      this.isEmailVerified,
      this.isPhoneVerified,
      this.planId});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNo = json['phoneNo'];
    profileImage = json['profileImage'];
    role = json['role'];
    isEmailVerified = json['isEmailVerified'];
    isPhoneVerified = json['isPhoneVerified'];
    planId = json['planId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['phoneNo'] = this.phoneNo;
    data['profileImage'] = this.profileImage;
    data['role'] = this.role;
    data['isEmailVerified'] = this.isEmailVerified;
    data['isPhoneVerified'] = this.isPhoneVerified;
    data['planId'] = this.planId;
    return data;
  }
}
