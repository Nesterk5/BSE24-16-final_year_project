import 'package:dartz/dartz.dart';
import 'package:final_year/features/Auth/domain/repositories/user_repository.dart';
import 'package:final_year/utils/failure.dart';

class SignupUserUsecase {
  final UserRepository repository;
  const SignupUserUsecase({required this.repository});
  Future<Either<Failure, bool>> call(
      String name, String phone, String password, String email) {
    return repository.signupUser(name, phone, password, email);
  }
}
