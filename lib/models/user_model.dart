class UserModel {
  final String name;
  final String email;
  final String phone;
  final String nic;
  final String? password;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.nic,
    this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        nic: json['nic'],
        password: json['password'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'nic': nic,
        'password': password, // Handle password security appropriately
      };
}
