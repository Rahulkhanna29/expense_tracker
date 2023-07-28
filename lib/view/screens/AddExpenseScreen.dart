import 'package:expense_tracker/controller/expenseController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../base/custom_textFormField.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  String? _selectedCategory;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> _categories = [
    'Food',
    'Transportation',
    'Utilities',
    'Rent',
    'Health',
    'Clothing'
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: size.height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.arrow_back,
                          size: 22.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    const Text(
                      'Add Expense',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: _titleController,
                      hintText: 'Title',
                      validator: (value) =>
                          value.isEmpty ? 'Title is required ' : null,
                      onChanged: (value) {
                        setState(() {
                        });
                      },
                      inputType: TextInputType.text,
                    ),
                    const SizedBox(height: 16.0),
                    CustomTextFormField(
                      controller: _amountController,
                      hintText: 'Amount',
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Amount is required';
                        } else {
                          int? amount = int.tryParse(value);
                          if (amount == null) {
                            return 'Invalid input';
                          } else if (amount <= 600) {
                            return null;
                          } else {
                            return 'Amount should be equal or less than 600';
                          }
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                        });
                      },
                      inputType: TextInputType.number,
                    ),
                    const SizedBox(height: 16.0),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white54,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonFormField(
                        value: _selectedCategory,
                        dropdownColor: const Color(0xFF8043F9),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategory = newValue;
                          });
                        },
                        items: _categories.map((category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(
                              category,
                              style:
                                  const TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          hintText: 'Categories',
                          contentPadding: EdgeInsets.only(left: 10.0),
                          hintStyle:
                              TextStyle(color: Colors.white54, fontSize: 12),
                          iconColor: Colors.white54,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32.0),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 30.0),
          child: Container(
            decoration: const BoxDecoration(
                color: Color(0xFF8043F9),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            width: size.width,
            height: size.height * 0.05,
            child: InkWell(
              onTap: () {
                if (_selectedCategory == null) {
                  const snackBar = SnackBar(
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.white,
                    content: Text(
                      "Please choose any category",
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                if (_formKey.currentState!.validate()) {
                  String title = _titleController.text.trim();
                  String amount = _amountController.text.trim();
                  Get.find<ExpenseController>()
                      .addExpenseData(
                          title, int.tryParse(amount)!, _selectedCategory!)
                      .then((value) {
                    Get.find<ExpenseController>().calculateTotalAmounts();
                    setState(() {});
                  });
                  Get.back();
                } else {}
              },
              child: const Center(
                  child: Text(
                'Save',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white60),
              )),
            ),
          ),
        ),
      ),
    );
  }
}
