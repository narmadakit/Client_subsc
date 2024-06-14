class SaveBidOfferResponse {
  String? statusmsg;

  SaveBidOfferResponse({this.statusmsg});

  SaveBidOfferResponse.fromJson(Map<String, dynamic> json) {
    statusmsg = json['statusmsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusmsg'] = this.statusmsg;
    return data;
  }
}