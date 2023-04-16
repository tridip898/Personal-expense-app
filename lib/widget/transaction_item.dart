import 'package:flutter/material.dart';
import '../model/transaction_model.dart';
import 'package:intl/intl.dart';
import 'dart:math';
class TransactionItem extends StatefulWidget {
  final TransactionModel transactionModel;
  final Function deleteTx;
  const TransactionItem({Key? key, required this.transactionModel, required this.deleteTx}) : super(key: key);

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {

  Color? _bgColor;
  @override
  void initState() {
    const availableColor=[
      Colors.red,
      Colors.black,
      Colors.blue,
      Colors.purple
    ];
    _bgColor=availableColor[Random().nextInt(4)];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      padding: EdgeInsets.all(05),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.symmetric(
            horizontal: width * 0.04, vertical: height * 0.002),
        child: ListTile(
            leading: FittedBox(
              child: CircleAvatar(
                radius: 37,
                backgroundColor: _bgColor,
                child: Text(
                  "\$${widget.transactionModel.amount?.toStringAsFixed(1)}",
                  style: TextStyle(
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
            title: Text(
              widget.transactionModel.title.toString(),
              style: TextStyle(
                  fontSize: width * 0.05,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800),
            ),
            subtitle: Text(
              DateFormat.yMMMd('en_US')
                  .format(widget.transactionModel.date!),
              style: TextStyle(
                  fontSize: width * 0.042,
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w500),
            ),
            trailing: MediaQuery.of(context).size.width < 550
                ? IconButton(
                onPressed: () => widget.deleteTx(widget.transactionModel.id),
                icon: Icon(
                  Icons.delete,
                  size: 34,
                  color: Colors.grey,
                ))
                : ElevatedButton.icon(
                onPressed: () {
                  widget.deleteTx(widget.transactionModel.id);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0),
                icon: Icon(
                  Icons.delete,
                  color: Colors.orangeAccent,
                  size: 27,
                ),
                label: Text(
                  "Delete",
                  style: TextStyle(
                      fontSize: 20, color: Colors.orangeAccent),
                ))),
      ),
    );
  }
}
