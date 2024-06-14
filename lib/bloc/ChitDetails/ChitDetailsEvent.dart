import 'package:equatable/equatable.dart';

abstract class ChitDetailsEvent extends Equatable{}
class GetChitDetailsByTicket extends ChitDetailsEvent{
  final String chitno;

  GetChitDetailsByTicket(this.chitno);
  @override
  List<Object?> get props => [chitno];
}