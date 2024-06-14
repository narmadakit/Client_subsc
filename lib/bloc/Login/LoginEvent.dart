import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable{
  @override
  List<Object?> get props => [];
}
class GetOtpEvent extends LoginEvent{
  final String mobileNo;
  GetOtpEvent(this.mobileNo);

  @override
  List<Object?> get props => [mobileNo];
}
class VerifyOtpBtn extends LoginEvent {
  final String mobileno;
  final String otp;

  VerifyOtpBtn(this.mobileno, this.otp);

  @override
  List<Object> get props =>[mobileno,otp];
}