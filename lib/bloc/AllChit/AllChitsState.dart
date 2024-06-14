import 'package:equatable/equatable.dart';

import '../../model/AllChitsModel.dart';

abstract class AllChitsState extends Equatable{
  @override
  List<Object?> get props => [];

}
class ChitsInitialState extends AllChitsState{
  @override
  List<Object?> get props => [];
}
class ChitLoadedState extends AllChitsState{
  final List<AllChitsModel> model;
  ChitLoadedState(this.model);

  @override
  List<Object?> get props => [];
}
class ChitErrorState extends AllChitsState{
  @override
  List<Object?> get props => [];
}