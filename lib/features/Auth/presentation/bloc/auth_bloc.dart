import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:final_year/features/Auth/domain/entities/user.dart';
import 'package:final_year/features/Auth/domain/usecases/login_usecase.dart';
import 'package:final_year/features/Auth/domain/usecases/logout_usecase.dart';
import 'package:final_year/features/Auth/domain/usecases/signup_usecase.dart';
import 'package:final_year/utils/failure.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  LoginUserUsecase loginUser;
  SignupUserUsecase signupUserUsecase;
  LogoutUserUsecase logoutUserUsecase;

  AuthBloc(
      {required this.loginUser,
      required this.signupUserUsecase,
      required this.logoutUserUsecase})
      : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(AuthLoading());
        final failureOrUser = await loginUser.call(event.email, event.password);
        emit(_eitherAuthenticatedOrErrorState(failureOrUser));
      }

      if (event is SignupEvent) {
        emit(AuthLoading());
        final failureOrUser = await signupUserUsecase.call(
            event.name, event.phone, event.email, event.password);
        emit(_eitherSignedupOrErrorState(failureOrUser));
      }

      if (event is LogoutUserEvent) {
        emit(AuthLoading());
        final failureOrSignedOut = await logoutUserUsecase.call();
        emit(_eitherFailureOrSignedOutUserState(failureOrSignedOut));
      }

      if (event is InitialiseAuthEvent) {
        emit(AuthInitial());
      }
    });
  }

  AuthState _eitherAuthenticatedOrErrorState(
      Either<Failure, User> failureOrUser) {
    return failureOrUser.fold(
      (failure) => const AuthError(message: 'Failed to Login'),
      (user) => Authenticated(user: user),
    );
  }

  AuthState _eitherSignedupOrErrorState(Either<Failure, bool> failureOrUser) {
    return failureOrUser.fold(
      (failure) => const AuthError(message: 'Failed to Signup'),
      (user) => SignedUp(is_user_signed_up: user),
    );
  }

  AuthState _eitherFailureOrSignedOutUserState(
      Either<Failure, bool> failureOrSignedOut) {
    return failureOrSignedOut.fold(
        (failure) => AuthError(message: 'Failed to sign out'),
        (response) => AuthSignedOutUser());
  }
}
