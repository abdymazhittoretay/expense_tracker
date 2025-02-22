import 'package:expense_tracker/components/spending_chart.dart';
import 'package:expense_tracker/database/expense_database.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ExpenseDatabase db = ExpenseDatabase();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  String selectedCategory = "Other";

  @override
  void initState() {
    db.loadData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.white,
        title: Text("Budget Tracker"),
        centerTitle: true,
      ),
      body: db.expenses.isNotEmpty
          ? Column(
              children: [
                SpendingChart(expenses: db.expenses),
                Expanded(
                  child: ListView.builder(
                    itemCount: db.expenses.length,
                    itemBuilder: (context, index) {
                      final ExpenseModel expense = db.expenses[index];
                      return Slidable(
                        endActionPane:
                            ActionPane(motion: ScrollMotion(), children: [
                          CustomSlidableAction(
                            backgroundColor: Colors.red,
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            onPressed: (context) {
                              setState(() {
                                db.expenses.removeAt(index);
                              });
                              db.saveData();
                            },
                          ),
                        ]),
                        child: ListTile(
                          title: Text(
                            expense.name,
                            style: TextStyle(fontSize: 16.0),
                          ),
                          subtitle: Text(
                            "${expense.category}, ${expense.date.day.toString().padLeft(2, "0")}.${expense.date.month.toString().padLeft(2, "0")}.${expense.date.year}",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 16.0),
                          ),
                          trailing: Text(
                            "-\$${expense.price}",
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          : Center(
              child: Text(
                "There are no expenses yet.",
                style: TextStyle(color: Colors.grey, fontSize: 16.0),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        shape: CircleBorder(),
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              shape: LinearBorder(),
              title: Text(
                'Add Expense:',
                style: TextStyle(fontSize: 20.0),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                        hintText: "Expense name",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                  TextField(
                    controller: _priceController,
                    decoration: InputDecoration(
                        hintText: "Price",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                  DropdownButtonFormField(
                      dropdownColor: Colors.white,
                      value: selectedCategory,
                      decoration: InputDecoration(
                        label: Text("Choose category"),
                        labelStyle: TextStyle(color: Colors.blue),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                      ),
                      items: [
                        DropdownMenuItem(value: "Food", child: Text("Food")),
                        DropdownMenuItem(
                            value: "Personal", child: Text("Personal")),
                        DropdownMenuItem(
                            value: "Entertainment",
                            child: Text("Entertainment")),
                        DropdownMenuItem(
                            value: "Transportation",
                            child: Text("Transportation")),
                        DropdownMenuItem(value: "Other", child: Text("Other")),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value as String;
                        });
                      }),
                ],
              ),
              actions: [
                TextButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                  onPressed: () {
                    cancelDialog();
                  },
                ),
                TextButton(
                  child: Text(
                    'Add',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                  onPressed: () {
                    addExpense();
                  },
                ),
              ],
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30.0,
        ),
      ),
    );
  }

  // Functions
  void addExpense() {
    if (_nameController.text.isNotEmpty &&
        _priceController.text.isNotEmpty &&
        double.tryParse(_priceController.text) != null) {
      db.expenses.insert(
          0,
          ExpenseModel(
              name: _nameController.text,
              price: double.tryParse(_priceController.text) ?? 0.0,
              category: selectedCategory,
              date: DateTime.now()));
      db.saveData();
    }
    _nameController.clear();
    _priceController.clear();
    selectedCategory = "Other";
    setState(() {});
    Navigator.of(context).pop();
  }

  void cancelDialog() {
    _nameController.clear();
    _priceController.clear();
    selectedCategory = "Other";
    setState(() {});
    Navigator.of(context).pop();
  }
}
