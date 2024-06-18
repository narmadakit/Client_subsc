import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:client_subscriber/bloc/AllChit/AllChitsEvent.dart';
import 'package:client_subscriber/bloc/AllChit/AllChitsState.dart';
import 'package:client_subscriber/model/AllChitsModel.dart';
import '../../repo/ChitsRepo.dart';

class AllChitsBloc extends Bloc<AllChitsEvent,AllChitsState>{
  ChitsRepo repo;
  AllChitsBloc(this.repo):super(ChitsInitialState()){
    on<GetChitDetailsEvent>(_getChitDetails);
  }

  _getChitDetails(GetChitDetailsEvent event, Emitter<AllChitsState> emit) async{
    if(event is GetChitDetailsEvent){
      emit(ChitsInitialState());
      try{
        List<AllChitsModel> chitsModelList = await repo.getAllChitLists(event.mobileNo);
        if(chitsModelList.isNotEmpty){
          emit(ChitLoadedState(chitsModelList));
        }
        else{
          emit(ChitErrorState());
          // emit(ChitsInitialState());
        }
      }
      catch(e){
        // emit(ChitErrorState());
      }


    }
  }
}