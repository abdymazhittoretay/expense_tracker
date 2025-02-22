import 'package:expense_tracker/database/boxes.dart';
import 'package:expense_tracker/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();

  boxExpenses = await Hive.openBox("boxExpense");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.blue,
          selectionColor: Colors.blue[100],
          selectionHandleColor: Colors.blue,
        ),
      ),
      home: HomePage(),
    );
  }
}
