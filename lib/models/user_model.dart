class UserModel {
  UserModel(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.img});

  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String img;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"] as int? ?? 0,
      email: json["email"] as String? ?? "",
      firstName: json["first_name"] as String? ?? "",
      lastName: json["last_name"] as String? ?? "",
      img: json["avatar"] as String? ?? "",
    );
  }
}
