class MyUser {
  static const String path = 'User';

  final String id;
  final String firstName;
  final String lastName;
  final String email;

  MyUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory MyUser.fromJson(Map<String, dynamic> json) {
    return MyUser(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
  }
}
