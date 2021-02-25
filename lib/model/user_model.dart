class UserAD {
  final String first_name;
  final String email;
  final String last_name;
  final String role;
  UserAD(this.first_name, this.email, this.last_name, this.role);

  UserAD.fromJson(Map<String, dynamic> json)
    : first_name = json['name'],
    email = json['email'],
    last_name = json['last_name'],
    role = json['role'];

  Map<String, dynamic> toJson() =>
      {
        'first_name': first_name,
        'email': email,
        'last_name': last_name,
        'role': role,
      };
}