abstract class UserModel {
  String username;
  UserModel({required this.username});
}

final class UserLoginModel extends UserModel {
  String password;
  UserLoginModel({required super.username, required this.password});
}

final class UserLoggedModel extends UserModel {
  int id;
  String email;
  String firstName;
  String lastName;
  String gender;
  String image;
  String accessToken;
  String refreshToken;

  UserLoggedModel({
    required super.username,
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    required this.accessToken,
    required this.refreshToken,
  });
}
