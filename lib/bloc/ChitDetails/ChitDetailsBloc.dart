import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:client_subscriber/model/ChitDetailsModel.dart';
import 'package:client_subscriber/repo/ChitsRepo.dart';
import 'ChitDetailsEvent.dart';
import 'ChitDetailsState.dart';

class ChitDetailsBloc extends Bloc<ChitDetailsEvent,ChitDetailsState>{
  ChitsRepo repo;
  ChitDetailsBloc(this.repo):super(DetailsInitialState()){
    on<GetChitDetailsByTicket>(_getChitDetailsByNo);
  }

  _getChitDetailsByNo(event,Emitter<ChitDetailsState> emit)async{
    if(event is GetChitDetailsByTicket){
      emit(DetailsInitialState());
      try{
        ChitDetailsModel chitModel = await repo.getChitDeatilsByChitNo(event.chitno);
        chitModel = detailsByNoModelfromJson(jsonEncode(chitModel));
        if(chitModel != null){
          emit(DetailsLoadedState(chitModel));
        }
        else{
          emit(DetailsErrorState());
        }
      }
      catch(e){}


    }

  }

}