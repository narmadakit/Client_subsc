import 'package:equatable/equatable.dart';

abstract class AllChitsEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class GetChitDetailsEvent extends AllChitsEvent{
  final String mobileNo;

  GetChitDetailsEvent(this.mobileNo);

  @override
  List<Object?> get props => [mobileNo];
}
class GetAllChitByTicket extends AllChitsEvent{
  GetAllChitByTicket();
  @override
  List<Object?> get props => [];
}