part of 'order_bloc.dart';

@immutable
class OrderState extends Equatable {
  OrderState({
    this.getApplicationsResponse,
  });

  final OrderServiceEntity? getApplicationsResponse;

  List<Object?> get props => <Object?>[
        getApplicationsResponse,
      ];

  OrderState copyWith({
    OrderServiceEntity? getApplicationsResponse,
  }) {
    return OrderState(
      getApplicationsResponse: getApplicationsResponse ?? this.getApplicationsResponse,
    );
  }
}

final class OrderInitial extends OrderState {
  OrderInitial()
      : super(
          getApplicationsResponse: null,
        );
}
