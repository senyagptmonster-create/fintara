import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/envelope_budget_calculator.dart';

class EnvelopeRepository extends ChangeNotifier {
  static const _envKey = 'fintara_envelopes_v2';

  final List<EnvelopeCategory> _envelopes = [];

  List<EnvelopeCategory> get envelopes => List.unmodifiable(_envelopes);
  double get totalAllocated => _envelopes.fold(0.0, (s, e) => s + e.allocated);
  double get totalSpent => _envelopes.fold(0.0, (s, e) => s + e.spent);
  double get totalRemaining => totalAllocated - totalSpent;

  EnvelopeRepository() {
    _loadEnvelopes();
  }

  Future<void> _loadEnvelopes() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_envKey);
    if (raw != null) {
      final List dec = jsonDecode(raw);
      _envelopes.clear();
      _envelopes.addAll(dec.map((e) => EnvelopeCategory.fromJson(e)));
    } else {
      _envelopes.addAll([
        EnvelopeCategory(id: '1', title: 'Groceries & Market', allocated: 450.0, spent: 180.0),
        EnvelopeCategory(id: '2', title: 'Coffee & Bites', allocated: 120.0, spent: 45.0),
        EnvelopeCategory(id: '3', title: 'Transit & Metro', allocated: 160.0, spent: 70.0),
        EnvelopeCategory(id: '4', title: 'Emergency Cash Reserve', allocated: 300.0, spent: 0.0),
      ]);
    }
    notifyListeners();
  }

  void addEnvelope(String title, double allocated) async {
    final env = EnvelopeCategory(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      allocated: allocated,
    );
    _envelopes.add(env);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_envKey, jsonEncode(_envelopes.map((e) => e.toJson()).toList()));
    notifyListeners();
  }

  void logExpense(String id, double amount) async {
    final idx = _envelopes.indexWhere((e) => e.id == id);
    if (idx != -1) {
      _envelopes[idx].spent += amount;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_envKey, jsonEncode(_envelopes.map((e) => e.toJson()).toList()));
      notifyListeners();
    }
  }

  void deleteEnvelope(String id) async {
    _envelopes.removeWhere((e) => e.id == id);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_envKey, jsonEncode(_envelopes.map((e) => e.toJson()).toList()));
    notifyListeners();
  }
}
