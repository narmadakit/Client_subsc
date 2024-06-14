import 'dart:convert';

LoginResponse loginModelFromJson(String str) => LoginResponse.fromJson(json.decode(str));
class LoginResponse {
  String? pmobileno;
  bool? pstatus;
  String? pmessage;
  String? pToken;
  num? pRoleid;
  String? otp;

  LoginResponse(
      {this.pmobileno, this.pstatus, this.pmessage, this.pToken, this.pRoleid,this.otp});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    pmobileno = json['pmobileno'];
    pstatus = json['pstatus'];
    pmessage = json['pmessage'];
    pToken = json['pToken'];
    pRoleid = json['pRoleid'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['pmobileno'] = this.pmobileno;
    data['pstatus'] = this.pstatus;
    data['pmessage'] = this.pmessage;
    data['pToken'] = this.pToken;
    data['pRoleid'] = this.pRoleid;
    data['otp'] = this.otp;
    return data;
  }
}