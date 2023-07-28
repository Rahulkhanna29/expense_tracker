
import 'package:expense_tracker/controller/expenseController.dart';
import 'package:flutter/material.dart';
import 'package:mrx_charts/mrx_charts.dart';
import 'package:get/get.dart';


List<String> categories = [
  'Food',
  'Transportation',
  'Utilities',
  'Rent',
  'Health',
  'Clothing'
];

class ChartBarPage extends StatefulWidget {
  const ChartBarPage({Key? key}) : super(key: key);

  @override
  State<ChartBarPage> createState() => _ChartBarPageState();
}

class _ChartBarPageState extends State<ChartBarPage> {
  List<ChartBarDataItem> createBarDataItems(List<double> expenseValues) {
    return List.generate(categories.length, (index) {
      return ChartBarDataItem(
        color: const Color(0xFF8043F9),
        x: index + 1, // Set the x-axis value as the index + 1
        value: expenseValues[index],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxHeight: 400.0,
            maxWidth: 420.0,
          ),
          padding: const EdgeInsets.all(24.0),
          child:GetBuilder<ExpenseController>(
            builder: (controller) {
              return Chart(
                layers: layers(controller.myAllTotalData),
                padding: const EdgeInsets.symmetric(horizontal: 12.0)
                    .copyWith(bottom: 12.0, left: 15.0),
              );
            },
          ),
        ),
      ),
    );
  }

  List<ChartLayer> layers(List<double> myAllTotalData) {
    return [
      ChartAxisLayer(
        settings: ChartAxisSettings(
          x: ChartAxisSettingsAxis(
            frequency: 1.0,
            max: categories.length.toDouble(),
            // Set the max value to the number of categories
            min: 1.0,
            // Assuming the min value is 1
            textStyle: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 10.0,
            ),
          ),
          y: ChartAxisSettingsAxis(
            frequency: 100.0,
            max: 600.0,
            min: 0.0,
            textStyle: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 10.0,
            ),
          ),
        ),
        labelX: (value) => categories[value.toInt() - 1],
        // Map the x-axis value to the corresponding category
        labelY: (value) => value.toInt().toString(),
      ),
      ChartBarLayer(
        items: createBarDataItems(myAllTotalData),
        // Example expense values for each category
        settings: const ChartBarSettings(
          thickness: 14.0,
          radius: BorderRadius.all(Radius.circular(2.0)),
        ),
      ),
    ];
  }
}
