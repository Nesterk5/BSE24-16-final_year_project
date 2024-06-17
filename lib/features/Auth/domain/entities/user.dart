import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String login;
  final String password;
  final String phone;

  User(
      {required this.id,
      required this.name,
      
      required this.login,
      required this.password,
      required this.phone,
    })
      : super();

  @override
  List<Object?> get props => [id, name, login, password, phone];

}
