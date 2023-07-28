import 'package:expense_tracker/controller/expenseController.dart';
import 'package:expense_tracker/view/screens/AddExpenseScreen.dart';
import 'package:expense_tracker/view/screens/GroupBarPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _buildExpenseList(Size size) {
    List expenseList = Get.find<ExpenseController>().expenseList;
    return expenseList.isNotEmpty
        ? ListView.builder(
            itemCount: expenseList.length,
            itemBuilder: (BuildContext context, int index) {
              // return
              return Container(
                height: size.height * 0.08,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white30),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(15.0))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              expenseList[index].title,
                              style: const TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: size.height * 0.001,
                            ),
                            Text(expenseList[index].category,
                                style: const TextStyle(color: Colors.white38)),
                          ],
                        ),
                        Text(
                            '₹ ${expenseList[index].amount.toStringAsFixed(2)}',
                            style: const TextStyle(color: Colors.white)),
                      ]),
                ),
              );
            },
          )
        : const Center(
            child: Text(
              'No Data Found',
              style: TextStyle(color: Colors.white),
            ),
          );
  }

  @override
  void initState() {
    Get.find<ExpenseController>().calculateTotalAmounts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: size.height * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Expense Tracker',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () => setState(() {
                        }),
                        child: const Icon(
                          Icons.refresh,
                          size: 22.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.white30,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                const Expanded(
                  flex: 3,
                  child: ChartBarPage(),
                ),
                const Divider(
                  color: Colors.white30,
                ),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Text(
                    'My Expenses',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: _buildExpenseList(size),
                ),
                SizedBox(
                  height: size.height * 0.02,
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF8043F9),
          onPressed: () {
            Get.to(() => const AddExpenseScreen())!.then((value) {
              Get.find<ExpenseController>().calculateTotalAmounts();
              setState(() {
              });
            });
          },
          child: const Text('FAB'),
        ),
      ),
    );
  }
}

class Expense {
  final String title;
  final int amount;
  final String category;

  Expense({required this.title, required this.amount, required this.category});
}

