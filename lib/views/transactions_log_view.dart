import 'package:flutter/material.dart';
import '../models/cash_envelope.dart';
import '../theme/fintara_theme.dart';

class TransactionsLogView extends StatelessWidget {
  final ValueNotifier<List<LedgerTransaction>> txNotifier;

  const TransactionsLogView({super.key, required this.txNotifier});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<LedgerTransaction>>(
      valueListenable: txNotifier,
      builder: (context, txs, _) {
        if (txs.isEmpty) {
          return const Center(
            child: Text('No transactions recorded yet', style: TextStyle(color: FintaraTheme.textSecondary)),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(18),
          itemCount: txs.length,
          separatorBuilder: (context, _) => const SizedBox(height: 10),
          itemBuilder: (ctx, i) {
            final t = txs[i];
            return Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: FintaraTheme.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: FintaraTheme.rose.withValues(alpha: 0.15),
                    child: const Icon(Icons.arrow_upward_rounded, color: FintaraTheme.rose, size: 20),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(t.title, style: const TextStyle(fontWeight: FontWeight.bold, color: FintaraTheme.textPrimary)),
                        Text(t.envelopeTitle, style: const TextStyle(fontSize: 12, color: FintaraTheme.textSecondary)),
                      ],
                    ),
                  ),
                  Text(
                    '-USD ${t.amount.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: FintaraTheme.rose),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
