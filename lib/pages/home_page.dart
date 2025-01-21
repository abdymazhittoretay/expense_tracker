import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<ExpenseModel> expenses = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
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
            title: Text(
              expense.name,
              style: TextStyle(fontSize: 16.0),
            ),
            subtitle: Text(
              "${expense.category}, ${expense.date.day.toString().padLeft(2, "0")}.${expense.date.month.toString().padLeft(2, "0")}.${expense.date.year}",
              style: TextStyle(color: Colors.grey, fontSize: 16.0),
            ),
            trailing: Text(
              "-\$${expense.price}",
              style: TextStyle(fontSize: 16.0),
            ),
          );
        },
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
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                  TextField(
                    controller: _priceController,
                    decoration: InputDecoration(
                        hintText: "Price",
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  ),
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
                    _nameController.clear();
                    _priceController.clear();
                    setState(() {});
                    Navigator.of(context).pop();
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
                    if (_nameController.text.isNotEmpty &&
                        _priceController.text.isNotEmpty &&
                        double.tryParse(_priceController.text) != null) {
                      expenses.add(ExpenseModel(
                          name: _nameController.text,
                          price: double.tryParse(_priceController.text) ?? 0.0,
                          category: "Other",
                          date: DateTime.now()));
                    }
                    _nameController.clear();
                    _priceController.clear();
                    setState(() {});
                    Navigator.of(context).pop();
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
}
