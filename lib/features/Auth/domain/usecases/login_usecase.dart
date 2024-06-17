import 'package:dartz/dartz.dart';
import 'package:final_year/utils/failure.dart';

import '../entities/user.dart';
import '../repositories/user_repository.dart';

class LoginUserUsecase {
  final UserRepository repository;
  const LoginUserUsecase(this.repository);
  Future<Either<Failure, User>> call(String login, String password) {
    return repository.loginUser(login, password);
  }
}