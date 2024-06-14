import 'package:client_subscriber/model/ChitDetailsModel.dart';
import 'package:equatable/equatable.dart';

abstract class ChitDetailsState extends Equatable{
}
class DetailsInitialState extends ChitDetailsState{
  @override
  List<Object?> get props => [];
}
class DetailsLoadedState extends ChitDetailsState{
  final ChitDetailsModel model;

  DetailsLoadedState(this.model);
  @override
  List<Object?> get props => [];
}
class DetailsErrorState extends ChitDetailsState{
  @override
  List<Object?> get props => [];
}