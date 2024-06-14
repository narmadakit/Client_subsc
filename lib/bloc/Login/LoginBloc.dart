import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:client_subscriber/bloc/Login/LoginEvent.dart';
import 'package:client_subscriber/bloc/Login/LoginState.dart';

import '../../model/LoginResponse.dart';
import '../../repo/LoginRepo.dart';
import '../../utils/SharedPref.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState> {
  final LoginRepo repo;
  LoginBloc(this.repo):super(LoginInitialState()){
    on<GetOtpEvent>(_getOTPCall);
    on<VerifyOtpBtn>(_verifyOTPCall);
  }

  var sharedPref=SharedPref();

  Future _getOTPCall(GetOtpEvent event, Emitter<LoginState> emit) async {
    if(event is GetOtpEvent){
      emit(LoginLoadingState());
      if(event.mobileNo == ""){
        emit(LoginErrorState());
        emit(LoginInitialState());
      }
      else{
        emit(LoginLoadingState());
        try{
          LoginResponse loginResponse =await repo.getOtpCall(event.mobileNo);
          if(loginResponse.pstatus == true){
            emit(LoginSuccessState(loginResponse));
            await sharedPref.save('loginData', loginResponse);
          }
          else {
            emit(LoginFailure());
            emit(LoginInitialState());
          }
          print('--------------------${loginResponse.pmessage}');
        }
        catch(e){
          emit(LoginFailure());
          print('Exception >>>>>>> $e');
        }
      }
    }
  }


  Future<FutureOr> _verifyOTPCall(VerifyOtpBtn event, Emitter<LoginState> emit) async {
    LoginResponse loginResponse =LoginResponse();
    loginResponse.pmobileno ="8985812695";
    loginResponse.pstatus=true;
    loginResponse.pmessage="Success";
    loginResponse.pToken ="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjEiLCJuYmYiOjE3MTY0Njc4NjgsImV4cCI6MTk3NTY2Nzg2OCwiaWF0IjoxNzE2NDY3ODY4fQ.VnDRgqO8TXeTpIq6r9XW0WmkN5gkA8JkeOjCtKE4jIM";
    loginResponse.pRoleid =1;
    loginResponse.otp=null;
    await sharedPref.save("loginData", loginResponse);
    if(event is VerifyOtpBtn){
      if(event.otp == ""){
        emit(VerifyError());
        emit(VerifyInitial());
      }
      else {
        emit(VerifyLoading());
        try {
          LoginResponse loginResponse = await repo.verifyOtpCall(
              event.mobileno, event.otp);
          if (loginResponse.pstatus == true) {
            emit(VerifySucess());
            print('OTPEVENT---------- ${loginResponse.pToken}');
            await sharedPref.save("loginData", loginResponse);
          }
          else {
            emit(VerifyError());
            emit(VerifyInitial());
          }
        }
        catch (e) {
          emit(VerifyError());
        }
      }
    }

  }
}