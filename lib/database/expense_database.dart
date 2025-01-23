import 'package:expense_tracker/database/boxes.dart';
import 'package:expense_tracker/models/expense_model.dart';

class ExpenseDatabase {
  List<ExpenseModel> expenses = [];

  void loadData() {
    List allDynamicExpenses = boxExpenses.get("EXPENSESLIST") ?? [];
    for (var dynamicExpense in allDynamicExpenses) {
      expenses.add(ExpenseModel(
          name: dynamicExpense[0],
          price: dynamicExpense[1],
          category: dynamicExpense[2],
          date: dynamicExpense[3]));
    }
  }

  void saveData() {
    List<List<dynamic>> allDynamicExpenses = [];
    for (var expense in expenses) {
      allDynamicExpenses
          .add([expense.name, expense.price, expense.category, expense.date]);
    }
    boxExpenses.put("EXPENSESLIST", allDynamicExpenses);
  }
}
