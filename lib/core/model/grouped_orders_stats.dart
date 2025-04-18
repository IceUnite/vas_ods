class GroupedOrderStats {
  final String date;
  final int readyCount;
  final int inWorkCount;
  final int cancelledCount;
  final int errorCount;
  final int completedCount;

  GroupedOrderStats({
    required this.date,
    required this.readyCount,
    required this.inWorkCount,
    required this.cancelledCount,
    required this.errorCount,
    required this.completedCount,
  });

  @override
  String toString() {
    return 'GroupedOrderStats(date: $date, ready: $readyCount, in work: $inWorkCount, cancelled: $cancelledCount, error: $errorCount, completed: $completedCount)';
  }
}