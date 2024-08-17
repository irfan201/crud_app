class UserModel {
  String? username;
  String? email;
  String? token;

  UserModel({this.username, this.email, this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      email: json['email'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'token': token,
    };
  }
}
