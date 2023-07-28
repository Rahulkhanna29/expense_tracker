import 'package:expense_tracker/view/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/expenseController.dart';

void main() {
  Get.lazyPut(() => ExpenseController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
