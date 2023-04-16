import 'package:flutter/material.dart';

class BarCharts extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctAmount;
  const BarCharts(
      {Key? key,
      required this.label,
      required this.spendingAmount,
      required this.spendingPctAmount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraint){
      return Column(
        children: [
          Container(
              height: constraint.maxHeight*0.12,
              child: FittedBox(child: Text("\$${spendingAmount.toStringAsFixed(0)}"))),
          SizedBox(
              height: constraint.maxHeight*0.05,
          ),
          Container(
            height: constraint.maxHeight*0.66,
            width: constraint.maxWidth*0.35,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10))),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPctAmount,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10))),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: constraint.maxHeight*0.05,
          ),
          Container(
              height: constraint.maxHeight*0.12,
              child: FittedBox(child: Text(label)))
        ],
      );
    });
  }
}
