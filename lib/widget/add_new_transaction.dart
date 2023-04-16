import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  final Function? addTx;
  AddTransaction({Key? key, this.addTx}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;
  void _showDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime(2025)).then((pickDate) {
          if(pickDate==null){
            return;
          }
          setState(() {
            _selectedDate=pickDate;
          });
    });
  }

  void submitData() {
    if(amountController.text.isEmpty){
      return;
    }
    final enterTitle = titleController.text;
    final enterAmount = double.parse(amountController.text);
    if (enterTitle.isEmpty || enterAmount <= 0 || _selectedDate==null) {
      return;
    }
    widget.addTx!(enterTitle, enterAmount,_selectedDate);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom+50
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                style: TextStyle(fontSize: width * 0.04),
                controller: titleController,
                decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: TextStyle(fontSize: width * 0.045)),
                onSubmitted: (_) => submitData,
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: amountController,
                style: TextStyle(fontSize: width * 0.04),
                decoration: InputDecoration(
                    labelText: 'Amount',
                    labelStyle: TextStyle(fontSize: width * 0.045)),
                onSubmitted: (_) => submitData,
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                height: 60,
                child: Row(
                  children: [
                    Text(
                      _selectedDate == null ? "No date chosen": DateFormat.yMd().format(_selectedDate!),
                      style: TextStyle(fontSize: 22),
                    ),
                    TextButton(
                        onPressed: _showDatePicker,
                        child: Text(
                          "Choose Date",
                          style: TextStyle(
                              fontSize: 22, color: Colors.deepPurple.shade900),
                        ))
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.05, vertical: height * 0.008),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: submitData,
                    child: Text(
                      "Save",
                      style: TextStyle(fontSize: width * 0.045),
                    )),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
