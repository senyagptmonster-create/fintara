import 'package:flutter/material.dart';

class CashEnvelope {
  final String id;
  final String title;
  final double allocated;
  final double spent;
  final Color color;
  final IconData icon;

  const CashEnvelope({
    required this.id,
    required this.title,
    required this.allocated,
    required this.spent,
    required this.color,
    required this.icon,
  });

  double get remaining => (allocated - spent).clamp(0.0, allocated);
  double get fillRatio => allocated == 0 ? 0.0 : (spent / allocated).clamp(0.0, 1.0);

  CashEnvelope copyWithSpent(double additionalSpent) {
    return CashEnvelope(
      id: id,
      title: title,
      allocated: allocated,
      spent: spent + additionalSpent,
      color: color,
      icon: icon,
    );
  }
}

class LedgerTransaction {
  final String id;
  final String title;
  final double amount;
  final String envelopeTitle;
  final DateTime date;

  const LedgerTransaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.envelopeTitle,
    required this.date,
  });
}
