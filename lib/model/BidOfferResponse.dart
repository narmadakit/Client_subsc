import 'dart:convert';

BidOfferResponse responseModelFromJson(String str) => BidOfferResponse.fromJson(json.decode(str));
class BidOfferResponse {
  String? branchName;
  String? subscriberName;
  String? groupcode;
  num? ticketno;
  num? auctionMonth;
  String? maxDiscount;
  String? minDiscount;
  String? offerAmount;
  String? offerEnteredby;
  String? status;

  BidOfferResponse(
      {this.branchName,
        this.subscriberName,
        this.groupcode,
        this.ticketno,
        this.auctionMonth,
        this.maxDiscount,
        this.minDiscount,
        this.offerAmount,
        this.offerEnteredby,
        this.status});

  BidOfferResponse.fromJson(Map<String, dynamic> json) {
    branchName = json['branchName'];
    subscriberName = json['subscriberName'];
    groupcode = json['groupcode'];
    ticketno = json['ticketno'];
    auctionMonth = json['auctionMonth'];
    maxDiscount = json['maxDiscount'];
    minDiscount = json['minDiscount'];
    offerAmount = json['offerAmount'];
    offerEnteredby = json['offerEnteredby'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branchName'] = this.branchName;
    data['subscriberName'] = this.subscriberName;
    data['groupcode'] = this.groupcode;
    data['ticketno'] = this.ticketno;
    data['auctionMonth'] = this.auctionMonth;
    data['maxDiscount'] = this.maxDiscount;
    data['minDiscount'] = this.minDiscount;
    data['offerAmount'] = this.offerAmount;
    data['offerEnteredby'] = this.offerEnteredby;
    data['status'] = this.status;
    return data;
  }
}