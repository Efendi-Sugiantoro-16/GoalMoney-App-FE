// lib/models/report.dart
// Model untuk Laporan Progress Tabungan GoalMoney

class SavingsReport {
  final String reportDate;
  final String reportTitle;
  final ReportPeriod period;
  final ReportSummary summary;
  final List<GoalReport> goals;
  final List<Achievement> achievements;
  final List<SavingsTip> tips;
  final List<MonthlyBreakdown> monthlyBreakdown;

  // Alias for UI compatibility
  List<GoalReport> get goalDetails => goals;

  SavingsReport({
    required this.reportDate,
    required this.reportTitle,
    required this.period,
    required this.summary,
    required this.goals,
    required this.achievements,
    required this.tips,
    required this.monthlyBreakdown,
  });

  factory SavingsReport.fromJson(Map<String, dynamic> json) {
    return SavingsReport(
      reportDate: json['report_date'] ?? '',
      reportTitle: json['report_title'] ?? 'Laporan Progress Tabungan',
      period: ReportPeriod.fromJson(json['period'] ?? {}),
      summary: ReportSummary.fromJson(json['summary'] ?? {}),
      goals:
          (json['goals'] as List<dynamic>?)
              ?.map((g) => GoalReport.fromJson(g))
              .toList() ??
          [],
      achievements:
          (json['achievements'] as List<dynamic>?)
              ?.map((a) => Achievement.fromJson(a))
              .toList() ??
          [],
      tips:
          (json['tips'] as List<dynamic>?)
              ?.map((t) => SavingsTip.fromJson(t))
              .toList() ??
          [],
      monthlyBreakdown:
          (json['monthly_breakdown'] as List<dynamic>?)
              ?.map((m) => MonthlyBreakdown.fromJson(m))
              .toList() ??
          [],
    );
  }
}

class ReportPeriod {
  final String start;
  final String end;

  ReportPeriod({required this.start, required this.end});

  // Aliases for UI compatibility
  String get startDate => start;
  String get endDate => end;

  factory ReportPeriod.fromJson(Map<String, dynamic> json) {
    return ReportPeriod(start: json['start'] ?? '', end: json['end'] ?? '');
  }
}

class ReportSummary {
  final int totalGoals;
  final int completedGoals;
  final int activeGoals;
  final double totalSaved;
  final double totalTarget;
  final double overallProgress;
  final double periodSavings;
  final int totalDeposits;
  final int totalWithdrawals;

  ReportSummary({
    required this.totalGoals,
    required this.completedGoals,
    required this.activeGoals,
    required this.totalSaved,
    required this.totalTarget,
    required this.overallProgress,
    required this.periodSavings,
    required this.totalDeposits,
    required this.totalWithdrawals,
  });

  factory ReportSummary.fromJson(Map<String, dynamic> json) {
    return ReportSummary(
      totalGoals: json['total_goals'] ?? 0,
      completedGoals: json['completed_goals'] ?? 0,
      activeGoals: json['active_goals'] ?? 0,
      totalSaved: (json['total_saved'] as num?)?.toDouble() ?? 0.0,
      totalTarget: (json['total_target'] as num?)?.toDouble() ?? 0.0,
      overallProgress: (json['overall_progress'] as num?)?.toDouble() ?? 0.0,
      periodSavings: (json['period_savings'] as num?)?.toDouble() ?? 0.0,
      totalDeposits: json['total_deposits'] ?? 0,
      totalWithdrawals: json['total_withdrawals'] ?? 0,
    );
  }
}

class GoalReport {
  final int id;
  final String name;
  final String type;
  final double targetAmount;
  final double currentAmount;
  final double remainingAmount;
  final double progressPercentage;
  final String status;
  final String? deadline;
  final int? daysRemaining;
  final int totalDeposits;
  final String? lastDepositDate;
  final String? description;

  GoalReport({
    required this.id,
    required this.name,
    required this.type,
    required this.targetAmount,
    required this.currentAmount,
    required this.remainingAmount,
    required this.progressPercentage,
    required this.status,
    this.deadline,
    this.daysRemaining,
    required this.totalDeposits,
    this.lastDepositDate,
    this.description,
  });

  factory GoalReport.fromJson(Map<String, dynamic> json) {
    return GoalReport(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      type: json['type'] ?? 'digital',
      targetAmount: (json['target_amount'] as num?)?.toDouble() ?? 0.0,
      currentAmount: (json['current_amount'] as num?)?.toDouble() ?? 0.0,
      remainingAmount: (json['remaining_amount'] as num?)?.toDouble() ?? 0.0,
      progressPercentage:
          (json['progress_percentage'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] ?? 'active',
      deadline: json['deadline'],
      daysRemaining: json['days_remaining'],
      totalDeposits: json['total_deposits'] ?? 0,
      lastDepositDate: json['last_deposit_date'],
      description: json['description'],
    );
  }

  bool get isCompleted => status == 'completed';

  // Alias for UI compatibility
  double get progress => progressPercentage;
}

class Achievement {
  final String type;
  final String icon;
  final String title;
  final String description;
  final String? goalName;
  final double? amount;
  final double? progress;
  final double? remaining;
  final String? date;

  Achievement({
    required this.type,
    required this.icon,
    required this.title,
    required this.description,
    this.goalName,
    this.amount,
    this.progress,
    this.remaining,
    this.date,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      type: json['type'] ?? '',
      icon: json['icon'] ?? '🎯',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      goalName: json['goal_name'],
      amount: (json['amount'] as num?)?.toDouble(),
      progress: (json['progress'] as num?)?.toDouble(),
      remaining: (json['remaining'] as num?)?.toDouble(),
      date: json['date'],
    );
  }
}

class SavingsTip {
  final String icon;
  final String tip;
  final String priority;

  SavingsTip({required this.icon, required this.tip, this.priority = 'medium'});

  factory SavingsTip.fromJson(Map<String, dynamic> json) {
    return SavingsTip(
      icon: json['icon'] ?? '💡',
      tip: json['tip'] ?? '',
      priority: json['priority'] ?? 'medium',
    );
  }
}

class MonthlyBreakdown {
  final String month;
  final int monthNumber;
  final int year;
  final double amount;
  final int depositCount;

  MonthlyBreakdown({
    required this.month,
    required this.monthNumber,
    required this.year,
    required this.amount,
    required this.depositCount,
  });

  // Aliases for UI compatibility
  double get totalSaved => amount;
  int get transactionCount => depositCount;

  factory MonthlyBreakdown.fromJson(Map<String, dynamic> json) {
    return MonthlyBreakdown(
      month: json['month'] ?? '',
      monthNumber: json['month_number'] ?? 0,
      year: json['year'] ?? 0,
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      depositCount: json['deposit_count'] ?? 0,
    );
  }
}
