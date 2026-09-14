import '../app/brand.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app/theme.dart';
import 'fintara_store.dart';

class FintaraHome extends StatefulWidget {
  const FintaraHome({super.key});

  @override
  State<FintaraHome> createState() => _FintaraHomeState();
}

class _FintaraHomeState extends State<FintaraHome> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const EnvelopesScreen(),
    const TransactionScreen(),
    const GoalsScreen(),
    const AnalyticsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FintaraStore>().loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBg,
      appBar: AppBar(
        title: Text('Fintara', style: AppTheme.display(cInk)),
        backgroundColor: cSurface,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: cSurface,
        selectedItemColor: cAccent,
        unselectedItemColor: cEdge,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'Envelopes'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: 'Transactions'),
          BottomNavigationBarItem(icon: Icon(Icons.flag), label: 'Goals'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Analytics'),
        ],
      ),
    );
  }
}

class EnvelopesScreen extends StatelessWidget {
  const EnvelopesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<FintaraStore>();
    return ListView.builder(
      itemCount: store.envelopes.length,
      itemBuilder: (context, index) {
        final env = store.envelopes[index];
        return Card(
          color: cSurface,
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(env['name'], style: AppTheme.text(cInk)),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: env['spent'] / env['total'],
                  backgroundColor: cEdge,
                  color: cAccent,
                ),
                const SizedBox(height: 8),
                Text('\$${env['spent']} / \$${env['total']}', style: AppTheme.text(cInk)),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: cAccent),
        onPressed: () {
          context.read<FintaraStore>().addExpense('Groceries', 50.0);
        },
        child: const Text('Add \$50 Expense'),
      ),
    );
  }
}

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.savings, size: 64, color: cAccent2),
          const SizedBox(height: 16),
          Text('Emergency Fund: \$1000', style: AppTheme.display(cInk)),
        ],
      ),
    );
  }
}

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Budget Analytics', style: AppTheme.display(cInk)),
    );
  }
}
