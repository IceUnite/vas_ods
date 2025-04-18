part of 'order_bloc.dart';

@immutable
class OrderState extends Equatable {
  OrderState({
    this.getApplicationsResponse,
    this.selectedDate,
    this.selectedDateFormatted,
    this.applicationStatus,
    this.applicationCount,
    this.applicationInWorkCount,
  });

  final OrderServiceEntity? getApplicationsResponse;
  final DateTime? selectedDate;
  final String? selectedDateFormatted;
  final ApplicationStatus? applicationStatus;
  final int? applicationCount;
  final int? applicationInWorkCount;

  List<Object?> get props => <Object?>[
        getApplicationsResponse,
        selectedDate,
        selectedDateFormatted,
        applicationStatus,
        applicationCount,
        applicationInWorkCount,
      ];

  OrderState copyWith({
    OrderServiceEntity? getApplicationsResponse,
    DateTime? selectedDate,
    String? selectedDateFormatted,
    ApplicationStatus? applicationStatus,
    int? applicationCount,
    int? applicationInWorkCount,
  }) {
    return OrderState(
      getApplicationsResponse: getApplicationsResponse ?? this.getApplicationsResponse,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedDateFormatted: selectedDateFormatted ?? this.selectedDateFormatted,
      applicationStatus: applicationStatus ?? this.applicationStatus,
      applicationCount: applicationCount ?? this.applicationCount,
      applicationInWorkCount: applicationInWorkCount ?? this.applicationInWorkCount,
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
          applicationCount: 0,
          applicationInWorkCount: 0,
        );
}
