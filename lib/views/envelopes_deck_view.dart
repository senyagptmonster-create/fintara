import 'package:flutter/material.dart';
import '../models/cash_envelope.dart';
import '../painters/envelope_fold_painter.dart';
import '../theme/fintara_theme.dart';

class EnvelopesDeckView extends StatelessWidget {
  final ValueNotifier<List<CashEnvelope>> envelopesNotifier;
  final void Function(String envelopeId, double amount, String desc) onAddExpense;

  const EnvelopesDeckView({
    super.key,
    required this.envelopesNotifier,
    required this.onAddExpense,
  });

  void _showExpenseDialog(BuildContext context, CashEnvelope envelope) {
    final amountCtrl = TextEditingController();
    final noteCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: FintaraTheme.surface,
        title: Text('Log Expense: ${envelope.title}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amountCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Amount (USD)', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: noteCtrl,
              decoration: const InputDecoration(labelText: 'Description (e.g. Trader Joes)', border: OutlineInputBorder()),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: envelope.color),
            onPressed: () {
              final amt = double.tryParse(amountCtrl.text) ?? 0.0;
              if (amt > 0) {
                final desc = noteCtrl.text.trim().isEmpty ? 'Direct Debit' : noteCtrl.text.trim();
                onAddExpense(envelope.id, amt, desc);
                Navigator.pop(ctx);
              }
            },
            child: const Text('Debit Envelope', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<CashEnvelope>>(
      valueListenable: envelopesNotifier,
      builder: (context, list, _) {
        final totalAllocated = list.fold<double>(0.0, (sum, e) => sum + e.allocated);
        final totalSpent = list.fold<double>(0.0, (sum, e) => sum + e.spent);
        final totalLeft = totalAllocated - totalSpent;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Summary Banner
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: FintaraTheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: FintaraTheme.emerald.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Total Left To Spend', style: TextStyle(color: FintaraTheme.textSecondary, fontSize: 12)),
                        const SizedBox(height: 4),
                        Text(
                          'USD ${totalLeft.toStringAsFixed(0)}',
                          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: FintaraTheme.emerald),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Allocated: USD ${totalAllocated.toStringAsFixed(0)}', style: const TextStyle(color: FintaraTheme.textSecondary, fontSize: 12)),
                        Text('Spent: USD ${totalSpent.toStringAsFixed(0)}', style: const TextStyle(color: FintaraTheme.rose, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                'ZERO-BASED CASH ENVELOPES',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: FintaraTheme.textSecondary),
              ),
              const SizedBox(height: 12),

              // Grid of Envelopes
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.95,
                ),
                itemCount: list.length,
                itemBuilder: (ctx, i) {
                  final env = list[i];
                  return InkWell(
                    onTap: () => _showExpenseDialog(context, env),
                    borderRadius: BorderRadius.circular(16),
                    child: CustomPaint(
                      painter: EnvelopeFoldPainter(
                        fillRatio: env.fillRatio,
                        envelopeColor: env.color,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(env.icon, color: env.color, size: 24),
                                Text(
                                  '${(env.fillRatio * 100).toStringAsFixed(0)}%',
                                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: env.color),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  env.title,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: FintaraTheme.textPrimary),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'USD ${env.remaining.toStringAsFixed(0)} left',
                                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: FintaraTheme.textPrimary),
                                ),
                                Text(
                                  'of USD ${env.allocated.toStringAsFixed(0)}',
                                  style: const TextStyle(fontSize: 11, color: FintaraTheme.textSecondary),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
