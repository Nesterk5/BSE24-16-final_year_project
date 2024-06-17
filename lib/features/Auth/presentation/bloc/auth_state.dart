part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();  

  @override
  List<Object> get props => [];
}
class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  User user;
  Authenticated({required this.user});
  @override
  List<Object> get props => [user];
}

class SignedUp extends AuthState {
  bool is_user_signed_up;
  SignedUp({required this.is_user_signed_up});
  @override
  List<Object> get props => [is_user_signed_up];
}

class AuthSignedOutUser extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object> get props => [message];
}