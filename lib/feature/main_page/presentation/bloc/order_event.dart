part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}


class GetApplicationsByDateEvent extends OrderEvent {
  GetApplicationsByDateEvent({required this.date});

  final String date;
}
