part of 'order_cubit.dart';

@immutable
class OrderCubitState {
  List<List<OrderServiceItem>> groupedApplicationList;
  DateTime selectedDate;
  String selectedDateFormatted;
  List<GroupedOrderStats> groupedStats;

  OrderCubitState({
    required this.groupedApplicationList,
    required this.selectedDate,
    required this.selectedDateFormatted,
    required this.groupedStats,
  });
}
