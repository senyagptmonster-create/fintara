import 'package:flutter/material.dart';
import '../fintara_theme.dart';

class SavingsGoalsPage extends StatelessWidget {
  const SavingsGoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final goals = [
      {'name': 'Emergency Buffer', 'target': 1000.0, 'current': 650.0},
      {'name': 'Holiday Travel Fund', 'target': 800.0, 'current': 320.0},
      {'name': 'Annual Insurance Stash', 'target': 600.0, 'current': 500.0},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Savings Vaults')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: goals.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, idx) {
          final g = goals[idx];
          final cur = g['current'] as double;
          final tar = g['target'] as double;
          final ratio = cur / tar;
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: FintaraTheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: FintaraTheme.edge),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(g['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text('\$ \${cur.toStringAsFixed(0)} / \$ \${tar.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, color: FintaraTheme.accent)),
                  ],
                ),
                const SizedBox(height: 10),
                LinearProgressIndicator(value: ratio, color: FintaraTheme.accent, backgroundColor: FintaraTheme.edge, minHeight: 8),
              ],
            ),
          );
        },
      ),
    );
  }
}
