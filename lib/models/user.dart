class User {
  String? username;
  String? password;
  String? email;
  int? id;

  User({this.username, this.password, this.email, this.id});

  /// Creates a user object from a JSON object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      password: json['password'],
      email: json['email'],
      id: json['id'],
    );
  }

  /// Creates a JSON object from a user object
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'email': email,
      'id': id,
    };
  }
}
