import 'dart:convert';
import 'package:client_subscriber/model/AllChitsModel.dart';
import 'package:client_subscriber/model/ChitDetailsModel.dart';
import 'package:client_subscriber/model/LoginResponse.dart';
import 'package:client_subscriber/utils/ApiConst.dart';
import 'package:client_subscriber/utils/AppWidgets.dart';
import 'package:dio/dio.dart';
import '../Utils/SharedPref.dart';

class ChitsRepo{
  LoginResponse loginData=LoginResponse();
  var sharedpref=SharedPref();

  getLoginData()async{
    loginData= LoginResponse.fromJson(await sharedpref.read("loginData"));
    AppWidgets.gMobileNo = loginData.pmobileno;
  }

  Future<List<AllChitsModel>> getAllChitLists(String mobileno) async {
    getLoginData();
    String token = loginData.pToken.toString();
    List<AllChitsModel> listdata=[];

    Response response = await Dio().get(ApiConst.GET_ALL_CHITS_URL(mobileno),
        options: Options(headers: {
          "Authorization":"Bearer $token",
        })
    );
    if (response.statusCode == 200) {
      print('Sucesss --Allchitlist');
      listdata = AllChitsModel.fromJsonList(response.data);
    }
    return listdata;
  }

  Future<ChitDetailsModel> getChitDeatilsByChitNo(String ticket) async {
    getLoginData();
    String token = loginData.pToken.toString();
    ChitDetailsModel chitDetailsByNoModel=ChitDetailsModel();

    Response response = await Dio().get(ApiConst.GET_CHIT_DETAILS_URL(ticket),
        options: Options(headers: {
          "Authorization":"Bearer $token",
        })
    );
    if (response.statusCode == 200) {
      chitDetailsByNoModel = detailsByNoModelfromJson(jsonEncode(response.data));
      print('++++++++++Details ${chitDetailsByNoModel}');
    }
    return chitDetailsByNoModel;
  }

// static Future<TransDetailsResponse> paymentPost(String orderid, TransRequestBody reqbody) async {
//   LoginResponseModel loginData=LoginResponseModel();
//   var sharedpref=SharedPref();
//   loginData= LoginResponseModel.fromJson(await sharedpref.read("loginData"));
//   Constants.gMobileNo = loginData.pmobileno;
//   String token = loginData.pToken.toString();
//   TransDetailsResponse responseModel=TransDetailsResponse();
//
//   Response response = await Dio().post(
//       ApiConst.POST_TRANSACTION_DETAILS(orderid),
//       options: Options(headers: {
//         "Authorization":"Bearer $token",
//       }),
//       data: jsonEncode(reqbody)
//   );
//   // final data = response.data;
//   if (response.statusCode == 200) {
//     responseModel = transDetailsModelfromJson(jsonEncode(response.data));
//     print('RESPONE______________${jsonEncode(responseModel)}');
//     await sharedpref.save('transaction', responseModel);
//   }
//   return responseModel;
// }
}