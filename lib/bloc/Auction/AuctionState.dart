import 'package:equatable/equatable.dart';

import '../../model/AuctionReponse.dart';

abstract class AuctionState extends Equatable{
  @override
  List<Object?> get props => [];
}
class AuctionInitialState extends AuctionState{
  @override
  List<Object?> get props => [];
}
class AuctionLoadedState extends AuctionState{
  final List<AuctionReponse> model;

  AuctionLoadedState(this.model);
  @override
  List<Object?> get props => [];
}
class AuctionLoadingState extends AuctionState{


  @override
  List<Object?> get props => [];
}

class AuctionErrorState extends AuctionState{

}