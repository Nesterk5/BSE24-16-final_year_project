part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignupEvent extends AuthEvent {
  final String name;
  final String phone;
  final String password;
  final String email;
  const SignupEvent(
      {required this.name,
      required this.phone,
      required this.password,
      required this.email});
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class LogoutUserEvent extends AuthEvent {}


class InitialiseAuthEvent extends AuthEvent {}
