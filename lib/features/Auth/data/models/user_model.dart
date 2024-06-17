import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel(
      {required super.id,
      required super.login,
      required super.phone,
      required super.name,
      required super.password,
      });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        name: json['name'],
        login: json['login'],
        password: json['password'],
        phone: json['phone'] ,
      );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'login': login,
      'password': password,
      'phone': phone,
      
    };
  }
}
