class AuctionReponse {
  num? rowNumber;
  String? vchbranchname;
  String? vchgrpcode;
  num? numticketno;
  String? chitno;
  num? chitvalue;
  String? vchsubscribername;
  num? auctmonth;
  String? auctiondate;
  String? vchaucttime;
  String? auctiondatetime;
  String? auctionstatus;
  num? maxbidoffer;
  String? serverdatetime;
  String? serverdate;
  String? servertime;
  String? auctioncountdowntime;

  AuctionReponse(
      {this.rowNumber,
        this.vchbranchname,
        this.vchgrpcode,
        this.numticketno,
        this.chitno,
        this.chitvalue,
        this.vchsubscribername,
        this.auctmonth,
        this.auctiondate,
        this.vchaucttime,
        this.auctiondatetime,
        this.auctionstatus,
        this.maxbidoffer,
        this.serverdatetime,
        this.serverdate,
        this.servertime,
        this.auctioncountdowntime});

  AuctionReponse.fromJson(Map<String, dynamic> json) {
    rowNumber = json['rowNumber'];
    vchbranchname = json['vchbranchname'];
    vchgrpcode = json['vchgrpcode'];
    numticketno = json['numticketno'];
    chitno = json['chitno'];
    chitvalue = json['chitvalue'];
    vchsubscribername = json['vchsubscribername'];
    auctmonth = json['auctmonth'];
    auctiondate = json['auctiondate'];
    vchaucttime = json['vchaucttime'];
    auctiondatetime = json['auctiondatetime'];
    auctionstatus = json['auctionstatus'];
    maxbidoffer = json['maxbidoffer'];
    serverdatetime = json['serverdatetime'];
    serverdate = json['serverdate'];
    servertime = json['servertime'];
    auctioncountdowntime = json['auctioncountdowntime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rowNumber'] = this.rowNumber;
    data['vchbranchname'] = this.vchbranchname;
    data['vchgrpcode'] = this.vchgrpcode;
    data['numticketno'] = this.numticketno;
    data['chitno'] = this.chitno;
    data['chitvalue'] = this.chitvalue;
    data['vchsubscribername'] = this.vchsubscribername;
    data['auctmonth'] = this.auctmonth;
    data['auctiondate'] = this.auctiondate;
    data['vchaucttime'] = this.vchaucttime;
    data['auctiondatetime'] = this.auctiondatetime;
    data['auctionstatus'] = this.auctionstatus;
    data['maxbidoffer'] = this.maxbidoffer;
    data['serverdatetime'] = this.serverdatetime;
    data['serverdate'] = this.serverdate;
    data['servertime'] = this.servertime;
    data['auctioncountdowntime'] = this.auctioncountdowntime;
    return data;
  }

  static List<AuctionReponse> fromJsonList(List list){
    return list.map((e) => AuctionReponse.fromJson(e)).toList();
  }
}