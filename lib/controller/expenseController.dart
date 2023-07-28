import 'package:get/get.dart';

import '../view/screens/GroupBarPage.dart';
import '../view/screens/HomeScreen.dart';

class ExpenseController extends GetxController implements GetxService {
  final List<Expense> _expenseList = [];

  List<Expense> get expenseList => _expenseList;
  List<double> _myAllTotalData = [];

  List<double> get myAllTotalData => _myAllTotalData;

  Future<void> addExpenseData(String title, int amount, String category) async {
    _expenseList.add(Expense(
        title: title,
        amount: int.parse(amount.toString()),
        category: category));
    update();
  }

  Future<void> calculateTotalAmounts() async {
    _myAllTotalData = [];
    Map<String, double> categoryTotalAmounts = {};

    for (String category in categories) {
      categoryTotalAmounts[category] = 0;
    }

    for (Expense expense in Get.find<ExpenseController>().expenseList) {
      String category = expense.category;
      if (categoryTotalAmounts.containsKey(category)) {
        categoryTotalAmounts[category] =
            (categoryTotalAmounts[category] ?? 0) + expense.amount;
      }
    }
    for (String category in categories) {
      _myAllTotalData.add(categoryTotalAmounts[category] ?? 0);
      update();
    }
    update();
  }
}
