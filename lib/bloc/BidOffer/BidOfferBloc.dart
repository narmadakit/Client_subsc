import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:client_subscriber/bloc/BidOffer/BidOfferEvent.dart';
import 'package:client_subscriber/bloc/BidOffer/BidOfferState.dart';
import 'package:client_subscriber/model/BidOfferResponse.dart';
import 'package:client_subscriber/repo/BidRepo.dart';

import '../../model/SaveBidOfferResponse.dart';

class BidOfferBloc extends Bloc<BidofferEvent,BidofferState>{
  BidRepo repo;
  BidOfferBloc(this.repo):super(BidInitialState()){
    on<GetMaxBidEvent>(_getMaxBidOffer);
    on<SaveBidOfferEvent>(_saveBidOffer);
  }

   _getMaxBidOffer(GetMaxBidEvent event, Emitter<BidofferState> emit) async {
    if(event is GetMaxBidEvent){
      emit(BidInitialState());
      try{
        BidOfferResponse responseData =await repo.getMaxBidOffer(event.groupCode,event.branchName,event.auctionMonth);
        if(responseData.maxDiscount != null){
          emit(BidLoadedState(responseData));
        }
        else {
          emit(BidEmptyState());
          emit(BidInitialState());
        }
      }
      catch(e){
        emit(BidErrorState());
      }
    }
  }

   Future<SaveBidOfferResponse> _saveBidOffer(SaveBidOfferEvent event, Emitter<BidofferState> emit) async {
     emit(SaveBidLoadingState());
     SaveBidOfferResponse responseData=SaveBidOfferResponse();
    try{
       responseData =await repo.saveBidOffer(event.bidOfferRequest);
      if(responseData.statusmsg == "Bid Offer Saved Sucessfully"){
        emit(SaveBidSuccessState(responseData));
      }
      else {
        emit(SaveBidErrorState(responseData));

      }
    }
    catch(e){
      emit(SaveBidInitialState());
    }
    return responseData;
  }
}