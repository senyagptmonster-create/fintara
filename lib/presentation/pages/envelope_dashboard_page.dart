import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/envelope_repository.dart';
import '../fintara_theme.dart';

class EnvelopeDashboardPage extends StatelessWidget {
  const EnvelopeDashboardPage({super.key});

  void _showAddDialog(BuildContext context) {
    final titleCtrl = TextEditingController();
    final amountCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: FintaraTheme.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 20, right: 20, top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Create Cash Envelope', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 12),
            TextField(controller: titleCtrl, decoration: const InputDecoration(hintText: 'Category Name', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: amountCtrl, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(hintText: 'Allocated Budget (USD)', border: OutlineInputBorder())),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: FintaraTheme.accent, foregroundColor: Colors.white),
                onPressed: () {
                  final amt = double.tryParse(amountCtrl.text.trim()) ?? 0.0;
                  if (titleCtrl.text.trim().isNotEmpty && amt > 0) {
                    context.read<EnvelopeRepository>().addEnvelope(titleCtrl.text.trim(), amt);
                    Navigator.pop(ctx);
                  }
                },
                child: const Text('Save Envelope'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogSpend(BuildContext context, String id, String title) {
    final spendCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: FintaraTheme.surface,
        title: Text('Log Spend: $title'),
        content: TextField(
          controller: spendCtrl,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(hintText: 'Amount (USD)', border: OutlineInputBorder()),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: FintaraTheme.accent, foregroundColor: Colors.white),
            onPressed: () {
              final amt = double.tryParse(spendCtrl.text.trim()) ?? 0.0;
              if (amt > 0) {
                context.read<EnvelopeRepository>().logExpense(id, amt);
                Navigator.pop(ctx);
              }
            },
            child: const Text('Spend'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<EnvelopeRepository>();

    return Scaffold(
      appBar: AppBar(title: const Text('Cash Envelopes')),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: FintaraTheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: FintaraTheme.edge),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text('Total Budget', style: TextStyle(fontSize: 12, color: FintaraTheme.inkMuted)),
                      const SizedBox(height: 4),
                      Text('\$ \${repo.totalAllocated.toStringAsFixed(0)}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: FintaraTheme.ink)),
                    ],
                  ),
                ),
                Container(height: 36, width: 1, color: FintaraTheme.edge),
                Expanded(
                  child: Column(
                    children: [
                      const Text('Remaining', style: TextStyle(fontSize: 12, color: FintaraTheme.inkMuted)),
                      const SizedBox(height: 4),
                      Text('\$ \${repo.totalRemaining.toStringAsFixed(0)}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: FintaraTheme.accent)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: repo.envelopes.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, idx) {
                final env = repo.envelopes[idx];
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
                          Expanded(
                            child: Text(env.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.add_shopping_cart, size: 20, color: FintaraTheme.accent),
                                onPressed: () => _showLogSpend(context, env.id, env.title),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline, size: 20, color: FintaraTheme.inkMuted),
                                onPressed: () => repo.deleteEnvelope(env.id),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: env.percentageUsed,
                        color: env.percentageUsed > 0.9 ? Colors.redAccent : FintaraTheme.accent,
                        backgroundColor: FintaraTheme.edge,
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Spent: \$ \${env.spent.toStringAsFixed(0)}', style: const TextStyle(fontSize: 12, color: FintaraTheme.inkMuted)),
                          Text('Remaining: \$ \${env.remaining.toStringAsFixed(0)}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: FintaraTheme.ink)),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: FintaraTheme.accent,
        foregroundColor: Colors.white,
        onPressed: () => _showAddDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('Envelope'),
      ),
    );
  }
}
