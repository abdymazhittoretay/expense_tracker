import 'package:expense_tracker/models/expense_model.dart';
import 'package:fl_chart/fl_chart.dart';
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
      padding: EdgeInsets.all(16.0),
      height: 360,
      child: PieChart(
        PieChartData(
            sections: spending
                .map(
                  (category, totalPrice) => MapEntry(
                    category,
                    PieChartSectionData(
                        color: selectColor(category),
                        radius: 100.0,
                        title: "\$${totalPrice.toStringAsFixed(2)}",
                        titleStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        value: totalPrice),
                  ),
                )
                .values
                .toList(),
            sectionsSpace: 0),
      ),
    );
  }

  // Functions
  MaterialColor selectColor(String category) {
    switch (category) {
      case "Food":
        return Colors.green;
      case "Personal":
        return Colors.purple;
      case "Entertainment":
        return Colors.red;
      case "Trasnportation":
        return Colors.blue;
      case "Other":
        return Colors.grey;
    }
    return Colors.grey;
  }
}
