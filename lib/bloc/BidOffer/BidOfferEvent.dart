import 'package:client_subscriber/model/BidOfferResponse.dart';
import 'package:client_subscriber/model/SaveBidOfferRequest.dart';
import 'package:equatable/equatable.dart';

class BidofferEvent extends Equatable {
  @override
  List<Object?> get props => [];
}
class GetMaxBidEvent extends BidofferEvent {
  final String? groupCode;
  final String? branchName;
  final num? auctionMonth;

  GetMaxBidEvent(this.groupCode, this.branchName, this.auctionMonth);
  @override
  List<Object?> get props => [groupCode,branchName,auctionMonth];
}

class SaveBidOfferEvent extends BidofferEvent{
  final SaveBidOfferRequest bidOfferRequest;

  SaveBidOfferEvent(this.bidOfferRequest);
  @override
  List<Object?> get props => [bidOfferRequest];
}