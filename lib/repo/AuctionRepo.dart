import 'package:dio/dio.dart';
import '../Utils/ApiConst.dart';
import '../model/AuctionReponse.dart';

class AuctionRepo{
  var token ="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjEiLCJuYmYiOjE3MTQ1NDYxNjYsImV4cCI6MTk3Mzc0NjE2NiwiaWF0IjoxNzE0NTQ2MTY2fQ.fOD7Qo2cfY1UZIV41DNk458Zp1F6c66-_XQhkXHY-Sw";

  Future<List<AuctionReponse>> getAuctionDetails(String mobileno) async {
    List<AuctionReponse> auctionList=[];
    Response response = await Dio().get(ApiConst.GET_AUCTION_DETAILS(mobileno),
        options: Options(headers: {
          "Authorization":"Bearer $token",
        })
    );
    if (response.statusCode == 200) {
      print('Sucesss --Auctionlist --  ${response.data}');
      auctionList = AuctionReponse.fromJsonList(response.data);
      print('Auctionlist -- $auctionList');
    }
    return auctionList;
  }
}