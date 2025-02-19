class ShopModel {
  final name;
  final String shop_code;
  final String password;
  final email;

  ShopModel({
    this.name,
    required this.shop_code,
    required this.password,
    this.email,
  });

  /// Factory method to create an instance of ShopModel from JSON.
  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      name: json["name"] ?? "",
      shop_code: json["shop_code"] ?? "",
      password: json["password"] ?? "",
      email: json["email"] ?? "",
    );
  }

  /// Method to convert an instance of ShopModel to JSON.
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "shop_code": shop_code,
      "password": password,
      "email": email,
    };
  }

    Map<String, dynamic> toLogin() {
    return {
      "shop_code": shop_code,
      "password": password,
    };
  }
}
