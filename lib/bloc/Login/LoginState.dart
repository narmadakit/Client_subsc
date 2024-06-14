import 'package:equatable/equatable.dart';

sealed class LoginState extends Equatable{
  @override
  List<Object?> get props => throw UnimplementedError();
}
class LoginInitialState extends LoginState{}
class LoginLoadingState extends LoginState{}
class LoginSuccessState extends LoginState{
  final loginData;
  LoginSuccessState(this.loginData);
  @override
  List<Object?> get props => [loginData];
}
class LoginFailureState extends LoginState{}
class LoginErrorState extends LoginState{}

//verify
class VerifySucess extends LoginState{}
class VerifyLoading extends LoginState{}
class VerifyError extends LoginState{}
class LoginFailure extends LoginState{}
class VerifyInitial extends LoginState {
  @override
  List<Object?> get props => [];
}