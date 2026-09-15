class EnvelopeCategory {
  final String id;
  final String title;
  final double allocated;
  double spent;

  EnvelopeCategory({
    required this.id,
    required this.title,
    required this.allocated,
    this.spent = 0.0,
  });

  double get remaining => allocated - spent;
  double get percentageUsed => allocated > 0 ? (spent / allocated).clamp(0.0, 1.0) : 0.0;

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'allocated': allocated,
    'spent': spent,
  };

  factory EnvelopeCategory.fromJson(Map<String, dynamic> m) => EnvelopeCategory(
    id: m['id'] as String,
    title: m['title'] as String,
    allocated: (m['allocated'] as num).toDouble(),
    spent: (m['spent'] as num).toDouble(),
  );
}
