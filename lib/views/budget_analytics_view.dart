import 'package:flutter/material.dart';
import '../theme/fintara_theme.dart';

class BudgetAnalyticsView extends StatelessWidget {
  const BudgetAnalyticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'MONTHLY VELOCITY ALLOCATION',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: FintaraTheme.textSecondary),
          ),
          const SizedBox(height: 14),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: FintaraTheme.surface,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Zero-Sum Compliance', style: TextStyle(color: FintaraTheme.textSecondary)),
                    Text('100% Balanced', style: TextStyle(fontWeight: FontWeight.bold, color: FintaraTheme.emerald)),
                  ],
                ),
                Divider(color: Colors.white12, height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Savings Rate', style: TextStyle(color: FintaraTheme.textSecondary)),
                    Text('24.5%', style: TextStyle(fontWeight: FontWeight.bold, color: FintaraTheme.cyan)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: FintaraTheme.surface,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Text(
              'Zero-Based Rule: Every dollar of income is assigned to an envelope or savings bucket before the month begins. When an envelope reaches zero, spending halts in that category.',
              style: TextStyle(fontSize: 13, color: FintaraTheme.textSecondary, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
