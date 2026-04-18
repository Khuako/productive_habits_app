import 'package:equatable/equatable.dart';

class DailyProgress extends Equatable {
  const DailyProgress({
    required this.date,
    required this.plannedCount,
    required this.completedCount,
  });

  final DateTime date;
  final int plannedCount;
  final int completedCount;

  double get completionRate {
    if (plannedCount == 0) {
      return 0;
    }
    return completedCount / plannedCount;
  }

  @override
  List<Object?> get props => [date, plannedCount, completedCount];
}
