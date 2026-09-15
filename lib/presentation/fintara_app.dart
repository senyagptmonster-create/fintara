import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/envelope_repository.dart';
import 'fintara_theme.dart';
import 'pages/envelope_dashboard_page.dart';
import 'pages/cash_flow_page.dart';
import 'pages/savings_goals_page.dart';
import 'pages/budget_summary_page.dart';

class FintaraApp extends StatelessWidget {
  const FintaraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EnvelopeRepository(),
      child: MaterialApp(
        title: 'Fintara Coin Ledger',
        debugShowCheckedModeBanner: false,
        theme: FintaraTheme.theme,
        home: const _FintaraShell(),
      ),
    );
  }
}

class _FintaraShell extends StatelessWidget {
  const _FintaraShell();

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 4,
      child: Scaffold(
        body: TabBarView(
          children: [
            EnvelopeDashboardPage(),
            CashFlowPage(),
            SavingsGoalsPage(),
            BudgetSummaryPage(),
          ],
        ),
        bottomNavigationBar: Material(
          color: FintaraTheme.surface,
          child: TabBar(
            labelColor: FintaraTheme.accent,
            indicatorColor: FintaraTheme.accent,
            tabs: [
              Tab(icon: Icon(Icons.account_balance_wallet_outlined), text: 'Envelopes'),
              Tab(icon: Icon(Icons.trending_up), text: 'Flow'),
              Tab(icon: Icon(Icons.savings_outlined), text: 'Vaults'),
              Tab(icon: Icon(Icons.menu_book), text: 'Rules'),
            ],
          ),
        ),
      ),
    );
  }
}
