import 'dart:convert';

ChitDetailsModel detailsByNoModelfromJson(String str) => ChitDetailsModel.fromJson(json.decode(str));
class ChitDetailsModel {
  String? pvchbranch;
  String? pchitno;
  String? psubscribername;
  num? psubscriptionamt;
  Null? psubscriptionamt1;
  String? pauctmonth;
  num? pchitvalue;
  num? pnumdividend;
  String? pauctionmonth;
  String? pchitstatus;
  num? pcurrentmonthinstallment;
  String? pnoofauctions;
  String? pduedate;
  String? pauctiondate;
  int? ppenalty;
  num? pdue;
  num? padvance;
  num? pnetpayable;
  String? pvchterritory;
  Null? payamount;
  num? previousdue;
  num? psumatcredit;
  num? ptotaldue;
  Null? pchitperiod;
  Null? chitperiodCode;
  Null? chitvalueCode;
  Null? pchitgroupid;
  Null? pgroupcode;
  String? chitperiodType;
  Null? pcontactid;
  Null? chitgroupStatus;
  Null? oldticketno;
  Null? vchprn;
  Null? recordid;
  Null? onboardingcharges;
  Null? psoNumber;
  Null? branchName;
  Null? branchCode;
  num? bidAmount;
  num? bidPayableAmount;
  num? nextOfferAmount;
  String? nextAuctionDate;
  String? nextAuctionTime;
  List<LstSubscribertransDTO>? lstSubscribertransDTO;

  ChitDetailsModel(
      {this.pvchbranch,
        this.pchitno,
        this.psubscribername,
        this.psubscriptionamt,
        this.psubscriptionamt1,
        this.pauctmonth,
        this.pchitvalue,
        this.pnumdividend,
        this.pauctionmonth,
        this.pchitstatus,
        this.pcurrentmonthinstallment,
        this.pnoofauctions,
        this.pduedate,
        this.pauctiondate,
        this.ppenalty,
        this.pdue,
        this.padvance,
        this.pnetpayable,
        this.pvchterritory,
        this.payamount,
        this.previousdue,
        this.psumatcredit,
        this.ptotaldue,
        this.pchitperiod,
        this.chitperiodCode,
        this.chitvalueCode,
        this.pchitgroupid,
        this.pgroupcode,
        this.chitperiodType,
        this.pcontactid,
        this.chitgroupStatus,
        this.oldticketno,
        this.vchprn,
        this.recordid,
        this.onboardingcharges,
        this.psoNumber,
        this.branchName,
        this.branchCode,
        this.bidAmount,
        this.bidPayableAmount,
        this.nextOfferAmount,
        this.nextAuctionDate,
        this.nextAuctionTime,
        this.lstSubscribertransDTO});

  ChitDetailsModel.fromJson(Map<String, dynamic> json) {
    pvchbranch = json['pvchbranch'];
    pchitno = json['pchitno'];
    psubscribername = json['psubscribername'];
    psubscriptionamt = json['psubscriptionamt'];
    psubscriptionamt1 = json['psubscriptionamt1'];
    pauctmonth = json['pauctmonth'];
    pchitvalue = json['pchitvalue'];
    pnumdividend = json['pnumdividend'];
    pauctionmonth = json['pauctionmonth'];
    pchitstatus = json['pchitstatus'];
    pcurrentmonthinstallment = json['pcurrentmonthinstallment'];
    pnoofauctions = json['pnoofauctions'];
    pduedate = json['pduedate'];
    pauctiondate = json['pauctiondate'];
    ppenalty = json['ppenalty'];
    pdue = json['pdue'];
    padvance = json['padvance'];
    pnetpayable = json['pnetpayable'];
    pvchterritory = json['pvchterritory'];
    payamount = json['payamount'];
    previousdue = json['previousdue'];
    psumatcredit = json['psumatcredit'];
    ptotaldue = json['ptotaldue'];
    pchitperiod = json['pchitperiod'];
    chitperiodCode = json['chitperiod_code'];
    chitvalueCode = json['chitvalue_code'];
    pchitgroupid = json['pchitgroupid'];
    pgroupcode = json['pgroupcode'];
    chitperiodType = json['chitperiod_type'];
    pcontactid = json['pcontactid'];
    chitgroupStatus = json['chitgroup_status'];
    oldticketno = json['oldticketno'];
    vchprn = json['vchprn'];
    recordid = json['recordid'];
    onboardingcharges = json['onboardingcharges'];
    psoNumber = json['pso_number'];
    branchName = json['branch_name'];
    branchCode = json['branch_code'];
    bidAmount = json['bid_amount'];
    bidPayableAmount = json['bid_payable_amount'];
    nextOfferAmount = json['next_offer_amount'];
    nextAuctionDate = json['next_auction_date'];
    nextAuctionTime = json['next_auction_time'];
    if (json['lstSubscribertransDTO'] != null) {
      lstSubscribertransDTO = <LstSubscribertransDTO>[];
      json['lstSubscribertransDTO'].forEach((v) {
        lstSubscribertransDTO!.add(new LstSubscribertransDTO.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pvchbranch'] = this.pvchbranch;
    data['pchitno'] = this.pchitno;
    data['psubscribername'] = this.psubscribername;
    data['psubscriptionamt'] = this.psubscriptionamt;
    data['psubscriptionamt1'] = this.psubscriptionamt1;
    data['pauctmonth'] = this.pauctmonth;
    data['pchitvalue'] = this.pchitvalue;
    data['pnumdividend'] = this.pnumdividend;
    data['pauctionmonth'] = this.pauctionmonth;
    data['pchitstatus'] = this.pchitstatus;
    data['pcurrentmonthinstallment'] = this.pcurrentmonthinstallment;
    data['pnoofauctions'] = this.pnoofauctions;
    data['pduedate'] = this.pduedate;
    data['pauctiondate'] = this.pauctiondate;
    data['ppenalty'] = this.ppenalty;
    data['pdue'] = this.pdue;
    data['padvance'] = this.padvance;
    data['pnetpayable'] = this.pnetpayable;
    data['pvchterritory'] = this.pvchterritory;
    data['payamount'] = this.payamount;
    data['previousdue'] = this.previousdue;
    data['psumatcredit'] = this.psumatcredit;
    data['ptotaldue'] = this.ptotaldue;
    data['pchitperiod'] = this.pchitperiod;
    data['chitperiod_code'] = this.chitperiodCode;
    data['chitvalue_code'] = this.chitvalueCode;
    data['pchitgroupid'] = this.pchitgroupid;
    data['pgroupcode'] = this.pgroupcode;
    data['chitperiod_type'] = this.chitperiodType;
    data['pcontactid'] = this.pcontactid;
    data['chitgroup_status'] = this.chitgroupStatus;
    data['oldticketno'] = this.oldticketno;
    data['vchprn'] = this.vchprn;
    data['recordid'] = this.recordid;
    data['onboardingcharges'] = this.onboardingcharges;
    data['pso_number'] = this.psoNumber;
    data['branch_name'] = this.branchName;
    data['branch_code'] = this.branchCode;
    data['bid_amount'] = this.bidAmount;
    data['bid_payable_amount'] = this.bidPayableAmount;
    data['next_offer_amount'] = this.nextOfferAmount;
    data['next_auction_date'] = this.nextAuctionDate;
    data['next_auction_time'] = this.nextAuctionTime;
    if (this.lstSubscribertransDTO != null) {
      data['lstSubscribertransDTO'] =
          this.lstSubscribertransDTO!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LstSubscribertransDTO {
  String? ptransno;
  String? pmobileno;
  String? pgroupcode;
  String? ptransdate;
  num? ptotalamount;
  Null? pticketno;
  Null? psubscriptionamt;

  LstSubscribertransDTO(
      {this.ptransno,
        this.pmobileno,
        this.pgroupcode,
        this.ptransdate,
        this.ptotalamount,
        this.pticketno,
        this.psubscriptionamt});

  LstSubscribertransDTO.fromJson(Map<String, dynamic> json) {
    ptransno = json['ptransno'];
    pmobileno = json['pmobileno'];
    pgroupcode = json['pgroupcode'];
    ptransdate = json['ptransdate'];
    ptotalamount = json['ptotalamount'];
    pticketno = json['pticketno'];
    psubscriptionamt = json['psubscriptionamt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ptransno'] = this.ptransno;
    data['pmobileno'] = this.pmobileno;
    data['pgroupcode'] = this.pgroupcode;
    data['ptransdate'] = this.ptransdate;
    data['ptotalamount'] = this.ptotalamount;
    data['pticketno'] = this.pticketno;
    data['psubscriptionamt'] = this.psubscriptionamt;
    return data;
  }
}