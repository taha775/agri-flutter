class UserModel {
  final String email;
  final String password;
  final name;
  final role;
  UserModel(
      {required this.email, required this.password, this.name, this.role});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(email: json["email"], password: json["password"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
    };
  }
}
