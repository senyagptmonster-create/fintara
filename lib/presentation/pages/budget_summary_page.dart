import 'package:flutter/material.dart';
import '../fintara_theme.dart';

class BudgetSummaryPage extends StatelessWidget {
  const BudgetSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Envelope Rulebook')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: FintaraTheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: FintaraTheme.edge),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('The Zero-Sum Rule', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 8),
                Text(
                  'Every dollar is assigned to an envelope prior to spending. If an envelope runs empty, you must consciously transfer funds from another envelope before making purchases.',
                  style: TextStyle(fontSize: 13, color: FintaraTheme.inkMuted, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
