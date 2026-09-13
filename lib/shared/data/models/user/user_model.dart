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

  factory UserLoggedModel.fromJson(Map<String, dynamic> json) {
    return UserLoggedModel(
      username: json['username'] as String,
      id: json['id'] as int,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      gender: json['gender'] as String,
      image: json['image'] as String,
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'image': image,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  @override
  String toString() =>
      'UserLoggedModel(username: $username, id: $id, email: $email, '
      'firstName: $firstName, lastName: $lastName, gender: $gender, '
      'image: $image)';
}
