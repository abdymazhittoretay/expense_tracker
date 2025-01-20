import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<ExpenseModel> expenses = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Budget Tracker"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          final ExpenseModel expense = expenses[index];
          return ListTile(
            title: Text(expense.name),
          );
        },
      ),
    );
  }
}
