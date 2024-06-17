import 'package:final_year/features/Auth/data/datasources/user_remote_data_source.dart';
import 'package:final_year/features/Auth/data/repositories/user_repo_impl.dart';
import 'package:final_year/features/Auth/domain/repositories/user_repository.dart';
import 'package:final_year/features/Auth/domain/usecases/login_usecase.dart';
import 'package:final_year/features/Auth/domain/usecases/logout_usecase.dart';
import 'package:final_year/features/Auth/domain/usecases/signup_usecase.dart';
import 'package:final_year/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:final_year/utils/network/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  initAuth();
  initCore();
  await initExternal();
}

void initAuth() {
  //bloc

  sl.registerFactory(() => AuthBloc(
      loginUser: sl(), signupUserUsecase: sl(), logoutUserUsecase: sl()));

  //use cases
  sl.registerLazySingleton(() => LoginUserUsecase(sl()));
  sl.registerLazySingleton(() => SignupUserUsecase(repository: sl()));
  sl.registerLazySingleton(() => LogoutUserUsecase(repository: sl()));

  //repository
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(sl(), sl()));

  sl.registerLazySingleton<UserRemoteDatasource>(
      () => UserRemoteDatasourceImpl());
}

void initCore() {
  //network info
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}

Future<void> initExternal() async {
//Internet connection checker
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => InternetConnectionChecker());
  //Shared Preferences
  sl.registerLazySingleton(() => sharedPreferences);
  //odoo RPC
}
