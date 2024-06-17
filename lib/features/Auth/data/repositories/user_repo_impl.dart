import 'package:dartz/dartz.dart';
import 'package:final_year/features/Auth/data/datasources/user_remote_data_source.dart';
import 'package:final_year/features/Auth/domain/entities/user.dart';
import 'package:final_year/features/Auth/domain/repositories/user_repository.dart';
import 'package:final_year/utils/failure.dart';
import 'package:final_year/utils/network/network_info.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource remoteDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, User>> loginUser(String login, String password) async {
    print(login);
    print(password);
    if (await networkInfo.isConnected) {
      //when online
      try {
        return Right(await remoteDataSource.loginUser(login, password));
      } on OdooException {
        return Left(AuthFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> logoutUser() async {
    try {
      return Right(await remoteDataSource.logoutUser());
    } on Exception {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> signupUser(
      String name, String email, String phone, String password) async {
    if (await networkInfo.isConnected) {
      //when online
      try {
        return Right(
            await remoteDataSource.signupUser(name, phone, password, email));
      } on OdooException {
        return Left(AuthFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
