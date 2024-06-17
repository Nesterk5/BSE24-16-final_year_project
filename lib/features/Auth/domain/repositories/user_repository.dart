import 'package:dartz/dartz.dart';
import 'package:final_year/features/Auth/domain/entities/user.dart';
import 'package:final_year/utils/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> loginUser(String login, String password);
  Future<Either<Failure, bool>> logoutUser();
  Future<Either<Failure, bool>> signupUser(
      String name, String email,String phone, String password);
}
