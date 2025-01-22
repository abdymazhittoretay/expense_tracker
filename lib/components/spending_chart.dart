import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';

class SpendingChart extends StatelessWidget {
  final List<ExpenseModel> expenses;

  const SpendingChart({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    final spending = <String, double>{};

    for (ExpenseModel expense in expenses) {
      spending.update(expense.category, (value) => value + expense.price,
          ifAbsent: () => expense.price);
    }
    return Container(
      padding: EdgeInsets.all(10.0),
      height: 360,
    );
  }
}
