import 'dart:convert';

import 'package:client_subscriber/model/BidOfferResponse.dart';
import 'package:client_subscriber/model/SaveBidOfferRequest.dart';
import 'package:client_subscriber/model/SaveBidOfferResponse.dart';
import 'package:dio/dio.dart';

import '../Utils/ApiConst.dart';

class BidRepo{
  var token ="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjEiLCJuYmYiOjE3MTQ1NDYxNjYsImV4cCI6MTk3Mzc0NjE2NiwiaWF0IjoxNzE0NTQ2MTY2fQ.fOD7Qo2cfY1UZIV41DNk458Zp1F6c66-_XQhkXHY-Sw";

  Future<BidOfferResponse> getMaxBidOffer(String? groupCode,branchName,num? auctionMonth) async {
    BidOfferResponse responseData=BidOfferResponse();
    Response response = await Dio().get(ApiConst.GET_MAXBID_OFFER(groupCode!,branchName,auctionMonth!),
        options: Options(headers: {
          "Authorization":"Bearer $token",
        })
    );
    if (response.statusCode == 200) {
      print('Sucesss --BID RESPONSE --  ${response.data}');
      responseData = responseModelFromJson(jsonEncode(response.data));
      return responseData;
    }
    return responseData;
  }

   saveBidOffer(SaveBidOfferRequest bidOfferRequest) async {
    SaveBidOfferResponse responseData=SaveBidOfferResponse();
    Response response = await Dio().post(ApiConst.SAVE_BIDOFFER,
        options: Options(headers: {
          "Authorization":"Bearer $token",
        }),
      data: jsonEncode(bidOfferRequest)
    );
    if (response.statusCode == 200) {
      responseData = responseModelFromJsonSaveBid(jsonEncode(response.data));
      return responseData;
    }
  }

}