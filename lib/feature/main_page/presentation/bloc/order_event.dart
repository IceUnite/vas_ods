part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

class GetApplicationsByDateEvent extends OrderEvent {
  GetApplicationsByDateEvent({required this.date});

  final String date;
}
class GetAllApplicationsEvent extends OrderEvent {
  GetAllApplicationsEvent();
}

class ChangeDateEvent extends OrderEvent {
  ChangeDateEvent({required this.date});

  final DateTime date;
}

class ChangeApplicationStatusEvent extends OrderEvent {
  ChangeApplicationStatusEvent({
    required this.userId,
    required this.token,
    required this.applicationId,
    required this.status,
    this.description,
  });

  final int userId;
  final String token;
  final int applicationId;
  final String status;
  final String? description;
}