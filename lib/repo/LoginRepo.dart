import 'dart:convert';

import 'package:client_subscriber/model/LoginResponse.dart';
import 'package:client_subscriber/utils/ApiConst.dart';
import 'package:dio/dio.dart';

class LoginRepo{
Future<LoginResponse> getOtpCall(String mobileNo)async{
  LoginResponse loginResponse=LoginResponse();
Response response = await Dio().get(ApiConst.SEND_LOGINOTP_URL(mobileNo));
loginResponse = LoginResponse.fromJson(jsonDecode(response.data));
return loginResponse;
}

Future<LoginResponse> verifyOtpCall(String mobileNo,String otp)async{
  LoginResponse logindata=LoginResponse();
  Response response = await Dio().get(ApiConst.VERIFY_OTP_URL(mobileNo,otp));
  logindata =loginModelFromJson(jsonEncode(response.data));
  return logindata;
}

}