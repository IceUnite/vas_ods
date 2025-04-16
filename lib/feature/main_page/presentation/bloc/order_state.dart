part of 'order_bloc.dart';

@immutable
class OrderState extends Equatable {
  OrderState({
    this.getApplicationsResponse,
    this.selectedDate,
    this.selectedDateFormatted,
    this.applicationStatus,
  });

  final OrderServiceEntity? getApplicationsResponse;
  final DateTime? selectedDate;
  final String? selectedDateFormatted;
  final ApplicationStatus? applicationStatus;

  List<Object?> get props => <Object?>[
        getApplicationsResponse,
        selectedDate,
        selectedDateFormatted,
        applicationStatus,
      ];

  OrderState copyWith({
    OrderServiceEntity? getApplicationsResponse,
    DateTime? selectedDate,
    String? selectedDateFormatted,
    ApplicationStatus? applicationStatus,
  }) {
    return OrderState(
      getApplicationsResponse: getApplicationsResponse ?? this.getApplicationsResponse,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedDateFormatted: selectedDateFormatted ?? this.selectedDateFormatted,
      applicationStatus: applicationStatus ?? this.applicationStatus,
    );
  }
}

final class OrderInitial extends OrderState {
  OrderInitial()
      : super(
          getApplicationsResponse: null,
          selectedDate: DateTime.now(),
          selectedDateFormatted: DateFormat('yyyy-MM-dd').format(DateTime.now()),
          applicationStatus: null,
        );
}
