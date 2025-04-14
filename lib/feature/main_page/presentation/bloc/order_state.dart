part of 'order_bloc.dart';

@immutable
class OrderState extends Equatable {
  OrderState({
    this.cellResponse,
  });

  final int? cellResponse;


  List<Object?> get props => <Object?>[
        cellResponse,
      ];

  OrderState copyWith({
    int? cellResponse,

  }) {
    return OrderState(
      cellResponse: cellResponse ?? this.cellResponse,
    );
  }
}

final class OrderInitial extends OrderState {
  OrderInitial()
      : super(
          cellResponse: null,
        );
}

