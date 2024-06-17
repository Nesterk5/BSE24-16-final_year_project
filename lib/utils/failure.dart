import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  // If the subclasses have some properties, they'll get passed to this constructor
  // so that Equatable can perform value comparison.
  const Failure([List properties = const <dynamic>[]]) : super();
}

class ConnectionFailure extends Failure {
  // TODO: implement props
  @override
  List<Object?> get props => [];
}

///this error is only raised when the odoo server cannot athuenticate the user. The server failure will be returned for http errors
class AuthFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SignUpFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CacheFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}