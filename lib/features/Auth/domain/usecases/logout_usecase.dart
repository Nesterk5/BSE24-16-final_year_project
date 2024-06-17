import 'package:dartz/dartz.dart';
import 'package:final_year/utils/failure.dart';

import '../repositories/user_repository.dart';

class LogoutUserUsecase {
  final UserRepository repository;
  const LogoutUserUsecase({required this.repository});
  Future<Either<Failure, bool>> call() {
    return repository.logoutUser();
  }
}
