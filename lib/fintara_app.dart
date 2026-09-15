import 'package:flutter/material.dart';
import 'models/cash_envelope.dart';
import 'theme/fintara_theme.dart';
import 'views/budget_analytics_view.dart';
import 'views/envelopes_deck_view.dart';
import 'views/savings_buckets_view.dart';
import 'views/transactions_log_view.dart';

class FintaraApp extends StatefulWidget {
  const FintaraApp({super.key});

  @override
  State<FintaraApp> createState() => _FintaraAppState();
}

class _FintaraAppState extends State<FintaraApp> {
  final PageController _pageCtrl = PageController();
  int _currentPage = 0;

  final ValueNotifier<List<CashEnvelope>> _envelopesNotifier = ValueNotifier<List<CashEnvelope>>([
    const CashEnvelope(id: '1', title: 'Groceries', allocated: 600, spent: 380, color: Color(0xFF10B981), icon: Icons.shopping_basket_rounded),
    const CashEnvelope(id: '2', title: 'Dining Out', allocated: 250, spent: 190, color: Color(0xFFF59E0B), icon: Icons.restaurant_rounded),
    const CashEnvelope(id: '3', title: 'Fuel & Transit', allocated: 180, spent: 75, color: Color(0xFF06B6D4), icon: Icons.local_gas_station_rounded),
    const CashEnvelope(id: '4', title: 'Home & Utilities', allocated: 400, spent: 310, color: Color(0xFF8B5CF6), icon: Icons.bolt_rounded),
    const CashEnvelope(id: '5', title: 'Entertainment', allocated: 150, spent: 45, color: Color(0xFFEC4899), icon: Icons.movie_rounded),
    const CashEnvelope(id: '6', title: 'Health & Wellness', allocated: 200, spent: 60, color: Color(0xFF3B82F6), icon: Icons.fitness_center_rounded),
  ]);

  final ValueNotifier<List<LedgerTransaction>> _txNotifier = ValueNotifier<List<LedgerTransaction>>([
    LedgerTransaction(id: '1', title: 'Whole Foods Market', amount: 82.50, envelopeTitle: 'Groceries', date: DateTime.now().subtract(const Duration(hours: 4))),
    LedgerTransaction(id: '2', title: 'Artisan Espresso Cafe', amount: 14.20, envelopeTitle: 'Dining Out', date: DateTime.now().subtract(const Duration(hours: 9))),
    LedgerTransaction(id: '3', title: 'Metro Transit Card', amount: 35.00, envelopeTitle: 'Fuel & Transit', date: DateTime.now().subtract(const Duration(days: 1))),
  ]);

  @override
  void dispose() {
    _pageCtrl.dispose();
    _envelopesNotifier.dispose();
    _txNotifier.dispose();
    super.dispose();
  }

  void _addExpense(String envelopeId, double amount, String desc) {
    final list = _envelopesNotifier.value;
    final updatedList = list.map((e) {
      if (e.id == envelopeId) {
        return e.copyWithSpent(amount);
      }
      return e;
    }).toList();
    _envelopesNotifier.value = updatedList;

    final targetEnv = list.firstWhere((e) => e.id == envelopeId);
    final newTx = LedgerTransaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: desc,
      amount: amount,
      envelopeTitle: targetEnv.title,
      date: DateTime.now(),
    );
    _txNotifier.value = [newTx, ..._txNotifier.value];
  }

  final List<String> _pageTitles = const [
    'Envelopes Deck',
    'Ledger Activity',
    'Savings Buckets',
    'Spending Velocity',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fintara Cash Envelopes',
      debugShowCheckedModeBanner: false,
      theme: FintaraTheme.themeData,
      home: Scaffold(
        appBar: AppBar(
          title: Text(_pageTitles[_currentPage]),
        ),
        body: Column(
          children: [
            // PageView Carousel Deck
            Expanded(
              child: PageView(
                controller: _pageCtrl,
                onPageChanged: (idx) => setState(() => _currentPage = idx),
                children: [
                  EnvelopesDeckView(envelopesNotifier: _envelopesNotifier, onAddExpense: _addExpense),
                  TransactionsLogView(txNotifier: _txNotifier),
                  const SavingsBucketsView(),
                  const BudgetAnalyticsView(),
                ],
              ),
            ),

            // Dot Carousel Indicator
            Padding(
              padding: const EdgeInsets.only(bottom: 16, top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  final isSelected = index == _currentPage;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isSelected ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isSelected ? FintaraTheme.emerald : Colors.white24,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
