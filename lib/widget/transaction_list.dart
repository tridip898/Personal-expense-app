import 'package:flutter/material.dart';
import 'package:personnel_expense_app/model/transaction_model.dart';
import '../widget/transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<TransactionModel> transaction;
  final Function delete;
  TransactionList({
    Key? key,
    required this.transaction,
    required this.delete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return transaction.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "No transaction added",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                )
              ],
            ),
          )
        : ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: transaction.length,
            itemBuilder: (_, index) {
              return TransactionItem(transactionModel: transaction[index], deleteTx: delete);
            },
          );
  }
}
