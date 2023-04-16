import 'package:flutter/material.dart';
import 'package:personnel_expense_app/widget/bar_chart.dart';
import '../model/transaction_model.dart';
import 'package:intl/intl.dart';

class Charts extends StatelessWidget {
  final List<TransactionModel>? recentTransaction;

  const Charts({Key? key, this.recentTransaction}) : super(key: key);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));

      var totalSum = 0.0;
      for (var i = 0; i < recentTransaction!.length; i++) {
        if (recentTransaction![i].date?.day == weekday.day &&
            recentTransaction![i].date?.month == weekday.month &&
            recentTransaction![i].date?.year == weekday.year) {
          totalSum += recentTransaction![i].amount!;
        }
      }
      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: BarCharts(
                  label: data['day'].toString(),
                  spendingAmount: double.parse(data['amount'].toString()),
                  spendingPctAmount: totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
