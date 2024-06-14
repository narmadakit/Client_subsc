import 'package:equatable/equatable.dart';

abstract class AuctionEvent extends Equatable{
  @override
  List<Object?> get props => [];
}
class GetAuctionDetailsEvent extends AuctionEvent{
  final String mobileNo;

  GetAuctionDetailsEvent(this.mobileNo);
  @override
  List<Object?> get props => [mobileNo];
}