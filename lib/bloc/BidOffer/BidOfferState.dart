import 'package:equatable/equatable.dart';

import '../../model/BidOfferResponse.dart';
import '../../model/SaveBidOfferResponse.dart';

abstract class BidofferState extends Equatable{
  @override
  List<Object?> get props => [];
}
class BidInitialState extends BidofferState {}
class BidLoadedState extends BidofferState {
  final BidOfferResponse bidOfferResponse;

  BidLoadedState(this.bidOfferResponse);
  @override
  List<Object?> get props => [bidOfferResponse];
}
class BidEmptyState extends BidofferState {}
class BidErrorState extends BidofferState {}
class SaveBidInitialState extends BidofferState {}
class SaveBidLoadingState extends BidofferState {}
class SaveBidSuccessState extends BidofferState {
  final SaveBidOfferResponse saveBidOfferResponse;

  SaveBidSuccessState(this.saveBidOfferResponse);
  @override
  List<Object?> get props => [saveBidOfferResponse];
}
class SaveBidErrorState extends BidofferState {
  final SaveBidOfferResponse saveBidOfferResponse;

  SaveBidErrorState(this.saveBidOfferResponse);
  @override
  List<Object?> get props => [saveBidOfferResponse];
}