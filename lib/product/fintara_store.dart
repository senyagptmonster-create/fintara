import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class FintaraStore extends ChangeNotifier {
  List<dynamic> envelopes = [];

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final dataStr = prefs.getString('fin_envelopes');
    if (dataStr != null) {
      envelopes = jsonDecode(dataStr);
    } else {
      try {
        final jsonStr = await rootBundle.loadString('packages/fintara/content.json');
        final data = jsonDecode(jsonStr);
        envelopes = data['envelopes'];
      } catch (e) {
        // Fallback
        envelopes = [];
      }
    }
    notifyListeners();
  }

  Future<void> addExpense(String name, double amount) async {
    if (envelopes.isNotEmpty) {
      envelopes[0]['spent'] += amount;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fin_envelopes', jsonEncode(envelopes));
    notifyListeners();
  }
}
