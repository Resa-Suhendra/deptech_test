class AdminModel {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? birthDate;
  String? gender;
  String? profileImage;

  AdminModel({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.birthDate,
    this.gender,
    this.profileImage,
  });


  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? "",
      email: json['email'] ?? "",
      password: json['password'] ?? "",
      birthDate: json['birth_date'] ?? "",
      gender: json['gender'] ?? "",
      profileImage: json['profile_image'] ?? "",
    );
  }


  @override
  Map<String, dynamic> toJson() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "password": password,
      "birth_date": birthDate,
      "gender": gender,
      "profile_image": profileImage,
    };
  }
}
