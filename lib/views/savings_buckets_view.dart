import 'package:flutter/material.dart';
import '../theme/fintara_theme.dart';

class SavingsBucketsView extends StatelessWidget {
  const SavingsBucketsView({super.key});

  @override
  Widget build(BuildContext context) {
    final buckets = [
      {'name': 'Emergency Buffer', 'saved': 3800.0, 'target': 5000.0, 'date': 'Dec 2026'},
      {'name': 'Alpine Vacation', 'saved': 1200.0, 'target': 2500.0, 'date': 'Aug 2026'},
      {'name': 'Tech Upgrade Fund', 'saved': 950.0, 'target': 1800.0, 'date': 'Nov 2026'},
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(18),
      itemCount: buckets.length,
      separatorBuilder: (context, _) => const SizedBox(height: 12),
      itemBuilder: (ctx, i) {
        final b = buckets[i];
        final saved = b['saved'] as double;
        final target = b['target'] as double;
        final progress = (saved / target).clamp(0.0, 1.0);

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: FintaraTheme.surface,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(b['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: FintaraTheme.textPrimary)),
                  Text(b['date'] as String, style: const TextStyle(fontSize: 12, color: FintaraTheme.textSecondary)),
                ],
              ),
              const SizedBox(height: 10),
              LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: Colors.white10,
                valueColor: const AlwaysStoppedAnimation<Color>(FintaraTheme.emerald),
                borderRadius: BorderRadius.circular(4),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('USD ${saved.toStringAsFixed(0)} saved', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: FintaraTheme.emerald)),
                  Text('Target: USD ${target.toStringAsFixed(0)}', style: const TextStyle(fontSize: 12, color: FintaraTheme.textSecondary)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
