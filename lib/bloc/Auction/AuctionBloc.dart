import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../model/AuctionReponse.dart';
import '../../repo/AuctionRepo.dart';
import 'AuctionEvent.dart';
import 'AuctionState.dart';

class AuctionBloc extends Bloc<AuctionEvent,AuctionState>{
  AuctionRepo repo;
  AuctionBloc(this.repo):super(AuctionInitialState()){
    on<GetAuctionDetailsEvent>(_getAuctionDetails);
  }

  _getAuctionDetails(GetAuctionDetailsEvent event, Emitter<AuctionState> emit) async {

      // emit(AuctionInitialState());
      emit(AuctionLoadingState());
      try{
        List<AuctionReponse> auctionList=await repo.getAuctionDetails(event.mobileNo);
        if(auctionList.isNotEmpty){
          emit(AuctionLoadedState(auctionList));
        }
        else{
          emit(AuctionErrorState());
        }
      }
      catch(e){
        emit(AuctionErrorState());
        print('=AuctionError==== $e');
      }
      }
}