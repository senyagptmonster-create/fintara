import 'package:flutter/material.dart';
import '../fintara_theme.dart';

class CashFlowPage extends StatelessWidget {
  const CashFlowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cash Inflow Schedule')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: FintaraTheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: FintaraTheme.edge),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Payday Stash Allocations', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 8),
                Text(
                  'Distribute paper bills into physical or digital envelope compartments immediately upon deposit to freeze discretionary overflow.',
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
