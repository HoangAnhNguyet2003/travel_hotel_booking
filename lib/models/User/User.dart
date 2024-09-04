class User {
  final String fullname;
  final String email;
  final String password;
  final String? token;
  final String? userId; 

  User({
    required this.fullname,
    required this.email,
    required this.password,
    this.token,
    this.userId, 
  });

  Map<String, dynamic> toJson() {
    return {
      'fullname': fullname,
      'email': email,
      'password': password,
      'token': token,
      'userId': userId,
    };
  }
}