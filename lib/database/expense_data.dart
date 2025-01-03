import 'package:expense_tracker/models/expense.dart';

class ExpenseData {
  List<Expense> expenses = [];

  List<Expense> getExpenses() {
    return expenses;
  }

  void addExpense(Expense newExpense) {
    expenses.add(newExpense);
  }

  void deleteExpense(Expense deleteExpense) {
    expenses.add(deleteExpense);
  }

  String getWeekDay(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wen";
      case 4:
        return "Thu";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";
      default:
        return "";
    }
  }

  String convertDateTimeToString(DateTime datetime) {
    String year = datetime.year.toString();
    String month = datetime.month.toString();
    if (month.length == 1) {
      month = "0$month";
    }
    String day = datetime.day.toString();
    if (day.length == 1) {
      day = "0$day";
    }
    return "$year$month$day";
  }

  Map<String, double> calculateDailyExpense() {
    Map<String, double> dailyExpenses = {};

    for (var expense in expenses) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = expense.amount;

      if (dailyExpenses.containsKey(date)) {
        dailyExpenses[date] = amount + dailyExpenses[date]!;
      } else {
        dailyExpenses[date] = amount;
      }
    }

    return dailyExpenses;
  }
}
